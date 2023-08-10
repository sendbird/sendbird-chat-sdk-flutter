import 'dart:async';
import 'dart:convert';

import 'package:sendbird_sdk/core/models/command.dart';
import 'package:sendbird_sdk/request/general/session_key_update_request.dart';
import 'package:sendbird_sdk/sdk/internal/sendbird_sdk_accessor.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_sdk/utils/logger.dart';
import 'package:sendbird_sdk/utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart';

/// Represents a object that responsible to handle session
class SessionManager with SdkAccessor {
  String? _sessionKey;
  String? _eKey;
  String? _userId;
  String? _accessToken;
  late String _sessionKeyPath;
  late String _userIdKeyPath;

  bool isRefreshingKey = false;

  late Future Function(String) successFunc;
  late Function errorFunc;

  late List<Completer> sessionUpdateCompleters;

  SessionManager() {
    _userIdKeyPath = 'com.sendbird.sdk.messaging.userid';
    _sessionKeyPath = 'com.sendbird.sdk.messaging.sessionkey';
    successFunc = _sessionSuccessHandler;
    errorFunc = _sessionErrorHandler;
    sessionUpdateCompleters = [];
  }

  String? get accessToken => _accessToken;

  void setAccessToken(String? accessToken) {
    logger.i('Setting access token $accessToken');
    _accessToken = accessToken;
  }

  /// Set a `path` to store session key.
  /// Recommend to set your own path to store this path for security purpose
  void setSessionKeyPath(String path) {
    _sessionKeyPath = path;
  }

  /// Set a `path` to store user id key.
  /// Recommend to set your own path to store this path for security purpose
  void setUserIdKeyPath(String path) {
    _userIdKeyPath = path;
  }

  /// Set a `sessionKey` that will be used for SDK globally
  ///
  /// This method will also encrypt this key and store in prefs
  Future<void> setSessionKey(String? sessionKey) async {
    _sessionKey = sessionKey;
    await _encryptedSessionKey(sessionKey);
  }

  /// Get current `sessionKey` from prefs
  Future<String?> getSessionKey() async {
    if (_sessionKey != null) return _sessionKey;
    final decryptedKey = await _decryptedSessionKey();
    _sessionKey ??= decryptedKey;
    return decryptedKey;
  }

  /// Set a `eKey` that will be used to access file url where
  /// authorization is required
  void setEKey(String? eKey) {
    _eKey = eKey;
  }

  /// Get current `eKey`
  ///
  /// This is only existed in memory and will not be stored in
  /// persistent storage
  String? getEKey() {
    return _eKey;
  }

  /// Set a `userId` associate with this user session
  void setUserId(String userId) {
    _userId = userId;
  }

  /// Get `userId` associate with this user session
  String? getUserId() {
    return _userId;
  }

  // Decrypts session key
  Future<String?> _decryptedSessionKey() async {
    final prefs = await SharedPreferences.getInstance();
    final encryptedUserId = prefs.getString(_userIdKeyPath);

    if (encryptedUserId == null) {
      logger.e('userid is not found in prefs');
      return null;
    }

    final key = Key.fromUtf8(encryptedUserId);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    // final encryptedSessionKey = sessionPath;
    final encryptedSessionKey = prefs.getString(_sessionKeyPath);
    if (encryptedSessionKey == null) throw UnknownError();
    return encrypter.decrypt(Encrypted.fromBase64(encryptedSessionKey), iv: iv);
  }

  // Encrypts session key
  Future<void> _encryptedSessionKey(String? sessionKey) async {
    final prefs = await SharedPreferences.getInstance();
    if (sessionKey == null) {
      logger.e('Session key set to null, all paths will be removed');
      prefs.remove(_userIdKeyPath);
      prefs.remove(_sessionKeyPath);
      return;
    }

    final userId = _userId;
    if (userId == null) {
      logger.e('userId is required to encrypt session');
      throw InvalidParameterError();
    }

    var id = '';
    if (userId.length >= 24) {
      id = userId.substring(0, 24);
    } else {
      id = userId + getRandomString(24 - userId.length);
    }
    final userIdData = utf8.encode(id);
    final base64UserId = base64.encode(userIdData);
    // encryptedUserId = base64UserId;
    prefs.setString(_userIdKeyPath, base64UserId);

    final key = Key.fromUtf8(base64UserId);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encryptedData = encrypter.encrypt(sessionKey, iv: iv);
    // sessionPath = encryptedData.base64;
    prefs.setString(_sessionKeyPath, encryptedData.base64);

    logger.i(
        'encryption completed userId: $base64UserId sessionKey: $encryptedData');
  }

  // Updates session and notify
  Future<void> updateSession() async {
    // add completion
    sdk.eventManager.notifySessionExpired();

    // If websocket exists, ws request to update session key
    if (sdk.webSocket?.isConnected() == true) {
      try {
        await sdk.cmdManager
            .sendCommand(Command.buildLOGIUpdateSessionKey(_accessToken));
      } catch (e) {
        logger.e('WS LOGI extend session Error: ' + e.toString());
        throw WebSocketError(
            message: 'LOGI extend session error: ' + e.toString());
      } finally {
        return;
      }
    }

    final completer = Completer();
    sessionUpdateCompleters.add(completer);

    if (isRefreshingKey) {
      return completer.future;
    }

    final appId = sdk.state.appId;
    final accessToken = _accessToken;

    if (appId == null || accessToken == null) throw UnauthorizeError();

    final hasSessionHandler = sdk.eventManager.getSessionHandler() != null;

    isRefreshingKey = true;

    logger.i('Updating session with $_accessToken');

    try {
      final res = await sdk.api.send(
        AppSessionKeyUpdateRequest(
          appId: appId,
          accessToken: accessToken,
          expiringSession: hasSessionHandler,
        ),
      );
      isRefreshingKey = false;
      logger.i('Updated session $res');
      _applyRefreshedSessionKey(res);
      return completer.future;
    } on SBError catch (err) {
      logger.w('Failed to update session sb $err');
      isRefreshingKey = false;
      if (err.code == ErrorCode.accessTokenNotValid) {
        sdk.eventManager.notifySessionTokenRequired();
      } else {
        flushResultCompleters(SessionKeyRefreshFailedError());
        sdk.eventManager.notifySessionError(SessionKeyRefreshFailedError());
      }
      return completer.future;
    } catch (err) {
      logger.w('Failed to update session $err');
      isRefreshingKey = false;
      flushResultCompleters(SessionKeyRefreshFailedError());
      sdk.eventManager.notifySessionError(SessionKeyRefreshFailedError());
      return completer.future;
    }
  }

  // Applies refreshed session payload and reconnect if necessarry
  void _applyRefreshedSessionKey(
    Map<String, dynamic> payload,
  ) {
    if (payload['key'] != null) {
      setSessionKey(payload['key']);
    } else if (payload['new_key'] != null) {
      setSessionKey(payload['new_key']);
    }

    logger.i("Session Key Refresh Succeeded");

    flushResultCompleters(SessionKeyRefreshSucceededError());
    eventManager.notifySessionRefreshed();
    sdk.reconnect(reset: true);
  }

  // Handler for refresh session success case
  Future<void> _sessionSuccessHandler(String token) async {
    setAccessToken(token);

    final hasSessionHandler = sdk.eventManager.getSessionHandler() != null;

    try {
      final res = await sdk.api.send(AppSessionKeyUpdateRequest(
        appId: sdk.state.appId ?? '',
        accessToken: token,
        expiringSession: hasSessionHandler,
      ));
      logger.i('Updated session $res');
      _applyRefreshedSessionKey(res);
    } catch (error) {
      sdk.eventManager.notifySessionError(InvalidAccessTokenError());
      flushResultCompleters(SessionKeyRefreshFailedError());
    }
  }

  void _sessionErrorHandler() {
    final error = InvalidAccessTokenError();
    sdk.eventManager.notifySessionError(error);
  }

  void flushResultCompleters(SBError error) {
    logger.v('Flush result with $error');
    sessionUpdateCompleters.forEach((e) {
      e.completeError(error);
    });
    sessionUpdateCompleters = [];
  }

  // Resets session manager
  void cleanUp() {
    _eKey = null;
    _sessionKey = null;
    isRefreshingKey = false;
    sessionUpdateCompleters.forEach((e) {
      e.completeError(SBError());
    });
    sessionUpdateCompleters = [];
  }
}
