// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_get_request.dart';

/// The base message collection that handles message lists.
/// @since 4.0.3
abstract class BaseMessageCollection {
  /// The list of succeeded message list in this collection.
  List<RootMessage> get messageList;

  /// The starting point of the collection.
  int get startingPoint => _startingPoint;

  /// Whether [initialize] method is called.
  bool get isInitialized => _isInitialized;

  /// Whether there's more data to load in previous (oldest) direction.
  bool get hasPrevious => _hasPrevious;

  /// Whether there's more data to load in next (latest) direction.
  bool get hasNext => _hasNext;

  /// Whether this collection is loading.
  bool get isLoading => _isLoading;

  /// Whether this collection is disposed.
  bool get isDisposed => _isDisposed;

  /// The [MessageListParams].
  MessageListParams get params => _initializeParams;

  BaseChannel get baseChannel => _channel;

  BaseMessageCollectionHandler get baseHandler => _handler;

  set hasNext(value) => _hasNext = value;

  MessageListParams get loadPreviousParams => _loadPreviousParams;

  MessageListParams get loadNextParams => _loadNextParams;

  Chat get chat => _chat;

  RootMessage? get latestMessage => _latestMessage;

  final BaseChannel _channel;
  final BaseMessageCollectionHandler _handler;

  final MessageListParams _initializeParams;
  final MessageListParams _loadPreviousParams;
  final MessageListParams _loadNextParams;
  final int _startingPoint;
  final Chat _chat;
  bool _isInitialized = false;
  bool _isDisposed = false;
  bool _isLoading = false;
  bool _hasPrevious = false;
  bool _hasNext = false;
  RootMessage? _oldestMessage;
  RootMessage? _latestMessage;

  BaseMessageCollection({
    required BaseChannel channel,
    required MessageListParams params,
    required BaseMessageCollectionHandler handler,
    required int startingPoint,
    required Chat chat,
  })  : _channel = channel,
        _initializeParams = params,
        _loadPreviousParams = MessageListParams()..copyWith(params),
        _loadNextParams = MessageListParams()..copyWith(params),
        _handler = handler,
        _startingPoint = startingPoint,
        _chat = chat {
    sbLog.i(StackTrace.current, 'BaseMessageCollection()');
    _chat.collectionManager.addMessageCollection(this);
  }

  /// Disposes current [MessageCollection] and stops all events from being received.
  void dispose() {
    sbLog.i(StackTrace.current, 'dispose()');
    messageList.clear();
    _chat.collectionManager.removeMessageCollection(this);
    _isDisposed = true;
  }

  /// Initializes this collection from [startingPoint].
  Future<void> initialize() async {
    if (_isDisposed) return;
    if (_isInitialized) {
      throw InvalidInitializationException();
    }

    sbLog.i(StackTrace.current, 'initialize()');
    _isInitialized = true;

    _initializeParams.inclusive = true;

    final res = await _chat.apiClient
        .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
      _chat,
      channelType: ChannelType.group,
      channelUrl: _channel.channelUrl,
      params: _initializeParams.toJson(),
      timestamp: _startingPoint,
      checkingHasNext: true,
    ));
    final messages = res.messages;

    if (_isDisposed) return;

    if (messages.isNotEmpty) {
      final oldestMessage =
          _initializeParams.reverse ? messages.last : messages.first;
      final latestMessage =
          _initializeParams.reverse ? messages.first : messages.last;
      _oldestMessage = oldestMessage;
      _latestMessage = latestMessage;

      final maxCreatedAt = messages
          .reduce((current, next) =>
              current.createdAt > next.createdAt ? current : next)
          .createdAt;

      if (_startingPoint > maxCreatedAt) {
        _hasPrevious = messages.length == _initializeParams.previousResultSize;
        _hasNext = false;
      } else if (_startingPoint == 0) {
        _hasPrevious = false;
        _hasNext = messages.length == _initializeParams.nextResultSize;
      } else {
        final previousMessages =
            messages.where((e) => e.createdAt < _startingPoint).toList();
        final nextMessages =
            messages.where((e) => e.createdAt > _startingPoint).toList();

        _hasPrevious = previousMessages.length -
                _getExistedMessageCountInMessageList(previousMessages) ==
            _initializeParams.previousResultSize;
        _hasNext = nextMessages.length -
                _getExistedMessageCountInMessageList(nextMessages) ==
            _initializeParams.nextResultSize;
      }
    } else {
      _hasPrevious = false;
      _hasNext = false;
    }

    if (res.hasNext != null) _hasNext = res.hasNext!;

    if (messages.isNotEmpty) {
      _chat.collectionManager.sendEventsToMessageCollection(
        messageCollection: this,
        baseChannel: _channel,
        eventSource: CollectionEventSource.messageInitialize,
        sendingStatus: SendingStatus.succeeded,
        addedMessages: messages,
        isReversedAddedMessages: _initializeParams.reverse,
      );
    }
  }

  /// Loads previous (oldest direction) message lists.
  Future<void> loadPrevious() async {
    if (_isDisposed) {
      throw InvalidCollectionDisposedException();
    }
    if (!_isInitialized) return;

    if (_isLoading) throw QueryInProgressException();
    if (!_hasPrevious) return;
    if (_oldestMessage == null) return;

    sbLog.i(StackTrace.current, 'loadPrevious()');
    _isLoading = true;

    _loadPreviousParams
      ..nextResultSize = 0
      ..inclusive = true;

    final res = await _chat.apiClient
        .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
      _chat,
      channelType: ChannelType.group,
      channelUrl: _channel.channelUrl,
      params: _loadPreviousParams.toJson(),
      timestamp: _oldestMessage!.createdAt,
    ));
    final messages = res.messages;

    if (_isDisposed) return;

    if (messages.isNotEmpty) {
      final oldestMessage =
          _loadPreviousParams.reverse ? messages.last : messages.first;
      _oldestMessage = oldestMessage;

      _hasPrevious =
          messages.length - _getExistedMessageCountInMessageList(messages) ==
              _loadPreviousParams.previousResultSize;
    } else {
      _hasPrevious = false;
    }

    _isLoading = false;

    if (messages.isNotEmpty) {
      _chat.collectionManager.sendEventsToMessageCollection(
        messageCollection: this,
        baseChannel: baseChannel,
        eventSource: CollectionEventSource.messageLoadPrevious,
        sendingStatus: SendingStatus.succeeded,
        addedMessages: messages,
        isReversedAddedMessages:
            !_loadPreviousParams.reverse, // Added ! because of loadPrevious()
      );
    }
  }

  /// Loads next (latest direction) message lists.
  Future<void> loadNext() async {
    if (_isDisposed) {
      throw InvalidCollectionDisposedException();
    }
    if (!_isInitialized) return;

    if (_isLoading) throw QueryInProgressException();
    if (!_hasNext) return;
    if (_latestMessage == null) return;

    sbLog.i(StackTrace.current, 'loadNext()');
    _isLoading = true;

    _loadNextParams
      ..previousResultSize = 0
      ..inclusive = true;

    final res = await _chat.apiClient
        .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
      _chat,
      channelType: ChannelType.group,
      channelUrl: _channel.channelUrl,
      params: _loadNextParams.toJson(),
      timestamp: _latestMessage!.createdAt,
      checkingHasNext: true,
    ));
    final messages = res.messages;

    if (_isDisposed) return;

    if (messages.isNotEmpty) {
      final latestMessage =
          _loadNextParams.reverse ? messages.first : messages.last;
      _latestMessage = latestMessage;

      _hasNext =
          messages.length - _getExistedMessageCountInMessageList(messages) ==
              _loadNextParams.nextResultSize;
    } else {
      _hasNext = false;
    }

    if (res.hasNext != null) _hasNext = res.hasNext!;

    _isLoading = false;

    if (messages.isNotEmpty) {
      _chat.collectionManager.sendEventsToMessageCollection(
        messageCollection: this,
        baseChannel: baseChannel,
        eventSource: CollectionEventSource.messageLoadNext,
        sendingStatus: SendingStatus.succeeded,
        addedMessages: messages,
        isReversedAddedMessages: _loadNextParams.reverse,
      );
    }
  }

  bool canAddMessage(
    CollectionEventSource eventSource,
    RootMessage addedMessage,
  ) {
    if (eventSource == CollectionEventSource.messageLoadPrevious ||
        eventSource == CollectionEventSource.messageLoadNext) {
      return true;
    }

    if (messageList.isEmpty) {
      return false;
    }

    if (messageList.isNotEmpty && hasNext) {
      final a = messageList.last;
      final b = addedMessage;

      if (a.createdAt < b.createdAt) {
        return false;
      }
    }
    return true;
  }

  int _getExistedMessageCountInMessageList(List<RootMessage> loadedMessages) {
    int existedMessageCount = 0;
    for (final loadedMessage in loadedMessages) {
      for (final message in messageList) {
        if (loadedMessage.getMessageId() == message.getMessageId()) {
          existedMessageCount++;
          break;
        }
      }
    }
    return existedMessageCount;
  }
}
