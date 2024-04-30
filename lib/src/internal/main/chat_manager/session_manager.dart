// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/string_utils.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/app_session_key_update_request.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/exceptions.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/sendbird_error.dart';
import 'package:sendbird_chat_sdk/src/public/main/handler/session_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _AccessTokenRequesterImpl extends AccessTokenRequester {
  final SessionManager _sessionManager;

  _AccessTokenRequesterImpl({required SessionManager sessionManager})
      : _sessionManager = sessionManager;

  @override
  Future<void> onSuccess(String? newAccessToken) async {
    await _sessionManager._requestSessionKey(newAccessToken);
  }

  @override
  Future<void> onFail() async {
    await _sessionManager._failedToRetrieveNewAccessToken();
  }
}

class SessionManager {
  String _userIdKeyPath = 'com.sendbird.chat.user_id';
  String _sessionKeyPath = 'com.sendbird.chat.session_key';

  final List<Completer> _updateSessionKeyCompleterList = [];
  bool _isUpdatingSessionKey = false;

  final Chat _chat;
  late AccessTokenRequester accessTokenRequester;

  SessionManager({required Chat chat}) : _chat = chat {
    accessTokenRequester = _AccessTokenRequesterImpl(sessionManager: this);
  }

  // Set a `sessionKey` that will be used for SDK globally
  // This method will also encrypt this key and store in prefs
  Future<void> setSessionKey(String? sessionKey) async {
    sbLog.d(StackTrace.current);

    _chat.chatContext.sessionKey = sessionKey;
    await _encryptSessionKey(sessionKey);
  }

  Future<String?> getSessionKey() async {
    sbLog.d(StackTrace.current);

    if (_chat.chatContext.sessionKey != null) {
      return _chat.chatContext.sessionKey;
    }

    final decryptedSessionKey = await _decryptSessionKey();
    _chat.chatContext.sessionKey ??= decryptedSessionKey;
    return decryptedSessionKey;
  }

  // Set a `path` to store session key.
  // Recommend to set your own path to store this path for security purpose
  void setSessionKeyPath(String path) {
    sbLog.d(StackTrace.current, 'path: $path');
    _sessionKeyPath = path;
  }

  // Set a `path` to store user id key.
  // Recommend to set your own path to store this path for security purpose
  void setUserIdKeyPath(String path) {
    sbLog.d(StackTrace.current, 'path: $path');
    _userIdKeyPath = path;
  }

  Future<void> updateSessionKey() async {
    sbLog.d(StackTrace.current);

    setSessionKey(null);

    // If websocket exists, ws request to update session key => Check server error
    // if (_chat.connectionManager.isConnected()) {
    //   await _chat.commandManager.updateSessionKey();
    //   return;
    // }

    final completer = Completer();
    _updateSessionKeyCompleterList.add(completer);

    if (_isUpdatingSessionKey) {
      return completer.future;
    }

    final accessToken = _chat.chatContext.accessToken;

    _isUpdatingSessionKey = true;

    try {
      final res = await _chat.apiClient.send(
        AppSessionKeyUpdateRequest(
          _chat,
          appId: _chat.chatContext.appId,
          accessToken: accessToken,
        ),
      );

      _isUpdatingSessionKey = false;
      await _applyRefreshedSessionKey(res);
    } on SendbirdException catch (err) {
      sbLog.e(StackTrace.current, 'e: $err');

      _isUpdatingSessionKey = false;

      if (err.code == SendbirdError.accessTokenNotValid) {
        _chat.eventManager.notifyAccessTokenRequired();
      } else {
        _flushUpdateSessionCompleterList(e: SessionKeyRefreshFailedException());
        _chat.eventManager
            .notifySessionError(SessionKeyRefreshFailedException());
      }
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');

      _isUpdatingSessionKey = false;
      _flushUpdateSessionCompleterList(e: SessionKeyRefreshFailedException());
      _chat.eventManager.notifySessionError(SessionKeyRefreshFailedException());
    }
    return completer.future;
  }

  void cleanUp() {
    _isUpdatingSessionKey = false;
    for (final element in _updateSessionKeyCompleterList) {
      element.completeError(SendbirdException());
    }
    _updateSessionKeyCompleterList.clear();
  }

  Future<void> _encryptSessionKey(String? sessionKey) async {
    final prefs = await SharedPreferences.getInstance();

    if (sessionKey == null) {
      prefs.remove(_userIdKeyPath);
      prefs.remove(_sessionKeyPath);
      return;
    }

    final userId = _chat.chatContext.currentUserId;
    if (userId == null) {
      throw ConnectionRequiredException();
    }

    List<int> userId24Data = [];
    final userIdData = utf8.encode(userId);
    const dataLength = 24;
    if (userIdData.length >= dataLength) {
      userId24Data.addAll(userIdData.sublist(0, dataLength));
    } else {
      final randomStringData =
          utf8.encode(getRandomString(dataLength - userIdData.length));
      userId24Data
        ..addAll(userIdData)
        ..addAll(randomStringData);
    }

    String base64UserId = base64.encode(userId24Data);
    if (base64UserId.length > 16) {
      base64UserId = base64UserId.substring(0, 16);
    }
    prefs.setString(_userIdKeyPath, base64UserId);

    final key = Key.fromUtf8(base64UserId);
    final iv = IV.fromUtf8(base64UserId);
    final encrypter = Encrypter(AES(key));
    final encryptedData = encrypter.encrypt(sessionKey, iv: iv);
    prefs.setString(_sessionKeyPath, encryptedData.base64);
  }

  Future<String?> _decryptSessionKey() async {
    final prefs = await SharedPreferences.getInstance();
    final encryptedUserId = prefs.getString(_userIdKeyPath);

    if (encryptedUserId == null) {
      return null;
    }

    final key = Key.fromUtf8(encryptedUserId);
    final iv = IV.fromUtf8(encryptedUserId);
    final encrypter = Encrypter(AES(key));
    final encryptedSessionKey = prefs.getString(_sessionKeyPath);

    if (encryptedSessionKey == null) {
      return null;
    }

    return encrypter.decrypt(Encrypted.fromBase64(encryptedSessionKey), iv: iv);
  }

  // Applies refreshed session payload and reconnect if necessary
  Future<void> _applyRefreshedSessionKey(Map<String, dynamic> payload) async {
    if (payload['key'] != null) {
      await setSessionKey(payload['key']);
    } else if (payload['new_key'] != null) {
      await setSessionKey(payload['new_key']);
    }

    _flushUpdateSessionCompleterList();
    _chat.eventManager.notifySessionRefreshed();

    if (_chat.chatContext.isChatConnected) {
      await _chat.connectionManager.reconnect(reset: true); // Check
    }
  }

  void _flushUpdateSessionCompleterList({SendbirdException? e}) {
    for (final element in _updateSessionKeyCompleterList) {
      if (e != null) {
        element.completeError(e);
      } else {
        element.complete();
      }
    }
    _updateSessionKeyCompleterList.clear();
  }

  Future<void> _requestSessionKey(String? newAccessToken) async {
    _chat.chatContext.accessToken = newAccessToken;

    if (newAccessToken == null) {
      await _chat.connectionManager.disconnect(logout: true);
      _chat.eventManager.notifySessionClosed();
      return;
    }

    try {
      final res = await _chat.apiClient.send(
        AppSessionKeyUpdateRequest(
          _chat,
          appId: _chat.chatContext.appId,
          accessToken: newAccessToken,
        ),
      );

      await _applyRefreshedSessionKey(res);
    } catch (e) {
      sbLog.e(StackTrace.current, 'e: $e');

      _flushUpdateSessionCompleterList(e: SessionKeyRefreshFailedException());
      _chat.eventManager.notifySessionError(InvalidAccessTokenException());
    }
  }

  Future<void> _failedToRetrieveNewAccessToken() async {
    _chat.eventManager.notifySessionError(InvalidAccessTokenException());
    await _chat.connectionManager.disconnect(logout: false);
  }
}
