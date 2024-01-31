// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/db_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_get_request.dart';
import 'package:uuid/uuid.dart';

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

  set hasPrevious(value) => _hasPrevious = value;

  set hasNext(value) => _hasNext = value;

  MessageListParams get loadPreviousParams => _loadPreviousParams;

  MessageListParams get loadNextParams => _loadNextParams;

  Chat get chat => _chat;

  RootMessage? get oldestMessage => _oldestMessage;

  RootMessage? get latestMessage => _latestMessage;

  int? get oldestSyncedTimestamp => _oldestSyncedTimestamp;

  int? get latestSyncedTimestamp => _latestSyncedTimestamp;

  String get collectionId => _collectionId;

  final BaseChannel _channel;
  final BaseMessageCollectionHandler _handler;

  final MessageListParams _initializeParams;
  final MessageListParams _loadPreviousParams;
  final MessageListParams _loadNextParams;
  final int _startingPoint;
  final String _collectionId;

  final Chat _chat;
  bool _isInitialized = false;
  bool _isDisposed = false;
  bool _isLoading = false;
  bool _hasPrevious = false;
  bool _hasNext = false;

  RootMessage? _oldestMessage;
  RootMessage? _latestMessage;

  //+ [DBManager]
  int? _oldestSyncedTimestamp;
  int? _latestSyncedTimestamp;

  //- [DBManager]

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
        _collectionId = const Uuid().v1(),
        _chat = chat {
    sbLog.i(StackTrace.current, 'BaseMessageCollection()');
    _chat.collectionManager.addMessageCollection(this);

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      _chat.dbManager.hasMessages(baseChannel.channelUrl).then((hasMessages) {
        if (hasMessages) {
          runZonedGuarded(() {
            _chat.collectionManager.refreshBaseMessageCollection(
                this); // Do not await for performance
          }, (error, stack) {});
        }
      });
    }
    //- [DBManager]
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
    if (_isDisposed) throw InvalidCollectionDisposedException();
    if (_isInitialized) throw InvalidInitializationException();

    sbLog.i(StackTrace.current, 'initialize()');
    _isInitialized = true;

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      _oldestSyncedTimestamp = null;
      _latestSyncedTimestamp = null;
    }
    //- [DBManager]

    //+ [DBManager]
    bool isCacheHit = false;
    final List<RootMessage> localMessages = [];

    if (_chat.dbManager.isEnabled()) {
      final localInitializeParams = MessageListParams()
        ..copyWith(_initializeParams);

      final localPreviousMessages = await _chat.dbManager.getMessages(
        channelType: _channel.channelType,
        channelUrl: _channel.channelUrl,
        sendingStatus: SendingStatus.succeeded,
        timestamp: _startingPoint,
        params: localInitializeParams..inclusive = false,
        isPrevious: true,
      );

      List<RootMessage> localStartingPointMessages = [];
      if (_initializeParams.inclusive) {
        final messages = await _chat.dbManager.getStartingPointMessages(
          channelType: _channel.channelType,
          channelUrl: _channel.channelUrl,
          timestamp: _startingPoint,
        );
        localStartingPointMessages.addAll(messages);
      }

      final localNextMessages = await _chat.dbManager.getMessages(
        channelType: _channel.channelType,
        channelUrl: _channel.channelUrl,
        sendingStatus: SendingStatus.succeeded,
        timestamp: _startingPoint,
        params: localInitializeParams..inclusive = false,
        isPrevious: false,
      );

      if (_initializeParams.reverse) {
        localMessages.addAll(localNextMessages);
        localMessages.addAll(localStartingPointMessages);
        localMessages.addAll(localPreviousMessages);
      } else {
        localMessages.addAll(localPreviousMessages);
        localMessages.addAll(localStartingPointMessages);
        localMessages.addAll(localNextMessages);
      }

      isCacheHit = await _chat.dbManager.isCacheHit(
        collection: this,
        params: _initializeParams,
        localMessages: localMessages,
        lastSyncedTimeStamp: null,
        loadType: MessageCollectionLoadType.initialize,
      );

      _setValuesForInitialize(
          messages: localMessages, noMoreApiCall: isCacheHit);

      if (localMessages.isNotEmpty) {
        await _chat.collectionManager.sendEventsToMessageCollection(
          messageCollection: this,
          baseChannel: _channel,
          eventSource: CollectionEventSource.messageCacheInitialize,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: localMessages,
          isReversedAddedMessages: _initializeParams.reverse,
        );
      }

      _initializeParams.includeMetaArray = true;
      _initializeParams.includeReactions = true;
      _initializeParams.includeThreadInfo = true;
      _initializeParams.includeParentMessageInfo = true;
    }
    //- [DBManager]

    List<RootMessage> messages = [];
    ChannelMessagesGetResponse? res;

    if (isCacheHit == false) {
      try {
        res = await _chat.apiClient
            .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
          _chat,
          channelType: ChannelType.group,
          channelUrl: _channel.channelUrl,
          params: _initializeParams.toJson(),
          timestamp: _startingPoint,
          checkingHasNext: true,
          checkingContinuousMessages:
              _chat.dbManager.isEnabled(), // [DBManager]
        ));

        messages.addAll(res.messages);
      } catch (_) {}
    }

    if (_isDisposed) {
      return;
    }

    if (res != null) {
      _setValuesForInitialize(messages: messages, noMoreApiCall: true);
    }

    if (res?.hasNext != null) _hasNext = res!.hasNext!;

    if (messages.isNotEmpty) {
      //+ [DBManager]
      if (_chat.dbManager.isEnabled()) {
        final List<RootMessage> addedMessages = [...messages];
        final Set<String> deletedMessageIds =
            messageList.map((message) => message.rootId).toSet();

        await _chat.collectionManager.sendEventsToMessageCollection(
          messageCollection: this,
          baseChannel: _channel,
          eventSource: CollectionEventSource.messageInitialize,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: addedMessages,
          isReversedAddedMessages: _initializeParams.reverse,
          isContinuousAddedMessages: (_channel.channelType == ChannelType.feed)
              ? true
              : (res?.isContinuous ?? false),
          deletedMessageIds: deletedMessageIds.toList(),
        );
      }
      //- [DBManager]
      else {
        await _chat.collectionManager.sendEventsToMessageCollection(
          messageCollection: this,
          baseChannel: _channel,
          eventSource: CollectionEventSource.messageInitialize,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: messages,
          isReversedAddedMessages: _initializeParams.reverse,
        );
      }
    }

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      // Failed messages
      final failedMessages = await _chat.dbManager.getFailedMessages(
        channelType: _channel.channelType,
        channelUrl: _channel.channelUrl,
        reverse: _initializeParams.reverse,
      );

      if (failedMessages.isNotEmpty) {
        await _chat.collectionManager.sendEventsToMessageCollection(
          messageCollection: this,
          baseChannel: _channel,
          eventSource: CollectionEventSource.messageCacheInitialize,
          sendingStatus: SendingStatus.failed,
          addedMessages: failedMessages,
          isReversedAddedMessages: _initializeParams.reverse,
        );
      }
    }
    //- [DBManager]
  }

  void _setValuesForInitialize({
    required List<RootMessage> messages,
    required bool noMoreApiCall,
  }) {
    if (messages.isNotEmpty) {
      _oldestMessage =
          _initializeParams.reverse ? messages.last : messages.first;
      _latestMessage =
          _initializeParams.reverse ? messages.first : messages.last;

      //+ [DBManager]
      if (_chat.dbManager.isEnabled()) {
        if (noMoreApiCall) {
          _oldestSyncedTimestamp = _oldestMessage!.createdAt;
          _latestSyncedTimestamp = _latestMessage!.createdAt;
        }
      }
      //- [DBManager]

      if (noMoreApiCall || !_chat.connectionManager.isConnected()) {
        final maxCreatedAt = messages
            .reduce((current, next) =>
                current.createdAt > next.createdAt ? current : next)
            .createdAt;

        if (_startingPoint > maxCreatedAt) {
          _hasPrevious =
              messages.length == _initializeParams.previousResultSize;
          _hasNext = false;
        } else if (_startingPoint == 0) {
          _hasPrevious = false;
          _hasNext = messages.length == _initializeParams.nextResultSize;
        } else {
          final previousMessages =
              messages.where((e) => e.createdAt < _startingPoint).toList();
          final nextMessages =
              messages.where((e) => e.createdAt > _startingPoint).toList();

          _hasPrevious =
              (previousMessages.length == _initializeParams.previousResultSize);
          _hasNext = (nextMessages.length == _initializeParams.nextResultSize);
        }
      }
    } else {
      if (noMoreApiCall || !_chat.connectionManager.isConnected()) {
        _hasPrevious = false;
        _hasNext = false;
      }
    }
  }

  /// Loads previous (oldest direction) message lists.
  Future<void> loadPrevious() async {
    sbLog.i(StackTrace.current, 'loadPrevious()');
    await _loadMore(isPrevious: true);
  }

  /// Loads next (latest direction) message lists.
  Future<void> loadNext() async {
    sbLog.i(StackTrace.current, 'loadNext()');
    await _loadMore(isPrevious: false);
  }

  Future<void> _loadMore({
    required bool isPrevious,
  }) async {
    if (_isDisposed) throw InvalidCollectionDisposedException();
    if (!_isInitialized) return;
    if (_isLoading) throw QueryInProgressException();

    if (isPrevious) {
      if (!_hasPrevious) return;
      if (_oldestMessage == null) return;
    } else {
      if (!_hasNext) return;
      if (_latestMessage == null) return;
    }

    _isLoading = true;

    if (isPrevious) {
      _loadPreviousParams
        ..nextResultSize = 0
        ..inclusive = true;
    } else {
      _loadNextParams
        ..nextResultSize = (_loadNextParams.nextResultSize != 0
            ? _loadNextParams.nextResultSize
            : _loadNextParams.previousResultSize) // Check
        ..previousResultSize = 0
        ..inclusive = true;
    }

    final timestamp = isPrevious
        ? (_oldestMessage?.createdAt ?? _startingPoint)
        : (_latestMessage?.createdAt ?? _startingPoint);

    //+ [DBManager]
    bool isCacheHit = false;
    List<RootMessage> localMessages = [];
    List<RootMessage> targetMessages = [...messageList];

    if (_chat.dbManager.isEnabled()) {
      final messages = await _chat.dbManager.getMessages(
        channelType: _channel.channelType,
        channelUrl: _channel.channelUrl,
        sendingStatus: SendingStatus.succeeded,
        timestamp: timestamp,
        params: isPrevious
            ? (_loadPreviousParams..inclusive = false)
            : (_loadNextParams..inclusive = false),
        isPrevious: isPrevious,
      );
      localMessages.addAll(messages);

      isCacheHit = await _chat.dbManager.isCacheHit(
        collection: this,
        params: isPrevious ? _loadPreviousParams : _loadNextParams,
        localMessages: localMessages,
        lastSyncedTimeStamp:
            isPrevious ? _oldestSyncedTimestamp : _latestSyncedTimestamp,
        loadType: isPrevious
            ? MessageCollectionLoadType.loadPrevious
            : MessageCollectionLoadType.loadNext,
      );

      if (isPrevious) {
        _setValuesForLoadPrevious(
          messages: localMessages,
          targetMessages: targetMessages,
          noMoreApiCall: isCacheHit,
        );
      } else {
        _setValuesForLoadNext(
          messages: localMessages,
          targetMessages: targetMessages,
          noMoreApiCall: isCacheHit,
        );
      }

      if (localMessages.isNotEmpty) {
        await _chat.collectionManager.sendEventsToMessageCollection(
            messageCollection: this,
            baseChannel: baseChannel,
            eventSource: isPrevious
                ? CollectionEventSource.messageCacheLoadPrevious
                : CollectionEventSource.messageCacheLoadNext,
            sendingStatus: SendingStatus.succeeded,
            addedMessages: localMessages,
            isReversedAddedMessages: isPrevious
                ? !_loadPreviousParams
                    .reverse // Added ! because of loadPrevious()
                : _loadNextParams.reverse);
      }

      if (isPrevious) {
        _loadPreviousParams.includeMetaArray = true;
        _loadPreviousParams.includeReactions = true;
        _loadPreviousParams.includeThreadInfo = true;
        _loadPreviousParams.includeParentMessageInfo = true;
      } else {
        _loadNextParams.includeMetaArray = true;
        _loadNextParams.includeReactions = true;
        _loadNextParams.includeThreadInfo = true;
        _loadNextParams.includeParentMessageInfo = true;
      }
    }
    //- [DBManager]

    List<RootMessage> messages = [];
    bool? hasNext;
    ChannelMessagesGetResponse? res;

    if (isCacheHit == false) {
      try {
        res = await _chat.apiClient
            .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
          _chat,
          channelType: ChannelType.group,
          channelUrl: _channel.channelUrl,
          params: isPrevious
              ? (_loadPreviousParams..inclusive = true).toJson()
              : (_loadNextParams..inclusive = true).toJson(),
          timestamp: timestamp,
          checkingHasNext: !isPrevious,
          checkingContinuousMessages:
              _chat.dbManager.isEnabled(), // [DBManager]
        ));

        messages.addAll(res.messages);
        hasNext = res.hasNext;
      } catch (_) {}
    }

    if (_isDisposed) {
      _isLoading = false;
      return;
    }

    if (res != null) {
      if (isPrevious) {
        _setValuesForLoadPrevious(
          messages: messages,
          targetMessages: targetMessages,
          noMoreApiCall: true,
        );
      } else {
        _setValuesForLoadNext(
          messages: messages,
          targetMessages: targetMessages,
          noMoreApiCall: true,
        );
      }
    }
    if (hasNext != null) _hasNext = hasNext;

    if (messages.isNotEmpty) {
      //+ [DBManager]
      if (_chat.dbManager.isEnabled()) {
        final List<RootMessage> addedMessages = [...messages];
        final Set<String> deletedMessageIds =
            localMessages.map((message) => message.rootId).toSet();

        await _chat.collectionManager.sendEventsToMessageCollection(
          messageCollection: this,
          baseChannel: baseChannel,
          eventSource: isPrevious
              ? CollectionEventSource.messageLoadPrevious
              : CollectionEventSource.messageLoadNext,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: addedMessages,
          isReversedAddedMessages: isPrevious
              ? !_loadPreviousParams
                  .reverse // Added ! because of loadPrevious()
              : _loadNextParams.reverse,
          isContinuousAddedMessages: (_channel.channelType == ChannelType.feed)
              ? true
              : (res?.isContinuous ?? false),
          deletedMessageIds: deletedMessageIds.toList(),
        );
      }
      //- [DBManager]
      else {
        await _chat.collectionManager.sendEventsToMessageCollection(
          messageCollection: this,
          baseChannel: baseChannel,
          eventSource: isPrevious
              ? CollectionEventSource.messageLoadPrevious
              : CollectionEventSource.messageLoadNext,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: messages,
          isReversedAddedMessages: isPrevious
              ? !_loadPreviousParams
                  .reverse // Added ! because of loadPrevious()
              : _loadNextParams.reverse,
        );
      }
    }

    _isLoading = false;
  }

  void _setValuesForLoadPrevious({
    required List<RootMessage> messages,
    required List<RootMessage> targetMessages,
    required bool noMoreApiCall,
  }) {
    if (messages.isNotEmpty) {
      _oldestMessage =
          _loadPreviousParams.reverse ? messages.last : messages.first;

      //+ [DBManager]
      if (_chat.dbManager.isEnabled()) {
        if (noMoreApiCall) {
          _oldestSyncedTimestamp = _oldestMessage!.createdAt;
        }
      }
      //- [DBManager]

      if (noMoreApiCall || !_chat.connectionManager.isConnected()) {
        final count = _getExistedMessageCountInMessageList(
            loadedMessages: messages, targetMessages: targetMessages);
        _hasPrevious =
            messages.length - count == _loadPreviousParams.previousResultSize;
      }
    } else {
      if (noMoreApiCall || !_chat.connectionManager.isConnected()) {
        _hasPrevious = false;
      }
    }
  }

  void _setValuesForLoadNext({
    required List<RootMessage> messages,
    required List<RootMessage> targetMessages,
    required bool noMoreApiCall,
  }) {
    if (messages.isNotEmpty) {
      _latestMessage = _loadNextParams.reverse ? messages.first : messages.last;

      //+ [DBManager]
      if (_chat.dbManager.isEnabled()) {
        if (noMoreApiCall) {
          _latestSyncedTimestamp = _latestMessage!.createdAt;
        }
      }
      //- [DBManager]

      if (noMoreApiCall || !_chat.connectionManager.isConnected()) {
        final count = _getExistedMessageCountInMessageList(
            loadedMessages: messages, targetMessages: targetMessages);
        _hasNext = messages.length - count == _loadNextParams.nextResultSize;
      }
    } else {
      if (noMoreApiCall || !_chat.connectionManager.isConnected()) {
        _hasNext = false;
      }
    }
  }

  int _getExistedMessageCountInMessageList({
    required List<RootMessage> loadedMessages,
    required List<RootMessage> targetMessages,
  }) {
    int existedMessageCount = 0;
    for (final loadedMessage in loadedMessages) {
      for (final message in targetMessages) {
        if (loadedMessage.getMessageId() == message.getMessageId()) {
          existedMessageCount++;
          break;
        }
      }
    }
    return existedMessageCount;
  }

  void setValuesFromMessageList() {
    if (messageList.isNotEmpty) {
      _oldestMessage =
          _loadPreviousParams.reverse ? messageList.last : messageList.first;
      _latestMessage =
          _loadNextParams.reverse ? messageList.first : messageList.last;

      _oldestSyncedTimestamp = _oldestMessage!.createdAt;
      _latestSyncedTimestamp = _latestMessage!.createdAt;
    }
  }

  void sort() {
    if (params.reverse) {
      messageList.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });
    } else {
      messageList.sort((a, b) {
        return a.createdAt.compareTo(b.createdAt);
      });
    }
  }

  bool canAddMessage(
    CollectionEventSource eventSource,
    RootMessage addedMessage,
  ) {
    if (eventSource == CollectionEventSource.messageCacheInitialize ||
        eventSource == CollectionEventSource.messageCacheLoadPrevious ||
        eventSource == CollectionEventSource.messageCacheLoadNext ||
        eventSource == CollectionEventSource.messageInitialize ||
        eventSource == CollectionEventSource.messageLoadPrevious ||
        eventSource == CollectionEventSource.messageLoadNext ||
        eventSource == CollectionEventSource.messageFill ||
        eventSource == CollectionEventSource.localMessagePendingCreated ||
        eventSource == CollectionEventSource.localMessageFailed ||
        eventSource == CollectionEventSource.localMessageCanceled ||
        eventSource == CollectionEventSource.localMessageResendStarted) {
      return true;
    }

    if (_isInitialized == false) {
      return false;
    }

    // hasPrevious
    if (hasPrevious) {
      if (messageList.isNotEmpty) {
        if (addedMessage.createdAt < messageList.first.createdAt) {
          return false;
        }
      }
    }

    // hasNext
    if (hasNext) {
      if (messageList.isNotEmpty) {
        if (addedMessage.createdAt > messageList.first.createdAt) {
          return false;
        }
      }
    }

    // [Filter] messageType
    switch (params.messageType) {
      case MessageTypeFilter.all:
        break;
      case MessageTypeFilter.user:
        if (addedMessage.messageType == MessageType.file ||
            addedMessage.messageType == MessageType.admin ||
            addedMessage.messageType == MessageType.notification) {
          return false;
        }
        break;
      case MessageTypeFilter.file:
        if (addedMessage.messageType == MessageType.user ||
            addedMessage.messageType == MessageType.admin ||
            addedMessage.messageType == MessageType.notification) {
          return false;
        }
        break;
      case MessageTypeFilter.admin:
        if (addedMessage.messageType == MessageType.user ||
            addedMessage.messageType == MessageType.file ||
            addedMessage.messageType == MessageType.notification) {
          return false;
        }
        break;
    }

    // [Filter] customTypes
    if (params.customTypes != null && params.customTypes!.isNotEmpty) {
      bool found = false;
      for (final customType in params.customTypes!) {
        if (addedMessage.customType == customType) {
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }
    }

    // [Filter] senderIds
    if (addedMessage is BaseMessage &&
        params.senderIds != null &&
        params.customTypes!.isNotEmpty) {
      bool found = false;
      for (final senderId in params.senderIds!) {
        if (addedMessage.sender?.userId == senderId) {
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }
    }

    return true;
  }

  bool canUpdateMessage(
    CollectionEventSource eventSource,
    RootMessage originalMessage,
    RootMessage updatedMessage,
  ) {
    bool canUpdate = false;

    if (!canAddMessage(eventSource, updatedMessage)) {
      return false;
    }

    if (eventSource == CollectionEventSource.pollChangeLogs ||
        eventSource == CollectionEventSource.eventPollVoted ||
        eventSource == CollectionEventSource.eventPollUpdated) {
      if (originalMessage is UserMessage &&
          originalMessage.poll != null &&
          updatedMessage is UserMessage &&
          updatedMessage.poll != null &&
          originalMessage.poll!.updatedAt <= updatedMessage.poll!.updatedAt) {
        canUpdate = true;
      }
    } else if (eventSource == CollectionEventSource.eventReactionUpdated) {
      // Check updatedAt (?)
      canUpdate = true;
    } else if (eventSource == CollectionEventSource.eventThreadInfoUpdated) {
      // Check updatedAt (?)
      canUpdate = true;
    } else if (originalMessage.updatedAt < updatedMessage.updatedAt) {
      canUpdate = true;
    } else if (updatedMessage is BaseMessage &&
        (updatedMessage.sendingStatus == SendingStatus.failed ||
            updatedMessage.sendingStatus == SendingStatus.pending)) {
      canUpdate = true;
    }

    return canUpdate;
  }

  /// Sends mark as read to this channel.
  /// This method has to be called in [MessageCollectionHandler.onMessagesAdded] or [NotificationCollectionHandler.onMessagesAdded].
  /// @since 4.2.0
  Future<void> markAsRead(BaseMessageContext context) async {
    sbLog.i(StackTrace.current);

    // 1. hasNext == false
    if (hasNext == false) {
      // 2. No filters
      if (params.messageType == MessageTypeFilter.all &&
          params.customTypes == null &&
          params.senderIds == null &&
          params.showSubChannelMessagesOnly == false) {
        // 3. Check collectionEventSource
        if (context.collectionEventSource.isFromEvent ||
            context.collectionEventSource ==
                CollectionEventSource.messageInitialize ||
            context.collectionEventSource ==
                CollectionEventSource.messageFill) {
          if (baseChannel is GroupChannel) {
            (baseChannel as GroupChannel).markAsRead();
          } else if (baseChannel is FeedChannel) {
            (baseChannel as FeedChannel).markAsRead();
          }
        }
      }
    }
  }
}
