// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'collection_manager.dart';

extension MessageCollectionManager on CollectionManager {
//------------------------------//
// Add and remove message collection
//------------------------------//
  void addMessageCollection(BaseMessageCollection collection) {
    sbLog.d(
        StackTrace.current, 'channelUrl: ${collection.baseChannel.channelUrl}');

    baseMessageCollections.add(collection);
    _setInitialMessageChangeLogsAndMessagesGapTs();
  }

  void removeMessageCollection(BaseMessageCollection collection) {
    sbLog.d(
        StackTrace.current, 'channelUrl: ${collection.baseChannel.channelUrl}');

    baseMessageCollections.remove(collection);
  }

//------------------------------//
// Clean up
//------------------------------//
  void cleanUpMessageCollections() {
    for (final messageCollection in baseMessageCollections) {
      messageCollection.cleanUp();
    }
  }

  void disposeMessageCollection(String channelUrl) {
    for (final messageCollection in baseMessageCollections) {
      if (messageCollection.baseChannel.channelUrl == channelUrl) {
        messageCollection.cleanUp();
      }
    }
  }

//------------------------------//
// My mute info
//------------------------------//
  void setUnmuteTimer(GroupChannel channel, int remainingDuration) {
    for (final messageCollection in baseMessageCollections) {
      if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
        messageCollection.setUnmuteTimer(remainingDuration);
        break;
      }
    }
  }

//------------------------------//
// onMessageSentByMe
//------------------------------//
  void onMessageSentByMe({
    required BaseChannel channel,
    required BaseMessage pendingMessage,
    required RootMessage sentMessage,
  }) async {
    sbLog.d(StackTrace.current);

    for (final messageCollection in baseMessageCollections) {
      if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
        sendEventsToMessageCollection(
          messageCollection: messageCollection,
          baseChannel: messageCollection.baseChannel,
          eventSource: CollectionEventSource.eventMessageSent,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: [sentMessage],
          isReversedAddedMessages: messageCollection.params.reverse,
          deletedRequestIdForPendingMessage: pendingMessage.requestId,
          doNotSendDeleteEvent: true,
        );
      }
    }

    if (channel is GroupChannel) {
      sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventMessageSent,
        addedChannels: [channel],
      );
    }
  }

//------------------------------//
// updateMessageOffset
//------------------------------//
  Future<bool> updateMessageOffset({
    required String channelUrl,
    required int messageOffset,
  }) async {
    sbLog.d(StackTrace.current);

    for (final collection in baseMessageCollections) {
      if (collection is MessageCollection) {
        if (collection.isInitialized) {
          if (collection.baseChannel.channelUrl == channelUrl) {
            await collection.updateMessageOffset(
              channelUrl: channelUrl,
              messageOffset: messageOffset,
            );
            return true;
          }
        }
      }
    }
    return false;
  }

//------------------------------//
// Message changeLogs
//------------------------------//
  Future<void> _requestMessageChangeLogs(
      BaseMessageCollection messageCollection) async {
    sbLog.d(StackTrace.current,
        'channelUrl: ${messageCollection.baseChannel.channelUrl}');

    final channel = messageCollection.baseChannel;
    final params = MessageChangeLogParams();
    final List<RootMessage> updatedMessages = [];
    final List<dynamic> deletedMessageIds = [];

    MessageChangeLogs changeLogs;
    String? lastToken;
    String? token;

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      final info =
          await _chat.dbManager.getMessageChangeLogInfo(channel.channelUrl);
      if (info != null) {
        lastToken = info.lastMessageToken;
        token = lastToken;
      }
    } else {
      token = lastRequestTokenForMessageChangeLogs; // For web without db
    }
    //- [DBManager]

    do {
      if (token == null) {
        changeLogs = await channel.getMessageChangeLogs(
          params,
          timestamp: lastRequestTsForMessageChangeLogs,
        );
      } else {
        changeLogs = await channel.getMessageChangeLogs(
          params,
          token: token,
        );
      }

      updatedMessages.addAll(changeLogs.updatedMessages);
      deletedMessageIds.addAll(changeLogs.deletedMessageIds);

      token = changeLogs.token;
    } while (changeLogs.hasMore);

    //+ [DBManager]
    if (token != null && token.isNotEmpty && token != lastToken) {
      if (_chat.dbManager.isEnabled()) {
        MessageChangeLogInfo? info =
            await _chat.dbManager.getMessageChangeLogInfo(channel.channelUrl);
        if (info != null) {
          info.lastMessageToken = token;
        } else {
          info = MessageChangeLogInfo(
            channelUrl: channel.channelUrl,
            lastMessageToken: token,
          );
        }
        await _chat.dbManager.upsertMessageChangeLogInfo(info);
      } else {
        lastRequestTokenForMessageChangeLogs = token;
      }
    }
    //- [DBManager]

    if (updatedMessages.isNotEmpty || deletedMessageIds.isNotEmpty) {
      sendEventsToMessageCollection(
        messageCollection: messageCollection,
        baseChannel: channel,
        eventSource: CollectionEventSource.messageChangeLogs,
        sendingStatus: SendingStatus.succeeded,
        updatedMessages: updatedMessages,
        deletedMessageIds: deletedMessageIds,
      );
    }
  }

//------------------------------//
// Poll changeLogs
//------------------------------//
  Future<void> _requestPollChangeLogs(
      BaseMessageCollection messageCollection) async {
    sbLog.d(StackTrace.current,
        'channelUrl: ${messageCollection.baseChannel.channelUrl}');

    if (_chat.chatContext.appInfo == null ||
        _chat.chatContext.appInfo!.premiumFeatureList.contains('poll') ==
            false) {
      return;
    }

    if (messageCollection.baseChannel is! GroupChannel) {
      return;
    }

    final groupChannel = messageCollection.baseChannel as GroupChannel;
    final List<RootMessage> updatedMessages = [];
    final List<dynamic> deletedMessageIds = [];

    PollChangeLogs changeLogs;
    String? lastToken;
    String? token;

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      final info = await _chat.dbManager
          .getMessageChangeLogInfo(groupChannel.channelUrl);
      if (info != null) {
        lastToken = info.lastPollToken;
        token = lastToken;
      }
    } else {
      token = lastRequestTokenForPollChangeLogs; // For web without db
    }
    //- [DBManager]

    do {
      if (token == null) {
        changeLogs = await groupChannel.getPollChangeLogsSinceTimestamp(
          lastRequestTsForPollChangeLogs,
        );
      } else {
        changeLogs = await groupChannel.getPollChangeLogsSinceToken(
          token,
        );
      }

      if (changeLogs.updatedPolls != null &&
          changeLogs.updatedPolls!.isNotEmpty) {
        for (final poll in changeLogs.updatedPolls!) {
          for (final message in messageCollection.messageList) {
            if (message.getMessageId() == poll.messageId) {
              updatedMessages.add(message);
              break;
            }
          }
        }
      }

      // changeLogs.deletedPollIds => changeLogs.deletedMessageIds

      token = changeLogs.token;
    } while (changeLogs.hasMore);

    //+ [DBManager]
    if (token != null && token.isNotEmpty && token != lastToken) {
      if (_chat.dbManager.isEnabled()) {
        MessageChangeLogInfo? info = await _chat.dbManager
            .getMessageChangeLogInfo(groupChannel.channelUrl);
        if (info != null) {
          info.lastPollToken = token;
        } else {
          info = MessageChangeLogInfo(
            channelUrl: groupChannel.channelUrl,
            lastPollToken: token,
          );
        }
        await _chat.dbManager.upsertMessageChangeLogInfo(info);
      } else {
        lastRequestTokenForPollChangeLogs = token;
      }
    }
    //- [DBManager]

    if (updatedMessages.isNotEmpty || deletedMessageIds.isNotEmpty) {
      sendEventsToMessageCollection(
        messageCollection: messageCollection,
        baseChannel: groupChannel,
        eventSource: CollectionEventSource.pollChangeLogs,
        sendingStatus: SendingStatus.succeeded,
        updatedMessages: updatedMessages,
        deletedMessageIds: deletedMessageIds,
      );
    }
  }

//------------------------------//
// Messages gap
//------------------------------//
  Future<void> _requestMessagesGap(
    BaseMessageCollection messageCollection,
  ) async {
    sbLog.d(StackTrace.current,
        'channelUrl: ${messageCollection.baseChannel.channelUrl}');

    final List<String> deletedPrevMessageIds = [];
    final List<String> deletedNextMessageIds = [];

    int? prevStartTs = messageCollection.oldestMessage?.createdAt;
    int? prevEndTs = messageCollection.oldestSyncedTimestamp ?? prevStartTs;
    int prevCacheCount = messageCollection.messageList.where((message) {
      if (prevStartTs != null &&
          message.createdAt >= prevStartTs &&
          prevEndTs != null &&
          message.createdAt <= prevEndTs) {
        if (message is! BaseMessage ||
            message.sendingStatus == SendingStatus.succeeded) {
          deletedPrevMessageIds.add(message.rootId);
          return true;
        }
      }
      return false;
    }).length;

    int? nextEndTs = messageCollection.latestMessage?.createdAt;
    int? nextStartTs = messageCollection.latestSyncedTimestamp ?? nextEndTs;
    int nextCacheCount = messageCollection.messageList.where((message) {
      if (nextStartTs != null &&
          message.createdAt >= nextStartTs &&
          nextEndTs != null &&
          message.createdAt <= nextEndTs) {
        if (message is! BaseMessage ||
            message.sendingStatus == SendingStatus.succeeded) {
          deletedNextMessageIds.add(message.rootId);
          return true;
        }
      }
      return false;
    }).length;

    nextStartTs ??= messageCollection.latestMessage?.createdAt ??
        lastRequestTsForMessagesGap;
    prevStartTs ??= nextStartTs;
    prevEndTs ??= nextStartTs;
    nextEndTs ??= nextStartTs;

    final res = await _chat.apiClient.send<ChannelMessagesGapResponse>(
      ChannelMessagesGapRequest(
        _chat,
        channelType: ChannelType.group,
        channelUrl: messageCollection.baseChannel.channelUrl,
        messageListParams: messageCollection.params.toJson(),
        prevStartTs: prevStartTs,
        prevEndTs: prevEndTs,
        prevCacheCount: prevCacheCount,
        nextStartTs: nextStartTs,
        nextEndTs: messageCollection.hasNext ? nextEndTs : SendbirdChat.maxInt,
        nextCacheCount: nextCacheCount,
        checkingContinuousMessages: _chat.dbManager.isEnabled(), // [DBManager]
      ),
    );

    if (res.isHugeGap) {
      messageCollection.hasNext = true;

      if (!messageCollection.isDisposed) {
        if (messageCollection.baseHandler is MessageCollectionHandler) {
          (messageCollection.baseHandler as MessageCollectionHandler)
              .onHugeGapDetected();
        } else if (messageCollection.baseHandler
            is NotificationCollectionHandler) {
          (messageCollection.baseHandler as NotificationCollectionHandler)
              .onHugeGapDetected();
        }
      }
    } else {
      final List<RootMessage> prevMessages = [...res.prevMessages];
      final List<RootMessage> nextMessages = [...res.nextMessages];

      if (prevMessages.isNotEmpty &&
          res.prevHasMore != null &&
          res.prevHasMore!) {
        // Fill messages from latestTs to oldestTs
        final oldestTs = prevStartTs;
        int latestTs = prevMessages.map((message) => message.createdAt).min;

        const resultSize = 100;
        final params = MessageListParams()
          ..previousResultSize = resultSize
          ..nextResultSize = 0
          ..inclusive = true;

        bool hasPrevious = false;
        int maxCount = 5;
        bool repeat = false;
        do {
          ChannelMessagesGetResponse? res = await _chat.apiClient
              .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
            _chat,
            channelType: ChannelType.group,
            channelUrl: messageCollection.baseChannel.channelUrl,
            params: params.toJson(),
            timestamp: latestTs,
            checkingHasNext: false,
            checkingContinuousMessages: false,
          ));

          if (res.messages.isNotEmpty) {
            hasPrevious = (res.messages.length == resultSize);

            for (int i = res.messages.length - 1; i >= 0; i--) {
              final message = res.messages[i];
              if (message.createdAt >= oldestTs) {
                bool found = false;
                for (final prevMessage in prevMessages) {
                  if (prevMessage.rootId == message.rootId) {
                    found = true;
                    break;
                  }
                }
                if (!found) {
                  prevMessages.insert(0, message);
                }
              } else {
                hasPrevious = false;
              }
            }

            if (hasPrevious) {
              latestTs = prevMessages.map((message) => message.createdAt).min;
            }
          }

          maxCount--;
          repeat = (hasPrevious && maxCount > 0);
          if (repeat) {
            await Future.delayed(const Duration(milliseconds: 200));
          }
        } while (repeat);
      }

      if (nextMessages.isNotEmpty &&
          res.nextHasMore != null &&
          res.nextHasMore!) {
        // Fill messages forward starting from oldestTs until there are no more next messages
        int oldestTs = nextMessages.map((message) => message.createdAt).max;

        const resultSize = 100;
        final params = MessageListParams()
          ..previousResultSize = 0
          ..nextResultSize = resultSize
          ..inclusive = true;

        bool hasNext = false;
        int maxCount = 5;
        bool repeat = false;
        do {
          ChannelMessagesGetResponse? res = await _chat.apiClient
              .send<ChannelMessagesGetResponse>(ChannelMessagesGetRequest(
            _chat,
            channelType: ChannelType.group,
            channelUrl: messageCollection.baseChannel.channelUrl,
            params: params.toJson(),
            timestamp: oldestTs,
            checkingHasNext: true,
            checkingContinuousMessages: false,
          ));

          if (res.messages.isNotEmpty) {
            if (res.hasNext != null) {
              hasNext = res.hasNext!;
            } else {
              hasNext = (res.messages.length == resultSize);
            }

            for (final message in res.messages) {
              bool found = false;
              for (final nextMessage in nextMessages) {
                if (nextMessage.rootId == message.rootId) {
                  found = true;
                  break;
                }
              }
              if (!found) {
                nextMessages.add(message);
              }
            }

            if (hasNext) {
              oldestTs = nextMessages.map((message) => message.createdAt).max;
            }
          }

          maxCount--;
          repeat = (hasNext && maxCount > 0);
          if (repeat) {
            await Future.delayed(const Duration(milliseconds: 200));
          }
        } while (repeat);
      }

      if (prevMessages.isNotEmpty) {
        // For offline messaging
        final List<RootMessage> updatedMessages = [];
        if (deletedPrevMessageIds.isNotEmpty) {
          final removedMessage = prevMessages.removeLast();
          updatedMessages.add(removedMessage);
          deletedPrevMessageIds
              .removeWhere((id) => removedMessage.rootId == id);
        }

        sendEventsToMessageCollection(
          messageCollection: messageCollection,
          baseChannel: messageCollection.baseChannel,
          eventSource: CollectionEventSource.messageFill,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: prevMessages,
          isReversedAddedMessages:
              !messageCollection.loadPreviousParams.reverse,
          isContinuousAddedMessages: res.isPrevContinuous ?? false,
          // Added ! because of loadPrevious()
          updatedMessages: updatedMessages,
          deletedMessageIds: deletedPrevMessageIds,
        );
      }

      if (nextMessages.isNotEmpty) {
        // For offline messaging
        final List<RootMessage> updatedMessages = [];
        if (deletedNextMessageIds.isNotEmpty) {
          final removedMessage = nextMessages.removeAt(0);
          updatedMessages.add(removedMessage);
          deletedNextMessageIds
              .removeWhere((id) => removedMessage.rootId == id);
        }

        sendEventsToMessageCollection(
          messageCollection: messageCollection,
          baseChannel: messageCollection.baseChannel,
          eventSource: CollectionEventSource.messageFill,
          sendingStatus: SendingStatus.succeeded,
          addedMessages: nextMessages,
          isReversedAddedMessages: messageCollection.loadNextParams.reverse,
          isContinuousAddedMessages: res.isNextContinuous ?? false,
          updatedMessages: updatedMessages,
          deletedMessageIds: deletedNextMessageIds,
        );
      }
    }
  }

//------------------------------//
// Send events to message collection list
//------------------------------//
  void sendEventsToMessageCollectionList({
    required CollectionEventSource eventSource,
    List<BaseChannel>? updatedChannels,
    List<String>? deletedChannelUrls,
    dynamic eventDetail,
  }) async {
    sbLog.d(StackTrace.current, eventSource.toString());

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      if (updatedChannels != null) {
        for (final channel in updatedChannels) {
          if (channel is GroupChannel) {
            await _chat.dbManager.upsertGroupChannels([channel]);
          } else if (channel is FeedChannel) {
            await _chat.dbManager.upsertFeedChannels([channel]);
          }
        }
      }
      if (deletedChannelUrls != null) {
        await _chat.dbManager.deleteGroupChannels(deletedChannelUrls);
      }
    }
    //- [DBManager]

    if (updatedChannels != null && updatedChannels.isNotEmpty) {
      for (final updatedChannel in updatedChannels) {
        for (final messageCollection in baseMessageCollections) {
          if (updatedChannel.channelUrl ==
              messageCollection.baseChannel.channelUrl) {
            if (!messageCollection.isDisposed) {
              messageCollection.baseChannel = updatedChannel;

              if (messageCollection.baseHandler is MessageCollectionHandler &&
                  updatedChannel is GroupChannel) {
                (messageCollection.baseHandler as MessageCollectionHandler)
                    .onChannelUpdated(
                        GroupChannelContext(
                            collectionEventSource: eventSource,
                            eventDetail: eventDetail),
                        updatedChannel);
              } else if (messageCollection.baseHandler
                      is NotificationCollectionHandler &&
                  updatedChannel is FeedChannel) {
                (messageCollection.baseHandler as NotificationCollectionHandler)
                    .onChannelUpdated(
                        FeedChannelContext(
                            collectionEventSource: eventSource,
                            eventDetail: eventDetail),
                        updatedChannel);
              }
            }
            break;
          }
        }
      }
    }

    if (deletedChannelUrls != null && deletedChannelUrls.isNotEmpty) {
      for (final deletedChannelUrl in deletedChannelUrls) {
        for (final messageCollection in baseMessageCollections) {
          if (deletedChannelUrl == messageCollection.baseChannel.channelUrl) {
            if (!messageCollection.isDisposed) {
              if (messageCollection.baseHandler is MessageCollectionHandler) {
                (messageCollection.baseHandler as MessageCollectionHandler)
                    .onChannelDeleted(
                        GroupChannelContext(
                            collectionEventSource: eventSource,
                            eventDetail: eventDetail),
                        deletedChannelUrl);
              } else if (messageCollection.baseHandler
                  is NotificationCollectionHandler) {
                (messageCollection.baseHandler as NotificationCollectionHandler)
                    .onChannelDeleted(
                        FeedChannelContext(
                            collectionEventSource: eventSource,
                            eventDetail: eventDetail),
                        deletedChannelUrl);
              }
            }
            break;
          }
        }
      }
    }
  }

//------------------------------//
// Send events to message collection
//------------------------------//
  Future<void> sendEventsToMessageCollection({
    required BaseMessageCollection messageCollection,
    required BaseChannel baseChannel,
    required CollectionEventSource eventSource,
    required SendingStatus sendingStatus,
    List<RootMessage>? addedMessages,
    bool isReversedAddedMessages = false,
    bool isContinuousAddedMessages = false,
    List<RootMessage>? updatedMessages,
    List<dynamic>? deletedMessageIds,
    String? deletedRequestIdForPendingMessage,
    bool doNotSendDeleteEvent = false,
    bool isMessageOffsetUpdated = false,
  }) async {
    sbLog.d(StackTrace.current,
        'channelUrl: ${messageCollection.baseChannel.channelUrl}, ${eventSource.toString()}');

    List<RootMessage> addedMessagesForEvent = [];
    final List<RootMessage> updatedMessagesForEvent = [];
    final List<RootMessage> deletedMessagesForEvent = [];

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      // [First] delete
      if (deletedMessageIds != null && deletedMessageIds.isNotEmpty) {
        if (!(eventSource == CollectionEventSource.messageInitialize &&
                deletedMessageIds.length == addedMessages?.length) && // Check
            eventSource != CollectionEventSource.messageLoadPrevious &&
            eventSource != CollectionEventSource.messageLoadNext) {
          List<String> deletedStringIds = deletedMessageIds
              .map((id) => (id is String) ? id : id.toString())
              .toList();

          // MessageChunk
          await _chat.dbManager.deleteMessagesInChunk(
            channelUrl: baseChannel.channelUrl,
            rootIds: deletedStringIds.where((id) {
              if (addedMessages != null && isContinuousAddedMessages) {
                for (final message in addedMessages) {
                  if (id == message.rootId) {
                    return false;
                  }
                }
              }
              return true;
            }).toList(),
          );

          await _chat.dbManager.deleteMessages(baseChannel, deletedStringIds);
        }
      }

      if (addedMessages != null && addedMessages.isNotEmpty) {
        await _chat.dbManager.upsertMessages(addedMessages);

        if (isContinuousAddedMessages) {
          // For offline messaging
          if (updatedMessages != null && updatedMessages.isNotEmpty) {
            addedMessages.addAll(updatedMessages);
          }

          // MessageChunk
          await _chat.dbManager.upsertMessagesInChunk(
            channelUrl: baseChannel.channelUrl,
            messages: addedMessages,
          );
        } else if (addedMessages.length == 1 &&
            addedMessages[0] is BaseMessage &&
            (addedMessages[0] as BaseMessage).previousMessageId != null &&
            (addedMessages[0] as BaseMessage).sendingStatus ==
                SendingStatus.succeeded) {
          final previousMessageId =
              (addedMessages[0] as BaseMessage).previousMessageId;
          if (previousMessageId != null) {
            if (messageCollection.removePreviousMessageIdForTest == true) {
              messageCollection.removePreviousMessageIdForTest = false;
            } else {
              final previousMessage = messageCollection.messageList
                  .firstWhereOrNull((e) =>
                      (e is BaseMessage && e.messageId == previousMessageId));

              if (previousMessage != null) {
                // MessageChunk
                await _chat.dbManager.upsertMessagesInChunk(
                  channelUrl: baseChannel.channelUrl,
                  messages: [previousMessage, addedMessages[0]],
                );
              }
            }
          }
        }
      }

      if (updatedMessages != null && updatedMessages.isNotEmpty) {
        await _chat.dbManager.upsertMessages(updatedMessages);
      }
    }
    //- [DBManager]

    if (deletedMessageIds != null && deletedMessageIds.isNotEmpty) {
      for (final deletedMessageId in deletedMessageIds) {
        for (int index = 0;
            index < messageCollection.messageList.length;
            index++) {
          final message = messageCollection.messageList[index];
          final id = deletedMessageId is String
              ? deletedMessageId
              : deletedMessageId.toString();
          if (message.rootId == id) {
            deletedMessagesForEvent.add(message);
            messageCollection.messageList.removeAt(index);
            break;
          }
        }
      }
    }

    if (deletedRequestIdForPendingMessage != null) {
      for (int index = 0;
          index < messageCollection.messageList.length;
          index++) {
        final message = messageCollection.messageList[index];
        if (message is BaseMessage &&
            message.requestId == deletedRequestIdForPendingMessage) {
          messageCollection.messageList.removeAt(index);

          // If there are no pending messages in messageList
          bool hasPendingMessage = false;
          for (final msg in messageCollection.messageList) {
            if (msg is BaseMessage &&
                msg.sendingStatus == SendingStatus.pending) {
              hasPendingMessage = true;
              break;
            }
          }

          if (!hasPendingMessage) {
            _chat.dbManager.deleteMessages(baseChannel, ['0']); // No await
          }
          break;
        }
      }
    }

    if (addedMessages != null && addedMessages.isNotEmpty) {
      for (final addedMessage in addedMessages) {
        bool isMessageExists = false;
        for (final message in messageCollection.messageList) {
          if (eventSource != CollectionEventSource.localMessagePendingCreated) {
            if (message.getMessageId() == addedMessage.getMessageId()) {
              isMessageExists = true;
              break;
            }
          }
        }

        if (!isMessageExists) {
          if (messageCollection.canAddMessage(eventSource, addedMessage)) {
            addedMessagesForEvent.add(addedMessage);
          } else if (eventSource == CollectionEventSource.eventMessageSent) {
            doNotSendDeleteEvent = false;
            deletedMessagesForEvent.clear(); // Defensive
            deletedMessagesForEvent.add(addedMessage);
          }
        }
      }

      if (messageCollection is NotificationCollection) {
        addedMessagesForEvent =
            List<NotificationMessage>.from(addedMessagesForEvent);
      } else {
        // MessageCollection
        addedMessagesForEvent = List<BaseMessage>.from(addedMessagesForEvent);
      }

      if (isReversedAddedMessages) {
        messageCollection.messageList.insertAll(0, addedMessagesForEvent);
      } else {
        messageCollection.messageList.addAll(addedMessagesForEvent);
      }
    }

    if (updatedMessages != null && updatedMessages.isNotEmpty) {
      for (final updatedMessage in updatedMessages) {
        bool found = false;
        for (int index = 0;
            index < messageCollection.messageList.length;
            index++) {
          final message = messageCollection.messageList[index];
          if (message.getMessageId() == updatedMessage.getMessageId()) {
            found = true;
            if (messageCollection.canUpdateMessage(
                eventSource, message, updatedMessage)) {
              messageCollection.messageList[index] = updatedMessage;
              updatedMessagesForEvent.add(updatedMessage);
            } else {
              deletedMessagesForEvent.clear(); // Defensive
              deletedMessagesForEvent.add(updatedMessage);
            }
            break;
          }
        }

        if (!found) {
          if (messageCollection.canAddMessage(eventSource, updatedMessage)) {
            addedMessagesForEvent.clear(); // Defensive
            addedMessagesForEvent.add(updatedMessage);

            if (messageCollection is NotificationCollection) {
              addedMessagesForEvent =
                  List<NotificationMessage>.from(addedMessagesForEvent);
            } else {
              // MessageCollection
              addedMessagesForEvent =
                  List<BaseMessage>.from(addedMessagesForEvent);
            }

            if (isReversedAddedMessages) {
              messageCollection.messageList.insertAll(0, addedMessagesForEvent);
            } else {
              messageCollection.messageList.addAll(addedMessagesForEvent);
            }
          }
        }
      }
    }

    //+ [DBManager]
    if (eventSource == CollectionEventSource.messageFill ||
        isMessageOffsetUpdated) {
      messageCollection.setValuesFromMessageList(); // Check
    }
    //- [DBManager]

    if (deletedMessagesForEvent.isNotEmpty) {
      if (!messageCollection.isDisposed) {
        //+ [DBManager]
        CollectionEventSource source = eventSource;
        if (eventSource == CollectionEventSource.messageInitialize) {
          source = CollectionEventSource.messageCacheInitialize;
        } else if (eventSource == CollectionEventSource.messageLoadPrevious) {
          source = CollectionEventSource.messageCacheLoadPrevious;
        } else if (eventSource == CollectionEventSource.messageLoadNext) {
          source = CollectionEventSource.messageCacheLoadNext;
        }
        //- [DBManager]

        //+ [DBManager]
        if (doNotSendDeleteEvent) {
          // Do not send this onMessagesDeleted() event.
        } else if (source == CollectionEventSource.messageCacheInitialize ||
            source == CollectionEventSource.messageCacheLoadPrevious ||
            source == CollectionEventSource.messageCacheLoadNext ||
            source == CollectionEventSource.messageFill) {
          // Do not send this onMessagesDeleted() event.
          // Customer does not need this event.
        }
        //- [DBManager]
        else {
          if (messageCollection.baseHandler is MessageCollectionHandler &&
              baseChannel is GroupChannel) {
            (messageCollection.baseHandler as MessageCollectionHandler)
                .onMessagesDeleted(
              MessageContext(source, sendingStatus),
              baseChannel,
              List<BaseMessage>.from(deletedMessagesForEvent),
            );
          } else if (messageCollection.baseHandler
                  is NotificationCollectionHandler &&
              baseChannel is FeedChannel) {
            (messageCollection.baseHandler as NotificationCollectionHandler)
                .onMessagesDeleted(
              NotificationContext(source, sendingStatus),
              baseChannel,
              List<NotificationMessage>.from(deletedMessagesForEvent),
            );
          }
        }
      }
    }

    if (addedMessagesForEvent.isNotEmpty) {
      messageCollection.sort();

      if (!messageCollection.isDisposed) {
        if (eventSource == CollectionEventSource.eventMessageSent) {
          updatedMessagesForEvent.clear(); // Defensive
          updatedMessagesForEvent.addAll(addedMessagesForEvent);
        } else if (messageCollection.baseHandler is MessageCollectionHandler &&
            baseChannel is GroupChannel) {
          (messageCollection.baseHandler as MessageCollectionHandler)
              .onMessagesAdded(
            MessageContext(eventSource, sendingStatus),
            baseChannel,
            List<BaseMessage>.from(addedMessagesForEvent),
          );
        } else if (messageCollection.baseHandler
                is NotificationCollectionHandler &&
            baseChannel is FeedChannel) {
          (messageCollection.baseHandler as NotificationCollectionHandler)
              .onMessagesAdded(
            NotificationContext(eventSource, sendingStatus),
            baseChannel,
            List<NotificationMessage>.from(addedMessagesForEvent),
          );
        }
      }
    }

    if (updatedMessagesForEvent.isNotEmpty) {
      if (eventSource != CollectionEventSource.eventMessageSent) {
        messageCollection.sort();
      }

      if (!messageCollection.isDisposed) {
        if (messageCollection.baseHandler is MessageCollectionHandler &&
            baseChannel is GroupChannel) {
          (messageCollection.baseHandler as MessageCollectionHandler)
              .onMessagesUpdated(
            MessageContext(eventSource, sendingStatus),
            baseChannel,
            List<BaseMessage>.from(updatedMessagesForEvent),
          );
        } else if (messageCollection.baseHandler
                is NotificationCollectionHandler &&
            baseChannel is FeedChannel) {
          (messageCollection.baseHandler as NotificationCollectionHandler)
              .onMessagesUpdated(
            NotificationContext(eventSource, sendingStatus),
            baseChannel,
            List<NotificationMessage>.from(updatedMessagesForEvent),
          );
        }
      }
    }
  }
}
