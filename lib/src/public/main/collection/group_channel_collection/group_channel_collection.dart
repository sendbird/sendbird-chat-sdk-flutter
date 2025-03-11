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
  bool _areGroupChannelChangeLogsFetchedOnce = false;

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

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      if (_chat.collectionManager.isDoingGroupChannelBackSync == false) {
        _chat.collectionManager.isDoingGroupChannelBackSync = true;
        runZonedGuarded(() async {
          await _doBackSync(); // Do not await for performance
          _chat.collectionManager.isDoingGroupChannelBackSync = false;
        }, (error, stack) {
          _chat.collectionManager.isDoingGroupChannelBackSync = false;
        });
      }
    }
    //- [DBManager]

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

  void cleanUp() {
    // Check
  }

  /// Disposes current [GroupChannelCollection] and stops all events from being received.
  void dispose() {
    sbLog.i(StackTrace.current, 'dispose()');
    cleanUp();

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
          await _chat.collectionManager.sendEventsToGroupChannelCollection(
            channelCollection: this,
            eventSource: CollectionEventSource.channelCacheLoadMore,
            addedChannels: localChannels,
          );
        }

        if (_areGroupChannelChangeLogsFetchedOnce == false) {
          _areGroupChannelChangeLogsFetchedOnce = true;
          // Check
          runZonedGuarded(() {
            _chat.collectionManager
                .refreshGroupChannelCollections(); // Do not await for performance
          }, (error, stack) {});
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

            await _chat.collectionManager.sendEventsToGroupChannelCollection(
              channelCollection: this,
              eventSource: CollectionEventSource.channelLoadMore,
              addedChannels: addedChannels,
              deletedChannelUrls: deletedChannelUrls.toList(),
            );
          }
          //- [DBManager]
          else {
            await _chat.collectionManager.sendEventsToGroupChannelCollection(
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
      else {
        rethrow;
      }
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

  Future<bool> canAddChannel(
    CollectionEventSource eventSource,
    GroupChannel addedChannel, {
    bool checkToUpdateChannel = false,
  }) async {
    if (_isLoadedOnce == false) {
      return false;
    }

    if (_query.includeEmpty == false) {
      if (checkToUpdateChannel) {
        // This is related to messageDeletionTimestamp.
        if (eventSource == CollectionEventSource.eventChannelChanged) {
          if (addedChannel.lastMessage == null) {
            return false;
          }
        }
      } else {
        if (eventSource == CollectionEventSource.channelCacheLoadMore ||
            eventSource == CollectionEventSource.channelLoadMore) {
          if (addedChannel.lastMessage == null) {
            return false;
          }
        } else if (eventSource == CollectionEventSource.eventMessageSent) {
          if (addedChannel.lastMessage == null) {
            return true; // Check
          }
        }
      }
    }

    if (eventSource == CollectionEventSource.channelCacheLoadMore ||
        eventSource == CollectionEventSource.channelLoadMore) {
      return true;
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

    if (checkToUpdateChannel) {
      if (eventSource == CollectionEventSource.eventChannelHidden) {
        return _canAddChannel(query: _query, channel: addedChannel);
      }
    } else {
      //+ DBManager
      if (_chat.dbManager.isEnabled()) {
        if (await _chat.dbManager.canAddChannel(
                query: _query, channelUrl: addedChannel.channelUrl) ==
            false) {
          return false;
        }
      }
      //- DBManager
      else {
        if (_canAddChannel(query: _query, channel: addedChannel) == false) {
          return false;
        }
      }
    }

    return true;
  }

  bool _canAddChannel({
    required GroupChannelListQuery query,
    required GroupChannel channel,
  }) {
    // [channelUrlsFilter]
    if (query.channelUrlsFilter.isNotEmpty) {
      bool found = false;
      for (final channelUrl in query.channelUrlsFilter) {
        if (channel.channelUrl == channelUrl) {
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }
    }

    // [myMemberStateFilter]
    switch (query.myMemberStateFilter) {
      case MyMemberStateFilter.all:
        break;
      case MyMemberStateFilter.invited:
        if (channel.myMemberState != MemberState.invited) {
          return false;
        }
        break;
      case MyMemberStateFilter.joined:
        if (channel.myMemberState != MemberState.joined) {
          return false;
        }
        break;
      case MyMemberStateFilter.invitedByFriend:
        if (channel.myMemberState != MemberState.invited) {
          return false;
        }
        // Check
        break;
      case MyMemberStateFilter.invitedByNonFriend:
        if (channel.myMemberState != MemberState.invited) {
          return false;
        }
        // Check
        break;
    }

    // [superChannelFilter]
    switch (query.superChannelFilter) {
      case SuperChannelFilter.all:
        break;
      case SuperChannelFilter.exclusiveChannelOnly:
        if (channel.isExclusive == false) {
          return false;
        }
        break;
      case SuperChannelFilter.superChannelOnly:
        if (channel.isSuper == false) {
          return false;
        }
        break;
      case SuperChannelFilter.nonsuperChannelOnly:
        if (channel.isSuper) {
          return false;
        }
        break;
      case SuperChannelFilter.broadcastChannelOnly:
        if (channel.isBroadcast == false) {
          return false;
        }
        break;
    }

    // [publicChannelFilter]
    switch (query.publicChannelFilter) {
      case PublicChannelFilter.all:
        break;
      case PublicChannelFilter.public:
        if (channel.isPublic == false) {
          return false;
        }
        break;
      case PublicChannelFilter.private:
        if (channel.isPublic) {
          return false;
        }
        break;
    }

    // [unreadChannelFilter]
    switch (query.unreadChannelFilter) {
      case UnreadChannelFilter.all:
        break;
      case UnreadChannelFilter.unreadMessage:
        if (channel.unreadMessageCount <= 0) {
          return false;
        }
        break;
    }

    // [hiddenChannelFilter]
    switch (query.hiddenChannelFilter) {
      case HiddenChannelFilter.all:
        break;
      case HiddenChannelFilter.unhidden:
        if (channel.isHidden) {
          return false;
        }
        break;
      case HiddenChannelFilter.hidden:
        if (channel.isHidden == false) {
          return false;
        }
        break;
      case HiddenChannelFilter.hiddenAllowAutoUnhide:
        if (channel.isHidden == false) {
          return false;
        }
        if (channel.hiddenState != GroupChannelHiddenState.allowAutoUnhide) {
          return false;
        }
        break;
      case HiddenChannelFilter.hiddenPreventAutoUnhide:
        if (channel.isHidden == false) {
          return false;
        }
        if (channel.hiddenState != GroupChannelHiddenState.preventAutoUnhide) {
          return false;
        }
        break;
    }

    // [customTypeStartsWithFilter]
    if (query.customTypeStartsWithFilter != null &&
        query.customTypeStartsWithFilter!.isNotEmpty) {
      if (channel.customType.startsWith(query.customTypeStartsWithFilter!) ==
          false) {
        return false;
      }
    }

    // [customTypesFilter]
    if (query.customTypesFilter.isNotEmpty) {
      bool found = false;
      for (final customType in query.customTypesFilter) {
        if (channel.customType == customType) {
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }
    }

    // [nicknameContainsFilter]
    if (query.nicknameContainsFilter != null &&
        query.nicknameContainsFilter!.isNotEmpty) {
      bool found = false;
      for (final member in channel.members) {
        if (member.nickname.isNotEmpty &&
            member.nickname.contains(query.nicknameContainsFilter!)) {
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }
    }

    // [userIdsIncludeFilter & queryType]
    if (query.userIdsIncludeFilter.isNotEmpty) {
      bool found = false;
      if (query.queryType == GroupChannelListQueryType.and) {
        for (final userId in query.userIdsIncludeFilter) {
          for (final member in channel.members) {
            if (member.userId == userId) {
              found = true;
              break;
            }
          }
          if (!found) {
            return false;
          }
        }
      } else if (query.queryType == GroupChannelListQueryType.or) {
        for (final userId in query.userIdsIncludeFilter) {
          for (final member in channel.members) {
            if (member.userId == userId) {
              found = true;
              break;
            }
          }
          if (found) {
            break;
          }
        }
      }

      if (!found) {
        return false;
      }
    }

    // [userIdsExactFilter]
    if (query.userIdsExactFilter.isNotEmpty) {
      if (channel.members.length != query.userIdsExactFilter.length) {
        return false;
      }

      bool found = false;
      for (final userId in query.userIdsExactFilter) {
        for (final member in channel.members) {
          if (member.userId == userId) {
            found = true;
            break;
          }
        }
        if (!found) {
          return false;
        }
      }

      if (!found) {
        return false;
      }
    }

    // [channelNameContainsFilter]
    if (query.channelNameContainsFilter != null &&
        query.channelNameContainsFilter!.isNotEmpty) {
      if (channel.name.contains(query.channelNameContainsFilter!) == false) {
        return false;
      }
    }

    // [metaDataOrderKeyFilter]
    // Must call API, because this can not be queried with local cache.

    // [metaDataKey & metaDataValues]
    // Must call API, because this can not be queried with local cache.

    // [metaDataKey & metaDataValueStartsWith]
    // Must call API, because this can not be queried with local cache.

    // [searchQuery & searchFields]
    if (query.searchQuery != null && query.searchQuery!.isNotEmpty) {
      for (final searchField in query.searchFields) {
        switch (searchField) {
          case GroupChannelListQuerySearchField.memberNickname:
            bool found = false;
            for (final member in channel.members) {
              if (member.nickname.contains(query.searchQuery!)) {
                found = true;
                break;
              }
            }

            if (!found) {
              return false;
            }
            break;
          case GroupChannelListQuerySearchField.channelName:
            if (channel.name.contains(query.searchQuery!) == false) {
              return false;
            }
            break;
        }
      }
    }

    // [includeEmpty]
    if (query.includeEmpty == false) {
      if (channel.lastMessage == null) {
        return false;
      }
    }

    // [includeFrozen]
    if (query.includeFrozen == false) {
      if (channel.isFrozen) {
        return false;
      }
    }

    // [includeMetaData]
    // When calling API, this value have to be `true` to make chunk.
    // But we must always call API for GroupChannel, because we must always get `hasNext` value from API.
    // So we do not need the chunk for GroupChannel.

    // [includeChatNotification]
    if (query.includeChatNotification == false) {
      if (channel.isChatNotification) {
        return false;
      }
    }

    // [createdBefore]
    if (query.createdBefore != null) {
      if (channel.createdAt != null) {
        if (channel.createdAt! >= query.createdBefore!) {
          return false;
        }
      }
    }

    // [createdAfter]
    if (query.createdAfter != null) {
      if (channel.createdAt != null) {
        if (channel.createdAt! <= query.createdAfter!) {
          return false;
        }
      }
    }

    return true;
  }
}
