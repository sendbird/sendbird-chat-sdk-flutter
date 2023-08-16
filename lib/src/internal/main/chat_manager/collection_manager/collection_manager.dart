// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:math';

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/extensions/extensions.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/channel/message/channel_messages_gap_request.dart';
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
  final Map<String, int> lastRequestTsForMessageChangeLogs = {};
  final Map<String, int> lastRequestTsForPollChangeLogs = {};
  final Map<String, int> lastRequestTsForMessagesGap = {};

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

//------------------------------//
// Reconnected
//------------------------------//
  void onReconnected() {
    sbLog.d(StackTrace.current, 'onReconnected()');
    _refreshGroupChannelCollections();
    _refreshBaseMessageCollections();
  }

  void _refreshGroupChannelCollections() {
    if (groupChannelCollections.isNotEmpty) {
      requestGroupChannelChangeLogs();
    }
  }

  void _refreshBaseMessageCollections() {
    for (final collection in baseMessageCollections) {
      if (collection.isInitialized) {
        _requestMessageChangeLogs(collection);
        _requestPollChangeLogs(collection);
        _requestMessagesGap(collection);
      }
    }
  }

  void refreshNotificationCollections() {
    for (final collection in baseMessageCollections) {
      if (collection is NotificationCollection) {
        if (collection.isInitialized) {
          _requestMessageChangeLogs(collection);
          _requestMessagesGap(collection);
        }
      }
    }
  }

  Future<void> refreshNotificationCollection({
    required String channelUrl,
  }) async {
    List<Future<dynamic>> futures = [];

    for (final collection in baseMessageCollections) {
      if (collection is NotificationCollection) {
        if (collection.isInitialized) {
          if (collection.baseChannel.channelUrl == channelUrl) {
            futures.add(_requestMessageChangeLogs(collection));
            futures.add(_requestMessagesGap(collection));
            break;
          }
        }
      }
    }

    if (futures.isNotEmpty) {
      await Future.wait(futures);
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
  void onMentionReceived(BaseChannel channel, BaseMessage message) {
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
  void onMessageReceived(BaseChannel channel, BaseMessage message) async {
    if (channel is GroupChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: channel,
            eventSource: CollectionEventSource.eventMessageReceived,
            sendingStatus: SendingStatus.succeeded,
            addedMessages: [message],
          );
          break;
        }
      }
    }
  }

  @override
  void onMessageUpdated(BaseChannel channel, BaseMessage message) async {
    if (channel is GroupChannel) {
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
            deletedMessageIds: [messageId],
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
            if (message.messageId == event.messageId) {
              message.applyReactionEvent(event);

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
            if (message.messageId == event.targetMessageId) {
              message.applyThreadInfoUpdateEvent(event);

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
          if (message.messageId == event.messageId) {
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
          if (message.messageId == event.messageId) {
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
// BaseChannelHandler - channel
//------------------------------//
  @override
  void onMentionReceived(BaseChannel channel, BaseMessage message) {
    if (channel is FeedChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollectionList(
            eventSource: CollectionEventSource.eventMentionReceived,
            updatedChannels: [channel],
          );
          break;
        }
      }
    }
  }

  @override
  void onChannelChanged(BaseChannel channel) {
    if (channel is FeedChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollectionList(
            eventSource: CollectionEventSource.eventChannelChanged,
            updatedChannels: [channel],
          );
          break;
        }
      }
    }
  }

  @override
  void onChannelDeleted(String channelUrl, ChannelType channelType) {
    if (channelType == ChannelType.feed) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channelUrl) {
          _collectionManager.sendEventsToMessageCollectionList(
            eventSource: CollectionEventSource.eventChannelDeleted,
            deletedChannelUrls: [channelUrl],
          );
          break;
        }
      }
    }
  }

//------------------------------//
// BaseChannelHandler - message
//------------------------------//
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) async {
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
          );
          break;
        }
      }
    }
  }

  @override
  void onMessageUpdated(BaseChannel channel, BaseMessage message) async {
    if (channel is FeedChannel) {
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
    if (channel is FeedChannel) {
      for (final messageCollection
          in _collectionManager.baseMessageCollections) {
        if (messageCollection.baseChannel.channelUrl == channel.channelUrl) {
          _collectionManager.sendEventsToMessageCollection(
            messageCollection: messageCollection,
            baseChannel: channel,
            eventSource: CollectionEventSource.eventMessageDeleted,
            sendingStatus: SendingStatus.succeeded,
            deletedMessageIds: [messageId],
          );
          break;
        }
      }
    }
  }

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
