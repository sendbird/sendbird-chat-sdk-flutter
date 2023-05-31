// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat/sendbird_chat.dart';
import 'package:sendbird_chat/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat/src/internal/main/logger/sendbird_logger.dart';

/// Collection that handles channel lists.
class GroupChannelCollection {
  /// The List<[GroupChannel]> of total channel list.
  final List<GroupChannel> channelList = [];

  /// The group channel collection handler to be used for this [GroupChannelCollection].
  GroupChannelCollectionHandler get handler => _handler;

  /// Whether there's more data to load.
  bool get hasMore => _isLoaded ? _query.hasNext : false;

  /// Whether this collection is loading.
  bool get isLoading => _query.isLoading;

  /// Whether this collection is disposed.
  bool get isDisposed => _isDisposed;

  final GroupChannelListQuery _query;
  final GroupChannelCollectionHandler _handler;
  final Chat _chat;
  bool _isLoaded = false;
  bool _isDisposed = false;

  /// Constructor
  GroupChannelCollection({
    required GroupChannelListQuery query,
    required GroupChannelCollectionHandler handler,
  })  : _query = query,
        _handler = handler,
        _chat = query.chat {
    sbLog.i(StackTrace.current, 'GroupChannelCollection()');
    _chat.collectionManager.addGroupChannelCollection(this);
  }

  /// Disposes current [GroupChannelCollection] and stops all events from being received.
  void dispose() {
    sbLog.i(StackTrace.current, 'dispose()');
    channelList.clear();
    _chat.collectionManager.removeGroupChannelCollection(this);
    _isDisposed = true;
  }

  /// Loads next channel lists, depending on the [GroupChannelListQueryOrder] set in the current collection.
  Future<void> loadMore() async {
    if (_isDisposed) return;

    sbLog.i(StackTrace.current, 'loadMore()');
    final channels = await _query.next();

    _isLoaded = true;

    if (channels.isNotEmpty) {
      _chat.collectionManager.sendEventsToGroupChannelCollection(
        channelCollection: this,
        eventSource: CollectionEventSource.channelLoadMore,
        addedChannels: channels,
      );
    }
  }

  void sort() {
    switch (_query.order) {
      case GroupChannelListQueryOrder.chronological:
        channelList.sort((a, b) {
          if (a.createdAt != null && b.createdAt != null) {
            return b.createdAt!.compareTo(a.createdAt!);
          }
          return 0;
        });
        break;

      case GroupChannelListQueryOrder.latestLastMessage:
        channelList.sort((a, b) {
          if (a.lastMessage != null && b.lastMessage == null) {
            return -1;
          } else if (a.lastMessage == null && b.lastMessage != null) {
            return 1;
          } else if (a.lastMessage != null && b.lastMessage != null) {
            return b.lastMessage!.createdAt.compareTo(a.lastMessage!.createdAt);
          } else {
            if (a.createdAt != null && b.createdAt != null) {
              return b.createdAt!.compareTo(a.createdAt!);
            }
            return 0;
          }
        });
        break;

      case GroupChannelListQueryOrder.channelNameAlphabetical:
        channelList.sort((a, b) {
          return a.name.compareTo(b.name);
        });
        break;

      case GroupChannelListQueryOrder.metadataValueAlphabetical:
        // TODO: (?)
        break;
    }
  }

  bool canAddChannel(
    CollectionEventSource eventSource,
    GroupChannel addedChannel,
  ) {
    if (eventSource == CollectionEventSource.channelLoadMore) {
      return true;
    }

    if (channelList.isEmpty) {
      return false;
    }

    if (channelList.isNotEmpty && hasMore) {
      final a = channelList.last;
      final b = addedChannel;
      switch (_query.order) {
        case GroupChannelListQueryOrder.chronological:
          if (a.createdAt != null && b.createdAt != null) {
            if (b.createdAt!.compareTo(a.createdAt!) == -1) {
              // a.createdAt > b.createdAt
              return false;
            }
          }
          break;

        case GroupChannelListQueryOrder.latestLastMessage:
          if (a.lastMessage != null && b.lastMessage == null) {
            // a < b
            return false;
          } else if (a.lastMessage == null && b.lastMessage != null) {
          } else if (a.lastMessage != null && b.lastMessage != null) {
            if (b.lastMessage!.createdAt.compareTo(a.lastMessage!.createdAt) ==
                -1) {
              // a.lastMessage!.createdAt > b.lastMessage!.createdAt
              return false;
            }
          } else {
            if (a.createdAt != null && b.createdAt != null) {
              if (b.createdAt!.compareTo(a.createdAt!) == -1) {
                // a.createdAt > b.createdAt
                return false;
              }
            }
          }
          break;

        case GroupChannelListQueryOrder.channelNameAlphabetical:
          if (a.name.compareTo(b.name) == -1) {
            // a.name < b.name
            return false;
          }
          break;

        case GroupChannelListQueryOrder.metadataValueAlphabetical:
          // TODO: (?)
          break;
      }
    }
    return true;
  }
}
