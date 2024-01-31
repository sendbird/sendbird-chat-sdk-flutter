// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:collection/collection.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/meta/channel_info.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/message_changelog_info.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_gap_request.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_get_request.dart';
import 'package:uuid/uuid.dart';

part 'group_channel_collection_manager.dart';
part 'message_collection_manager.dart';

class CollectionManager {
  final identifierForInternalGroupChannelHandlerForCollectionManager =
      'InternalGroupChannelHandlerForCollectionManager_${const Uuid().v1()}';
  final identifierForInternalFeedChannelHandlerForCollectionManager =
      'InternalFeedChannelHandlerForCollectionManager_${const Uuid().v1()}';

  final Chat _chat;

  // GroupChannelCollection
  final List<GroupChannelCollection> groupChannelCollections = [];
  int lastRequestTsForGroupChannelChangeLogs = 0;

  // MessageCollection
  final List<BaseMessageCollection> baseMessageCollections = [];
  int lastRequestTsForMessageChangeLogs = 0;
  int lastRequestTsForPollChangeLogs = 0;
  int lastRequestTsForMessagesGap = 0;

  bool isGroupChannelCollectionsRefreshing = false;
  bool isBaseMessageCollectionsRefreshing = false;

  CollectionManager({required Chat chat}) : _chat = chat {
    _chat.eventManager.addInternalChannelHandler(
      identifierForInternalGroupChannelHandlerForCollectionManager,
      InternalGroupChannelHandlerForCollectionManager(this),
    );
    _chat.eventManager.addInternalChannelHandler(
      identifierForInternalFeedChannelHandlerForCollectionManager,
      InternalFeedChannelHandlerForCollectionManager(this),
    );
  }

  void _setInitialGroupChannelChangeLogsTs() {
    final now = DateTime.now().millisecondsSinceEpoch;
    lastRequestTsForGroupChannelChangeLogs = now;
  }

  void _setInitialMessageChangeLogsAndMessagesGapTs() {
    final now = DateTime.now().millisecondsSinceEpoch;
    lastRequestTsForMessageChangeLogs = now;
    lastRequestTsForPollChangeLogs = now;
    lastRequestTsForMessagesGap = now;
  }

//------------------------------//
// Reconnected
//------------------------------//
  Future<void> onLogin() async {
    sbLog.d(StackTrace.current);

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      await _chat.dbManager.checkDBFileSize();
      await _refresh();
    }
    //- [DBManager]
  }

  Future<void> onReconnected() async {
    sbLog.d(StackTrace.current);

    await _refresh();
  }

  Future<void> _refresh() async {
    sbLog.d(StackTrace.current);

    List<Future<dynamic>> futures = [];

    futures.add(refreshGroupChannelCollections());
    futures.add(_refreshBaseMessageCollections());

    if (futures.isNotEmpty) {
      await Future.wait(futures);
    }
  }

  Future<void> refreshGroupChannelCollections() async {
    isGroupChannelCollectionsRefreshing = true;

    List<Future<dynamic>> futures = [];

    if (groupChannelCollections.isNotEmpty) {
      futures.add(_requestGroupChannelChangeLogs());
    }

    if (futures.isNotEmpty) {
      await Future.wait(futures);
    }

    isGroupChannelCollectionsRefreshing = false;
  }

  Future<void> _refreshBaseMessageCollections() async {
    isBaseMessageCollectionsRefreshing = true;

    for (final collection in baseMessageCollections) {
      if (collection.isInitialized) {
        await _requestMessageChangeLogs(collection);
        await _requestPollChangeLogs(collection);
        await _requestMessagesGap(collection);
      }
    }

    isBaseMessageCollectionsRefreshing = false;
  }

  Future<void> refreshBaseMessageCollection(
      BaseMessageCollection collection) async {
    for (final collection in baseMessageCollections) {
      if (collection.isInitialized) {
        await _requestMessageChangeLogs(collection);
        await _requestPollChangeLogs(collection);
      }
    }
  }

  Future<void> refreshNotificationCollections() async {
    for (final collection in baseMessageCollections) {
      if (collection is NotificationCollection) {
        if (collection.isInitialized) {
          await _requestMessageChangeLogs(collection);
          await _requestMessagesGap(collection);
        }
      }
    }
  }

  Future<void> refreshNotificationCollection({
    required String channelUrl,
  }) async {
    for (final collection in baseMessageCollections) {
      if (collection is NotificationCollection) {
        if (collection.isInitialized) {
          if (collection.baseChannel.channelUrl == channelUrl) {
            await _requestMessageChangeLogs(collection);
            await _requestMessagesGap(collection);
            break;
          }
        }
      }
    }
  }

  void markAsReadForFeedChannel(String channelUrl, List<String>? messageIds) {
    for (final collection in baseMessageCollections) {
      if (collection is NotificationCollection) {
        if (collection.isInitialized) {
          if (collection.baseChannel.channelUrl == channelUrl) {
            // bool isUpdated = false;

            if (messageIds == null) {
              // All
              for (final message in collection.messageList) {
                if (message.messageStatus == NotificationMessageStatus.sent) {
                  message.messageStatus = NotificationMessageStatus.read;
                  // isUpdated = true;
                }
              }
            } else {
              for (final message in collection.messageList) {
                if (messageIds.contains(message.notificationId)) {
                  if (message.messageStatus == NotificationMessageStatus.sent) {
                    message.messageStatus = NotificationMessageStatus.read;
                    // isUpdated = true;
                  }
                }
              }
            }

            // if (isUpdated) {
            //   _chat.eventManager
            //       .notifyReadStatusUpdated(collection.baseChannel);
            // }
            break;
          }
        }
      }
    }
  }

  void onMessagesUpdated(String channelUrl, List<RootMessage>? messages) async {
    sbLog.d(StackTrace.current, 'onMessagesUpdated()');

    for (final collection in baseMessageCollections) {
      if (collection is NotificationCollection) {
        if (collection.isInitialized) {
          if (collection.baseChannel.channelUrl == channelUrl) {
            if (collection.baseHandler is NotificationCollectionHandler &&
                collection.baseChannel is FeedChannel) {
              (collection.baseHandler as NotificationCollectionHandler)
                  .onMessagesUpdated(
                      NotificationContext(
                        CollectionEventSource.eventMessageUpdated,
                        SendingStatus.succeeded,
                      ),
                      collection.baseChannel as FeedChannel,
                      messages != null
                          ? List<NotificationMessage>.from(messages)
                          : collection.messageList);
            }
            break;
          }
        }
      }
    }
  }
}

//------------------------------//
// GroupChannelHandler for collectionManager
//------------------------------//
class InternalGroupChannelHandlerForCollectionManager
    extends GroupChannelHandler {
  final CollectionManager _collectionManager;

  InternalGroupChannelHandlerForCollectionManager(
      CollectionManager collectionManager)
      : _collectionManager = collectionManager;

//------------------------------//
// BaseChannelHandler - channel
//------------------------------//
  @override
  void onMentionReceived(BaseChannel channel, RootMessage message) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventMentionReceived,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onChannelChanged(BaseChannel channel) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelChanged,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onChannelDeleted(String channelUrl, ChannelType channelType) {
    if (channelType == ChannelType.group) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelDeleted,
        deletedChannelUrls: [channelUrl],
      );
    }
  }

  @override
  void onUserMuted(BaseChannel channel, RestrictedUser restrictedUser) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserMuted,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onUserUnmuted(BaseChannel channel, User user) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserUnmuted,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onUserBanned(BaseChannel channel, RestrictedUser restrictedUser) {
    if (channel is GroupChannel) {
      if (restrictedUser.isCurrentUser) {
        _collectionManager.sendEventsToGroupChannelCollectionList(
          eventSource: CollectionEventSource.eventUserBanned,
          deletedChannelUrls: [channel.channelUrl],
        );
      } else {
        _collectionManager.sendEventsToGroupChannelCollectionList(
          eventSource: CollectionEventSource.eventUserBanned,
          updatedChannels: [channel],
        );
      }
    }
  }

  @override
  void onUserUnbanned(BaseChannel channel, User user) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserUnbanned,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onChannelFrozen(BaseChannel channel) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelFrozen,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onChannelUnfrozen(BaseChannel channel) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelUnfrozen,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onMetaDataCreated(BaseChannel channel, Map<String, String> metaData) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelMetaDataCreated,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onMetaDataUpdated(BaseChannel channel, Map<String, String> metaData) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelMetaDataUpdated,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onMetaDataDeleted(BaseChannel channel, List<String> metaDataKeys) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelMetaDataDeleted,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onMetaCountersCreated(
      BaseChannel channel, Map<String, int> metaCounters) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelMetaCountersCreated,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onMetaCountersUpdated(
      BaseChannel channel, Map<String, int> metaCounters) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelMetaCountersUpdated,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onMetaCountersDeleted(
      BaseChannel channel, List<String> metaCounterKeys) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventChannelMetaCountersDeleted,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onOperatorUpdated(BaseChannel channel) {
    if (channel is GroupChannel) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventOperatorUpdated,
        updatedChannels: [channel],
      );
    }
  }

//------------------------------//
// BaseChannelHandler - message
//------------------------------//
  @override
  void onMessageReceived(BaseChannel channel, RootMessage message) async {
    if (channel is GroupChannel || channel is FeedChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: channel,
            eventSource: CollectionEventSource.eventMessageReceived,
            sendingStatus: SendingStatus.succeeded,
            addedMessages: [message],
            isReversedAddedMessages: messageCollection.params.reverse,
          );
          break;
        }
      }
    }
  }

  @override
  void onMessageUpdated(BaseChannel channel, RootMessage message) async {
    if (channel is GroupChannel || channel is FeedChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: channel,
            eventSource: CollectionEventSource.eventMessageUpdated,
            sendingStatus: SendingStatus.succeeded,
            updatedMessages: [message],
          );
          break;
        }
      }
    }
  }

  @override
  void onMessageDeleted(BaseChannel channel, int messageId) async {
    if (channel is GroupChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: channel,
            eventSource: CollectionEventSource.eventMessageDeleted,
            sendingStatus: SendingStatus.succeeded,
            deletedMessageIds: [messageId.toString()],
          );
          break;
        }
      }
    }
  }

  @override
  void onReactionUpdated(BaseChannel channel, ReactionEvent event) async {
    if (channel is GroupChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          for (final message in messageCollection.messageList) {
            if (message.getMessageId() == event.messageId) {
              (message as BaseMessage).applyReactionEvent(event);

              _collectionManager.sendEventsToMessageCollection(
                messageCollection: messageCollection,
                baseChannel: channel,
                eventSource: CollectionEventSource.eventReactionUpdated,
                sendingStatus: SendingStatus.succeeded,
                updatedMessages: [message],
              );
              break;
            }
          }
          break;
        }
      }
    }
  }

  @override
  void onThreadInfoUpdated(
      BaseChannel channel, ThreadInfoUpdateEvent event) async {
    if (channel is GroupChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          for (final message in messageCollection.messageList) {
            if (message.getMessageId() == event.targetMessageId) {
              (message as BaseMessage).applyThreadInfoUpdateEvent(event);

              _collectionManager.sendEventsToMessageCollection(
                messageCollection: messageCollection,
                baseChannel: channel,
                eventSource: CollectionEventSource.eventThreadInfoUpdated,
                sendingStatus: SendingStatus.succeeded,
                updatedMessages: [message],
              );
              break;
            }
          }
          break;
        }
      }
    }
  }

//------------------------------//
// GroupChannelHandler - channel
//------------------------------//
  @override
  void onReadStatusUpdated(GroupChannel channel) {
    _collectionManager.sendEventsToGroupChannelCollectionList(
      eventSource: CollectionEventSource.eventReadStatusUpdated,
      updatedChannels: [channel],
    );
  }

  @override
  void onDeliveryStatusUpdated(GroupChannel channel) {
    _collectionManager.sendEventsToGroupChannelCollectionList(
      eventSource: CollectionEventSource.eventDeliveryStatusUpdated,
      updatedChannels: [channel],
    );
  }

  @override
  void onTypingStatusUpdated(GroupChannel channel) {
    _collectionManager.sendEventsToGroupChannelCollectionList(
      eventSource: CollectionEventSource.eventTypingStatusUpdated,
      updatedChannels: [channel],
    );
  }

  @override
  void onUserReceivedInvitation(
      GroupChannel channel, List<User> invitees, User? inviter) {
    _collectionManager.sendEventsToGroupChannelCollectionList(
      eventSource: CollectionEventSource.eventUserReceivedInvitation,
      updatedChannels: [channel],
    );
  }

  @override
  void onUserDeclinedInvitation(
      GroupChannel channel, User invitee, User? inviter) {
    if (invitee.isCurrentUser) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserDeclinedInvitation,
        deletedChannelUrls: [channel.channelUrl],
      );
    } else {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserDeclinedInvitation,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onUserJoined(GroupChannel channel, User user) {
    if (user.isCurrentUser) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserJoined,
        addedChannels: [channel],
      );
    } else {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserJoined,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onUserLeft(GroupChannel channel, User user) {
    if (user.isCurrentUser) {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserLeft,
        deletedChannelUrls: [channel.channelUrl],
      );
    } else {
      _collectionManager.sendEventsToGroupChannelCollectionList(
        eventSource: CollectionEventSource.eventUserLeft,
        updatedChannels: [channel],
      );
    }
  }

  @override
  void onChannelHidden(GroupChannel channel) {
    _collectionManager.sendEventsToGroupChannelCollectionList(
      eventSource: CollectionEventSource.eventChannelHidden,
      updatedChannels: [channel],
    );
  }

  @override
  void onChannelMemberCountChanged(List<GroupChannel> channels) {
    _collectionManager.sendEventsToGroupChannelCollectionList(
      eventSource: CollectionEventSource.eventChannelMemberCountChanged,
      updatedChannels: channels,
    );
  }

  @override
  void onPinnedMessageUpdated(GroupChannel channel) {
    _collectionManager.sendEventsToGroupChannelCollectionList(
      eventSource: CollectionEventSource.eventPinnedMessageUpdated,
      updatedChannels: [channel],
    );
  }

//------------------------------//
// GroupChannelHandler - message
//------------------------------//
  @override
  void onPollVoted(GroupChannel channel, PollVoteEvent event) async {
    for (final messageCollection in _collectionManager.baseMessageCollections) {
      if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
        for (final message in messageCollection.messageList) {
          if (message.getMessageId() == event.messageId) {
            if (message is UserMessage && message.poll != null) {
              message.poll!.applyPollVoteEvent(event);
            }

            _collectionManager.sendEventsToMessageCollection(
              messageCollection: messageCollection,
              baseChannel: channel,
              eventSource: CollectionEventSource.eventPollVoted,
              sendingStatus: SendingStatus.succeeded,
              updatedMessages: [message],
            );
            break;
          }
        }
        break;
      }
    }
  }

  @override
  void onPollUpdated(GroupChannel channel, PollUpdateEvent event) async {
    for (final messageCollection in _collectionManager.baseMessageCollections) {
      if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
        for (final message in messageCollection.messageList) {
          if (message.getMessageId() == event.messageId) {
            if (message is UserMessage && message.poll != null) {
              message.poll!.applyPollUpdateEvent(event);
            }

            _collectionManager.sendEventsToMessageCollection(
              messageCollection: messageCollection,
              baseChannel: channel,
              eventSource: CollectionEventSource.eventPollUpdated,
              sendingStatus: SendingStatus.succeeded,
              updatedMessages: [message],
            );
            break;
          }
        }
        break;
      }
    }
  }

  @override
  void onPollDeleted(GroupChannel channel, int pollId) {
    // onPollDeleted() => onMessageDeleted()
  }
}

//------------------------------//
// FeedChannelHandler for collectionManager
//------------------------------//
class InternalFeedChannelHandlerForCollectionManager
    extends FeedChannelHandler {
  final CollectionManager _collectionManager;

  InternalFeedChannelHandlerForCollectionManager(
      CollectionManager collectionManager)
      : _collectionManager = collectionManager;

//------------------------------//
// FeedChannelHandler - channel
//------------------------------//
//   @override
//   void onMentionReceived(BaseChannel channel, NotificationMessage message) {
//     if (channel is FeedChannel) {
//       _collectionManager.sendEventsToMessageCollectionList(
//         eventSource: CollectionEventSource.eventMentionReceived,
//         updatedChannels: [channel],
//       );
//     }
//   }

  @override
  void onChannelChanged(BaseChannel channel) {
    if (channel is FeedChannel) {
      _collectionManager.sendEventsToMessageCollectionList(
        eventSource: CollectionEventSource.eventChannelChanged,
        updatedChannels: [channel],
      );
    }
  }

  // @override
  // void onChannelDeleted(String channelUrl, ChannelType channelType) {
  //   if (channelType == ChannelType.feed) {
  //     _collectionManager.sendEventsToMessageCollectionList(
  //       eventSource: CollectionEventSource.eventChannelDeleted,
  //       deletedChannelUrls: [channelUrl],
  //     );
  //   }
  // }

//------------------------------//
// FeedChannelHandler - message
//------------------------------//
  @override
  void onMessageReceived(
      BaseChannel channel, NotificationMessage message) async {
    if (channel is FeedChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: channel,
            eventSource: CollectionEventSource.eventMessageReceived,
            sendingStatus: SendingStatus.succeeded,
            addedMessages: [message],
            isReversedAddedMessages: messageCollection.params.reverse,
          );
          break;
        }
      }
    }
  }

// @override
// void onMessageUpdated(
//     BaseChannel channel, NotificationMessage message) async {
//   if (channel is FeedChannel) {
//     for (final messageCollection
//         in _collectionManager.baseMessageCollections) {
//       if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
//         _collectionManager.sendEventsToMessageCollection(
//           messageCollection: messageCollection,
//           baseChannel: channel,
//           eventSource: CollectionEventSource.eventMessageUpdated,
//           sendingStatus: SendingStatus.succeeded,
//           updatedMessages: [message],
//         );
//         break;
//       }
//     }
//   }
// }

// @override
// void onMessageDeleted(BaseChannel channel, String notificationId) async {
//   if (channel is FeedChannel) {
//     for (final messageCollection
//         in _collectionManager.baseMessageCollections) {
//       if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
//         _collectionManager.sendEventsToMessageCollection(
//           messageCollection: messageCollection,
//           baseChannel: channel,
//           eventSource: CollectionEventSource.eventMessageDeleted,
//           sendingStatus: SendingStatus.succeeded,
//           deletedMessageIds: [notificationId],
//         );
//         break;
//       }
//     }
//   }
// }

//------------------------------//
// FeedChannelHandler - channel
//------------------------------//
//   @override
//   void onReadStatusUpdated(FeedChannel channel) {
//     for (final messageCollection in _collectionManager.messageCollections) {
//       if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
//         _collectionManager.sendEventsToMessageCollectionList(
//           eventSource: CollectionEventSource.eventReadStatusUpdated,
//           updatedChannels: [channel],
//         );
//         break;
//       }
//     }
//   }
}
