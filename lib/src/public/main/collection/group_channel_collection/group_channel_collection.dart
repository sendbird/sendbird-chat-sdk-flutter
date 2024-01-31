// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/channel/meta/channel_info.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';

/// Collection that handles channel lists.
class GroupChannelCollection {
  /// The List<[GroupChannel]> of total channel list.
  final List<GroupChannel> channelList = [];

  /// The group channel collection handler to be used for this [GroupChannelCollection].
  GroupChannelCollectionHandler get handler => _handler;

  /// Whether there's more data to load.
  bool get hasMore => _hasMore;

  /// Whether this collection is loading.
  bool get isLoading => _isLoading;

  /// Whether this collection is disposed.
  bool get isDisposed => _isDisposed;

  final GroupChannelListQuery _query;
  final GroupChannelCollectionHandler _handler;
  final Chat _chat;
  bool _isLoadedOnce = false;
  bool _isDisposed = false;
  bool _isLoading = false;
  bool _hasMore = true;

  //+ [DBManager]
  int _fetchedCount = 0;
  int _offset = 0;

  //- [DBManager]

  /// Constructor
  GroupChannelCollection({
    required GroupChannelListQuery query,
    required GroupChannelCollectionHandler handler,
  })  : _query = query,
        _handler = handler,
        _chat = query.chat {
    sbLog.i(StackTrace.current, 'GroupChannelCollection()');
    _chat.collectionManager.addGroupChannelCollection(this);

    if (_chat.dbManager.isEnabled()) {
      runZonedGuarded(() {
        _doBackSync(); // Do not await for performance
      }, (error, stack) {});

      runZonedGuarded(() {
        _chat.collectionManager
            .refreshGroupChannelCollections(); // Do not await for performance
      }, (error, stack) {});
    }

    //+ [DBManager]
    _chat.dbManager.appendLocalCacheStat(
      useLocalCache: _chat.chatContext.options.useCollectionCaching,
      useGroupChannelCollection: true,
    );
    //- [DBManager]
  }

  Future<void> _doBackSync() async {
    if (_chat.dbManager.isEnabled()) {
      final info = await _chat.dbManager.getChannelInfo();
      if (info == null || info.isChannelBackSyncCompleted == false) {
        final backSyncQuery = GroupChannelListQuery()
          ..limit = 100
          ..order = GroupChannelListQueryOrder.chronological
          ..includeChatNotification = false; // Unsupported filter

        do {
          final channels = await backSyncQuery.next();
          if (channels.isNotEmpty) {
            await _chat.dbManager.upsertGroupChannels(channels);
          }
        } while (backSyncQuery.hasNext);

        ChannelInfo? channelInfo = await _chat.dbManager.getChannelInfo();
        if (channelInfo != null) {
          channelInfo.isChannelBackSyncCompleted = true;
        } else {
          channelInfo = ChannelInfo(isChannelBackSyncCompleted: true);
        }
        await _chat.dbManager.upsertChannelInfo(channelInfo);
      }
    }
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
    if (_isDisposed) {
      throw InvalidCollectionDisposedException();
    }

    sbLog.i(StackTrace.current, 'loadMore()');

    _isLoading = true;
    _isLoadedOnce = true;

    //+ [DBManager]
    List<GroupChannel> localChannels = [];
    if (_chat.dbManager.isEnabled()) {
      final info = await _chat.dbManager.getChannelInfo();
      if (info != null && info.isChannelBackSyncCompleted) {
        final channels = await _chat.dbManager
            .getGroupChannels(query: _query, offset: _offset);
        if (channels.isNotEmpty) {
          localChannels.addAll(channels);
        }

        if (_query.limit == localChannels.length) {
          final channels = await _chat.dbManager
              .getGroupChannels(query: _query, offset: _offset + _query.limit);
          _hasMore = channels.isNotEmpty;
        } else {
          _hasMore = false;
        }

        if (localChannels.isNotEmpty) {
          _chat.collectionManager.sendEventsToGroupChannelCollection(
            channelCollection: this,
            eventSource: CollectionEventSource.channelCacheLoadMore,
            addedChannels: localChannels,
          );
        }
      }
    }
    //- [DBManager]

    try {
      if (localChannels.isNotEmpty) {
        //+ [DBManager]
        if (_chat.dbManager.isEnabled()) {
          _offset += localChannels.length; // Check
        }
        //- [DBManager]
      } else {
        final channels = await _query.next();

        _hasMore = _query.hasNext;

        if (channels.isNotEmpty) {
          //+ [DBManager]
          if (_chat.dbManager.isEnabled()) {
            final List<GroupChannel> addedChannels = [...channels];
            final Set<String> deletedChannelUrls =
                localChannels.map((e) => e.channelUrl).toSet();
            deletedChannelUrls.addAll(
                channelList.sublist(_fetchedCount).map((e) => e.channelUrl));

            _fetchedCount += channels.length;
            _offset = _fetchedCount;

            _chat.collectionManager.sendEventsToGroupChannelCollection(
              channelCollection: this,
              eventSource: CollectionEventSource.channelLoadMore,
              addedChannels: addedChannels,
              deletedChannelUrls: deletedChannelUrls.toList(),
            );
          }
          //- [DBManager]
          else {
            _chat.collectionManager.sendEventsToGroupChannelCollection(
              channelCollection: this,
              eventSource: CollectionEventSource.channelLoadMore,
              addedChannels: channels,
            );
          }
        }
      }
    } catch (e) {
      //+ [DBManager]
      if (_chat.dbManager.isEnabled()) {
        _offset += localChannels.length; // Check
      }
      //- [DBManager]
    }

    _isLoading = false;
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
          } else if (a.createdAt != null && b.createdAt != null) {
            return b.createdAt!.compareTo(a.createdAt!);
          }
          return 0;
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
    GroupChannel addedChannel, {
    bool checkToUpdateChannel = false,
  }) {
    if (eventSource == CollectionEventSource.channelCacheLoadMore ||
        eventSource == CollectionEventSource.channelLoadMore) {
      return true;
    }

    if (_isLoadedOnce == false) {
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
            if (checkToUpdateChannel) return true;
            return false;
          } else if (a.lastMessage == null && b.lastMessage != null) {
            // return true
          } else if (a.lastMessage != null && b.lastMessage != null) {
            if (b.lastMessage!.createdAt.compareTo(a.lastMessage!.createdAt) ==
                -1) {
              // a.lastMessage!.createdAt > b.lastMessage!.createdAt
              if (checkToUpdateChannel) return true;
              return false;
            }
          } else if (a.createdAt != null && b.createdAt != null) {
            if (b.createdAt!.compareTo(a.createdAt!) == -1) {
              // a.createdAt > b.createdAt
              return false;
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
          // return true
          break;
      }
    }

    return true;
  }
}
