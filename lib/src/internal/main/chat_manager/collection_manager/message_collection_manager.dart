// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'collection_manager.dart';

extension MessageCollectionManager on CollectionManager {
//------------------------------//
// Add and remove message collection
//------------------------------//
  void addMessageCollection(BaseMessageCollection collection) {
    messageCollections.add(collection);

    final now = DateTime.now().millisecondsSinceEpoch;
    lastRequestTsForMessageChangeLogs[collection.baseChannel.channelUrl] = now;
    lastRequestTsForPollChangeLogs[collection.baseChannel.channelUrl] = now;
    lastRequestTsForMessagesGap[collection.baseChannel.channelUrl] = now;
  }

  void removeMessageCollection(BaseMessageCollection collection) {
    messageCollections.remove(collection);
  }

//------------------------------//
// onMessageSentByMe
//------------------------------//
  void onMessageSentByMe(BaseMessage message) async {
    sbLog.d(StackTrace.current, 'onMessageSentByMe()');

    for (final messageCollection in messageCollections) {
      sendEventsToMessageCollection(
        messageCollection: messageCollection,
        baseChannel: messageCollection.baseChannel,
        eventSource: CollectionEventSource.eventMessageSent,
        sendingStatus: SendingStatus.succeeded,
        addedMessages: [message],
        isReversedAddedMessages: messageCollection.params.reverse,
      );
    }
  }

//------------------------------//
// Message changeLogs
//------------------------------//
  void _requestMessageChangeLogs(
      BaseMessageCollection messageCollection) async {
    final channel = messageCollection.baseChannel;
    final params = MessageChangeLogParams();
    final List<BaseMessage> updatedMessages = [];
    final List<int> deletedMessageIds = [];

    MessageChangeLogs changeLogs;
    String? token;

    do {
      final now = DateTime.now().millisecondsSinceEpoch;

      if (token == null) {
        changeLogs = await channel.getMessageChangeLogs(
          params,
          timestamp: lastRequestTsForMessageChangeLogs[channel.channelUrl] ?? 0,
        );
      } else {
        changeLogs = await channel.getMessageChangeLogs(
          params,
          token: token,
        );
      }

      updatedMessages.addAll(changeLogs.updatedMessages);
      deletedMessageIds.addAll(changeLogs.deletedMessageIds);

      lastRequestTsForMessageChangeLogs[channel.channelUrl] = now;
      token = changeLogs.token;
    } while (changeLogs.hasMore);

    sendEventsToMessageCollection(
      messageCollection: messageCollection,
      baseChannel: channel,
      eventSource: CollectionEventSource.messageChangeLogs,
      sendingStatus: SendingStatus.succeeded,
      updatedMessages: updatedMessages,
      deletedMessageIds: deletedMessageIds,
    );
  }

//------------------------------//
// Poll changeLogs
//------------------------------//
  void _requestPollChangeLogs(BaseMessageCollection messageCollection) async {
    if (_chat.chatContext.appInfo == null ||
        _chat.chatContext.appInfo!.premiumFeatureList.contains('poll') ==
            false) {
      return;
    }

    if (messageCollection.baseChannel is! GroupChannel) {
      return;
    }

    final groupChannel = messageCollection.baseChannel as GroupChannel;
    final List<BaseMessage> updatedMessages = [];
    final List<int> deletedMessageIds = [];

    PollChangeLogs changeLogs;
    String? token;

    do {
      final now = DateTime.now().millisecondsSinceEpoch;

      if (token == null) {
        changeLogs = await groupChannel.getPollChangeLogsSinceTimestamp(
          lastRequestTsForPollChangeLogs[groupChannel.channelUrl] ?? 0,
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
            if (message.messageId == poll.messageId) {
              updatedMessages.add(message);
              break;
            }
          }
        }
      }

      // changeLogs.deletedPollIds => changeLogs.deletedMessageIds

      lastRequestTsForPollChangeLogs[groupChannel.channelUrl] = now;
      token = changeLogs.token;
    } while (changeLogs.hasMore);

    sendEventsToMessageCollection(
      messageCollection: messageCollection,
      baseChannel: groupChannel,
      eventSource: CollectionEventSource.pollChangeLogs,
      sendingStatus: SendingStatus.succeeded,
      updatedMessages: updatedMessages,
      deletedMessageIds: deletedMessageIds,
    );
  }

//------------------------------//
// Messages gap
//------------------------------//
  void _requestMessagesGap(BaseMessageCollection messageCollection) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final channel = messageCollection.baseChannel;
    int nextEndTs = messageCollection.latestMessage != null
        ? messageCollection.latestMessage!.createdAt
        : min(lastRequestTsForMessagesGap[channel.channelUrl] ?? 0,
            messageCollection.startingPoint);
    int nextCacheCount = messageCollection.latestMessage != null ? 1 : 0;

    final messages = await _chat.apiClient.send<List<BaseMessage>?>(
      ChannelMessagesGapRequest(
        _chat,
        channelType: ChannelType.group,
        channelUrl: messageCollection.baseChannel.channelUrl,
        messageListParams: messageCollection.loadNextParams.toJson(),
        prevStartTs: nextEndTs,
        prevEndTs: nextEndTs,
        prevCacheCount: nextCacheCount,
        nextStartTs: nextEndTs,
        nextEndTs: IntMax.max,
        nextCacheCount: nextCacheCount,
      ),
    );

    lastRequestTsForMessagesGap[channel.channelUrl] = now;

    if (messages == null) {
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
      messageCollection.hasNext = false;

      sendEventsToMessageCollection(
        messageCollection: messageCollection,
        baseChannel: channel,
        eventSource: CollectionEventSource.messagesGap,
        sendingStatus: SendingStatus.succeeded,
        addedMessages: messages,
        isReversedAddedMessages: messageCollection.loadNextParams.reverse,
      );
    }
  }

//------------------------------//
// Send events to message collection list
//------------------------------//
  void sendEventsToMessageCollectionList({
    required CollectionEventSource eventSource,
    List<BaseChannel>? updatedChannels,
    List<String>? deletedChannelUrls,
  }) {
    if (updatedChannels != null && updatedChannels.isNotEmpty) {
      for (final updatedChannel in updatedChannels) {
        for (final messageCollection in messageCollections) {
          if (updatedChannel.channelUrl ==
              messageCollection.baseChannel.channelUrl) {
            if (!messageCollection.isDisposed) {
              if (messageCollection.baseHandler is MessageCollectionHandler) {
                (messageCollection.baseHandler as MessageCollectionHandler)
                    .onChannelUpdated(GroupChannelContext(eventSource),
                        updatedChannel as GroupChannel);
              } else if (messageCollection.baseHandler
                  is NotificationCollectionHandler) {
                (messageCollection.baseHandler as NotificationCollectionHandler)
                    .onChannelUpdated(FeedChannelContext(eventSource),
                        updatedChannel as FeedChannel);
              }
            }
            break;
          }
        }
      }
    }

    if (deletedChannelUrls != null && deletedChannelUrls.isNotEmpty) {
      for (final deletedChannelUrl in deletedChannelUrls) {
        for (final messageCollection in messageCollections) {
          if (deletedChannelUrl == messageCollection.baseChannel.channelUrl) {
            if (!messageCollection.isDisposed) {
              if (messageCollection.baseHandler is MessageCollectionHandler) {
                (messageCollection.baseHandler as MessageCollectionHandler)
                    .onChannelDeleted(
                        GroupChannelContext(eventSource), deletedChannelUrl);
              } else if (messageCollection.baseHandler
                  is NotificationCollectionHandler) {
                (messageCollection.baseHandler as NotificationCollectionHandler)
                    .onChannelDeleted(
                        FeedChannelContext(eventSource), deletedChannelUrl);
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
  void sendEventsToMessageCollection({
    required BaseMessageCollection messageCollection,
    required BaseChannel baseChannel,
    required CollectionEventSource eventSource,
    required SendingStatus sendingStatus,
    List<BaseMessage>? addedMessages,
    bool isReversedAddedMessages = false,
    List<BaseMessage>? updatedMessages,
    List<int>? deletedMessageIds,
  }) {
    final List<BaseMessage> addedMessagesForEvent = [];
    final List<BaseMessage> updatedMessagesForEvent = [];
    final List<BaseMessage> deletedMessagesForEvent = [];

    if (addedMessages != null && addedMessages.isNotEmpty) {
      for (final addedMessage in addedMessages) {
        bool isMessageExists = false;
        for (final message in messageCollection.messageList) {
          if (message.messageId == addedMessage.messageId) {
            isMessageExists = true;
            break;
          }
        }

        if (!isMessageExists) {
          if (messageCollection.messageList.isEmpty) {
            addedMessagesForEvent.add(addedMessage);
          } else if (messageCollection.canAddMessage(
              eventSource, addedMessage)) {
            addedMessagesForEvent.add(addedMessage);
          }
        }
      }

      if (isReversedAddedMessages) {
        messageCollection.messageList.insertAll(0, addedMessagesForEvent);
      } else {
        messageCollection.messageList.addAll(addedMessagesForEvent);
      }
    }

    if (updatedMessages != null && updatedMessages.isNotEmpty) {
      for (final updatedMessage in updatedMessages) {
        for (int index = 0;
            index < messageCollection.messageList.length;
            index++) {
          final message = messageCollection.messageList[index];
          if (message.messageId == updatedMessage.messageId) {
            if (eventSource == CollectionEventSource.pollChangeLogs ||
                eventSource == CollectionEventSource.eventPollVoted ||
                eventSource == CollectionEventSource.eventPollUpdated) {
              if (message is UserMessage &&
                  message.poll != null &&
                  updatedMessage is UserMessage &&
                  updatedMessage.poll != null &&
                  message.poll!.updatedAt <= updatedMessage.poll!.updatedAt) {
                messageCollection.messageList[index] = updatedMessage;
                updatedMessagesForEvent.add(updatedMessage);
                break;
              }
            } else if (eventSource ==
                CollectionEventSource.eventReactionUpdated) {
              // TODO: updatedAt check (?)
              messageCollection.messageList[index] = updatedMessage;
              updatedMessagesForEvent.add(updatedMessage);
              break;
            } else if (eventSource ==
                CollectionEventSource.eventThreadInfoUpdated) {
              // TODO: updatedAt check (?)
              messageCollection.messageList[index] = updatedMessage;
              updatedMessagesForEvent.add(updatedMessage);
              break;
            } else if (message.updatedAt < updatedMessage.updatedAt) {
              messageCollection.messageList[index] = updatedMessage;
              updatedMessagesForEvent.add(updatedMessage);
              break;
            }
          }
        }
      }
    }

    if (deletedMessageIds != null && deletedMessageIds.isNotEmpty) {
      for (final deletedMessageId in deletedMessageIds) {
        for (int index = 0;
            index < messageCollection.messageList.length;
            index++) {
          final message = messageCollection.messageList[index];
          if (message.messageId == deletedMessageId) {
            deletedMessagesForEvent.add(message);
            messageCollection.messageList.removeAt(index);
            break;
          }
        }
      }
    }

    if (addedMessagesForEvent.isNotEmpty) {
      if (!messageCollection.isDisposed) {
        if (messageCollection.baseHandler is MessageCollectionHandler) {
          (messageCollection.baseHandler as MessageCollectionHandler)
              .onMessagesAdded(
            MessageContext(eventSource, sendingStatus),
            baseChannel as GroupChannel,
            addedMessagesForEvent,
          );
        } else if (messageCollection.baseHandler
            is NotificationCollectionHandler) {
          (messageCollection.baseHandler as NotificationCollectionHandler)
              .onMessagesAdded(
            NotificationContext(eventSource, sendingStatus),
            baseChannel as FeedChannel,
            addedMessagesForEvent,
          );
        }
      }
    }

    if (updatedMessagesForEvent.isNotEmpty) {
      if (!messageCollection.isDisposed) {
        if (messageCollection.baseHandler is MessageCollectionHandler) {
          (messageCollection.baseHandler as MessageCollectionHandler)
              .onMessagesUpdated(
            MessageContext(eventSource, sendingStatus),
            baseChannel as GroupChannel,
            updatedMessagesForEvent,
          );
        } else if (messageCollection.baseHandler
            is NotificationCollectionHandler) {
          (messageCollection.baseHandler as NotificationCollectionHandler)
              .onMessagesUpdated(
            NotificationContext(eventSource, sendingStatus),
            baseChannel as FeedChannel,
            updatedMessagesForEvent,
          );
        }
      }
    }

    if (deletedMessagesForEvent.isNotEmpty) {
      if (!messageCollection.isDisposed) {
        if (messageCollection.baseHandler is MessageCollectionHandler) {
          (messageCollection.baseHandler as MessageCollectionHandler)
              .onMessagesDeleted(
            MessageContext(eventSource, sendingStatus),
            baseChannel as GroupChannel,
            deletedMessagesForEvent,
          );
        } else if (messageCollection.baseHandler
            is NotificationCollectionHandler) {
          (messageCollection.baseHandler as NotificationCollectionHandler)
              .onMessagesDeleted(
            NotificationContext(eventSource, sendingStatus),
            baseChannel as FeedChannel,
            deletedMessagesForEvent,
          );
        }
      }
    }
  }
}
