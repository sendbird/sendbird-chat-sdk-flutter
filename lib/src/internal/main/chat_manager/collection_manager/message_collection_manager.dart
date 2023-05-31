// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'collection_manager.dart';

extension MessageCollectionManager on CollectionManager {
//------------------------------//
// Add and remove message collection
//------------------------------//
  void addMessageCollection(MessageCollection collection) {
    messageCollections.add(collection);

    final now = DateTime.now().millisecondsSinceEpoch;
    lastRequestTsForMessageChangeLogs[collection.channel.channelUrl] = now;
    lastRequestTsForPollChangeLogs[collection.channel.channelUrl] = now;
    lastRequestTsForMessagesGap[collection.channel.channelUrl] = now;
  }

  void removeMessageCollection(MessageCollection collection) {
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
        groupChannel: messageCollection.channel,
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
  void _requestMessageChangeLogs(MessageCollection messageCollection) async {
    final channel = messageCollection.channel;
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
      groupChannel: channel,
      eventSource: CollectionEventSource.messageChangeLogs,
      sendingStatus: SendingStatus.succeeded,
      updatedMessages: updatedMessages,
      deletedMessageIds: deletedMessageIds,
    );
  }

//------------------------------//
// Poll changeLogs
//------------------------------//
  void _requestPollChangeLogs(MessageCollection messageCollection) async {
    if (_chat.chatContext.appInfo == null ||
        _chat.chatContext.appInfo!.premiumFeatureList.contains('poll') ==
            false) {
      return;
    }

    final channel = messageCollection.channel;
    final List<BaseMessage> updatedMessages = [];
    final List<int> deletedMessageIds = [];

    PollChangeLogs changeLogs;
    String? token;

    do {
      final now = DateTime.now().millisecondsSinceEpoch;

      if (token == null) {
        changeLogs = await channel.getPollChangeLogsSinceTimestamp(
          lastRequestTsForPollChangeLogs[channel.channelUrl] ?? 0,
        );
      } else {
        changeLogs = await channel.getPollChangeLogsSinceToken(
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

      lastRequestTsForPollChangeLogs[channel.channelUrl] = now;
      token = changeLogs.token;
    } while (changeLogs.hasMore);

    sendEventsToMessageCollection(
      messageCollection: messageCollection,
      groupChannel: channel,
      eventSource: CollectionEventSource.pollChangeLogs,
      sendingStatus: SendingStatus.succeeded,
      updatedMessages: updatedMessages,
      deletedMessageIds: deletedMessageIds,
    );
  }

//------------------------------//
// Messages gap
//------------------------------//
  void _requestMessagesGap(MessageCollection messageCollection) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final channel = messageCollection.channel;
    int nextEndTs = messageCollection.latestMessage != null
        ? messageCollection.latestMessage!.createdAt
        : min(lastRequestTsForMessagesGap[channel.channelUrl] ?? 0,
            messageCollection.startingPoint);
    int nextCacheCount = messageCollection.latestMessage != null ? 1 : 0;

    final messages = await _chat.apiClient.send<List<BaseMessage>?>(
      ChannelMessagesGapRequest(
        _chat,
        channelType: ChannelType.group,
        channelUrl: messageCollection.channel.channelUrl,
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
        messageCollection.handler.onHugeGapDetected();
      }
    } else {
      messageCollection.hasNext = false;

      sendEventsToMessageCollection(
        messageCollection: messageCollection,
        groupChannel: channel,
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
    List<GroupChannel>? updatedChannels,
    List<String>? deletedChannelUrls,
  }) {
    if (updatedChannels != null && updatedChannels.isNotEmpty) {
      for (final updatedChannel in updatedChannels) {
        for (final messageCollection in messageCollections) {
          if (updatedChannel.channelUrl ==
              messageCollection.channel.channelUrl) {
            if (!messageCollection.isDisposed) {
              messageCollection.handler.onChannelUpdated(
                  GroupChannelContext(eventSource), updatedChannel);
            }
            break;
          }
        }
      }
    }

    if (deletedChannelUrls != null && deletedChannelUrls.isNotEmpty) {
      for (final deletedChannelUrl in deletedChannelUrls) {
        for (final messageCollection in messageCollections) {
          if (deletedChannelUrl == messageCollection.channel.channelUrl) {
            if (!messageCollection.isDisposed) {
              messageCollection.handler.onChannelDeleted(
                  GroupChannelContext(eventSource), deletedChannelUrl);
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
    required MessageCollection messageCollection,
    required GroupChannel groupChannel,
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
        messageCollection.handler.onMessagesAdded(
          MessageContext(eventSource, sendingStatus),
          groupChannel,
          addedMessagesForEvent,
        );
      }
    }

    if (updatedMessagesForEvent.isNotEmpty) {
      if (!messageCollection.isDisposed) {
        messageCollection.handler.onMessagesUpdated(
          MessageContext(eventSource, sendingStatus),
          groupChannel,
          updatedMessagesForEvent,
        );
      }
    }

    if (deletedMessagesForEvent.isNotEmpty) {
      if (!messageCollection.isDisposed) {
        messageCollection.handler.onMessagesDeleted(
          MessageContext(eventSource, sendingStatus),
          groupChannel,
          deletedMessagesForEvent,
        );
      }
    }
  }
}
