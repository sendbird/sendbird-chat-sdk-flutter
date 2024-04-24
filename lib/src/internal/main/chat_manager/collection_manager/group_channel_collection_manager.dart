// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'collection_manager.dart';

extension GroupChannelCollectionManager on CollectionManager {
//------------------------------//
// Add and remove groupChannel collection
//------------------------------//
  void addGroupChannelCollection(GroupChannelCollection collection) {
    sbLog.d(StackTrace.current);

    groupChannelCollections.add(collection);
    _setInitialGroupChannelChangeLogsTs();
  }

  void removeGroupChannelCollection(GroupChannelCollection collection) {
    sbLog.d(StackTrace.current);

    groupChannelCollections.remove(collection);
    _setInitialMessageChangeLogsAndMessagesGapTs();
  }

//------------------------------//
// GroupChannel changeLogs
//------------------------------//
  Future<void> _requestGroupChannelChangeLogs({
    CollectionEventSource? eventSource,
  }) async {
    sbLog.d(StackTrace.current, '${eventSource?.toString()}');

    final params = GroupChannelChangeLogsParams();
    final List<GroupChannel> updatedChannels = [];
    final List<String> deletedChannelUrls = [];

    GroupChannelChangeLogs changeLogs;
    String? lastToken;
    String? token;

    //+ [DBManager]
    final info = await _chat.dbManager.getChannelInfo();
    if (info != null) {
      lastToken = info.lastChannelToken;
      token = lastToken;
    }
    //- [DBManager]

    bool hasMore = false;
    do {
      if (token == null) {
        changeLogs = await _chat.getMyGroupChannelChangeLogs(
          params,
          timestamp: lastRequestTsForGroupChannelChangeLogs,
        );
      } else {
        changeLogs = await _chat.getMyGroupChannelChangeLogs(
          params,
          token: token,
        );
      }

      updatedChannels.addAll(changeLogs.updatedChannels);
      deletedChannelUrls.addAll(changeLogs.deletedChannelUrls);

      hasMore = changeLogs.token != null && changeLogs.token != token;
      token = changeLogs.token;
    } while (hasMore); // [x] changeLogs.hasMore

    //+ [DBManager]
    if (token != null && token.isNotEmpty && token != lastToken) {
      ChannelInfo? channelInfo = await _chat.dbManager.getChannelInfo();
      if (channelInfo != null) {
        channelInfo.lastChannelToken = token;
      } else {
        channelInfo = ChannelInfo(lastChannelToken: token);
      }
      await _chat.dbManager.upsertChannelInfo(channelInfo);
    }
    //- [DBManager]

    sendEventsToGroupChannelCollectionList(
      eventSource: eventSource ?? CollectionEventSource.channelChangeLogs,
      updatedChannels: updatedChannels,
      deletedChannelUrls: deletedChannelUrls,
    );
  }

//------------------------------//
// Send events to groupChannel collection list
//------------------------------//
  void sendEventsToGroupChannelCollectionList({
    required CollectionEventSource eventSource,
    List<GroupChannel>? addedChannels,
    List<GroupChannel>? updatedChannels,
    List<String>? deletedChannelUrls,
  }) async {
    sbLog.d(StackTrace.current, eventSource.toString());

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      if (deletedChannelUrls != null) {
        await _chat.dbManager.deleteGroupChannels(deletedChannelUrls);
      }
      if (addedChannels != null) {
        await _chat.dbManager.upsertGroupChannels(addedChannels);
      }
      if (updatedChannels != null) {
        await _chat.dbManager.upsertGroupChannels(updatedChannels);
      }
    }
    //- [DBManager]

    if ((addedChannels != null && addedChannels.isNotEmpty) ||
        (updatedChannels != null && updatedChannels.isNotEmpty) ||
        (deletedChannelUrls != null && deletedChannelUrls.isNotEmpty)) {
      for (final channelCollection in groupChannelCollections) {
        sendEventsToGroupChannelCollection(
          channelCollection: channelCollection,
          eventSource: eventSource,
          addedChannels: addedChannels,
          updatedChannels: updatedChannels,
          deletedChannelUrls: deletedChannelUrls,
        );
      }
    }

    if ((updatedChannels != null && updatedChannels.isNotEmpty) ||
        (deletedChannelUrls != null && deletedChannelUrls.isNotEmpty)) {
      sendEventsToMessageCollectionList(
        eventSource: eventSource,
        updatedChannels: updatedChannels,
        deletedChannelUrls: deletedChannelUrls,
      );
    }
  }

//------------------------------//
// Send events to groupChannel collection
//------------------------------//
  void sendEventsToGroupChannelCollection({
    required GroupChannelCollection channelCollection,
    required CollectionEventSource eventSource,
    List<GroupChannel>? addedChannels,
    List<GroupChannel>? updatedChannels,
    List<String>? deletedChannelUrls,
  }) async {
    sbLog.d(StackTrace.current, eventSource.toString());

    //+ [DBManager]
    if (_chat.dbManager.isEnabled()) {
      if (eventSource == CollectionEventSource.channelLoadMore ||
          eventSource == CollectionEventSource.channelCacheLoadMore) {
        if (deletedChannelUrls != null) {
          await _chat.dbManager.deleteGroupChannels(deletedChannelUrls);
        }
        if (addedChannels != null) {
          await _chat.dbManager.upsertGroupChannels(addedChannels);
        }
        if (updatedChannels != null) {
          // Not used
          await _chat.dbManager.upsertGroupChannels(updatedChannels);
        }
      }
    }
    //- [DBManager]

    final List<GroupChannel> addedChannelsForEvent = [];
    final List<GroupChannel> updatedChannelsForEvent = [];
    final List<String> deletedChannelUrlsForEvent = [];

    // [First] delete
    if (deletedChannelUrls != null && deletedChannelUrls.isNotEmpty) {
      for (final deletedChannelUrl in deletedChannelUrls) {
        for (int index = 0;
            index < channelCollection.channelList.length;
            index++) {
          final channel = channelCollection.channelList[index];
          if (channel.channelUrl == deletedChannelUrl) {
            channelCollection.channelList.removeAt(index);
            deletedChannelUrlsForEvent.add(deletedChannelUrl);
            break;
          }
        }
      }
    }

    if (addedChannels != null && addedChannels.isNotEmpty) {
      for (final addedChannel in addedChannels) {
        if (!_isChannelExists(channelCollection, addedChannel.channelUrl)) {
          if (await channelCollection.canAddChannel(
              eventSource, addedChannel)) {
            addedChannelsForEvent.add(addedChannel);
          }
        }
      }

      if (addedChannelsForEvent.isNotEmpty) {
        _addChannel(channelCollection, addedChannelsForEvent);
      }
    }

    if (updatedChannels != null && updatedChannels.isNotEmpty) {
      for (final updatedChannel in updatedChannels) {
        bool isUpdatedChannelInChannelList = false;
        for (int index = 0;
            index < channelCollection.channelList.length;
            index++) {
          final channel = channelCollection.channelList[index];
          if (channel.channelUrl == updatedChannel.channelUrl) {
            // TODO: if (channel.updatedAt < updatedChannel.updatedAt)
            // Need to compare channel properties with updatedChannel
            // when eventSource is CollectionEventSource.channelChangeLogs (?)

            if (await channelCollection.canAddChannel(
                eventSource, updatedChannel,
                checkToUpdateChannel: true)) {
              channelCollection.channelList[index] = updatedChannel;
              updatedChannelsForEvent.add(updatedChannel);
            } else {
              channelCollection.channelList.removeAt(index);
              deletedChannelUrlsForEvent.add(updatedChannel.channelUrl);
            }

            isUpdatedChannelInChannelList = true;
            break;
          }
        }

        if (eventSource == CollectionEventSource.channelChangeLogs &&
            !isUpdatedChannelInChannelList) {
          if (!_isChannelExists(channelCollection, updatedChannel.channelUrl)) {
            if (await channelCollection.canAddChannel(
                eventSource, updatedChannel)) {
              addedChannelsForEvent.add(updatedChannel);
            }
          }
        }
      }

      if (addedChannelsForEvent.isNotEmpty) {
        _addChannel(channelCollection, addedChannelsForEvent);
      }
    }

    if (deletedChannelUrlsForEvent.isNotEmpty) {
      if (!channelCollection.isDisposed) {
        //+ [DBManager]
        CollectionEventSource source = eventSource;
        if (eventSource == CollectionEventSource.channelLoadMore) {
          source = CollectionEventSource.channelCacheLoadMore;
        }
        //- [DBManager]

        //+ [DBManager]
        if (source == CollectionEventSource.channelCacheLoadMore) {
          // Do not send this event.
          // Customer does not need this event.
        }
        //- [DBManager]
        else {
          channelCollection.handler.onChannelsDeleted(
              GroupChannelContext(source), deletedChannelUrlsForEvent);
        }
      }
    }

    if (addedChannelsForEvent.isNotEmpty) {
      channelCollection.sort();

      if (!channelCollection.isDisposed) {
        channelCollection.handler.onChannelsAdded(
            GroupChannelContext(eventSource), addedChannelsForEvent);
      }
    }

    if (updatedChannelsForEvent.isNotEmpty) {
      channelCollection.sort();

      if (!channelCollection.isDisposed) {
        channelCollection.handler.onChannelsUpdated(
            GroupChannelContext(eventSource), updatedChannelsForEvent);
      }
    }
  }

  bool _isChannelExists(GroupChannelCollection collection, String channelUrl) {
    for (final channel in collection.channelList) {
      if (channel.channelUrl == channelUrl) {
        return true;
      }
    }
    return false;
  }

  void _addChannel(
    GroupChannelCollection channelCollection,
    List<GroupChannel> addedChannels,
  ) {
    final channelList = channelCollection.channelList;
    for (final addedChannel in addedChannels) {
      bool isUpdated = false;

      for (int index = 0; index < channelList.length; index++) {
        final channel = channelList[index];
        if (addedChannel.channelUrl == channel.channelUrl) {
          channelList[index] = addedChannel;
          isUpdated = true;
          break;
        }
      }

      if (isUpdated == false) {
        channelList.add(addedChannel);
      }
    }
  }
}
