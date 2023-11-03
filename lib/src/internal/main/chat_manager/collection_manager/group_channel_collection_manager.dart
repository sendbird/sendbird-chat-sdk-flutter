// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'collection_manager.dart';

extension GroupChannelCollectionManager on CollectionManager {
//------------------------------//
// Add and remove groupChannel collection
//------------------------------//
  void addGroupChannelCollection(GroupChannelCollection collection) {
    groupChannelCollections.add(collection);

    final now = DateTime.now().millisecondsSinceEpoch;
    if (lastRequestTsForGroupChannelChangeLogs == 0) {
      lastRequestTsForGroupChannelChangeLogs = now;
    }
  }

  void removeGroupChannelCollection(GroupChannelCollection collection) {
    groupChannelCollections.remove(collection);
  }

//------------------------------//
// GroupChannel changeLogs
//------------------------------//
  Future<void> _requestGroupChannelChangeLogs(
      {CollectionEventSource? eventSource}) async {
    final params = GroupChannelChangeLogsParams();
    final List<GroupChannel> updatedChannels = [];
    final List<String> deletedChannelUrls = [];

    GroupChannelChangeLogs changeLogs;
    String? token;

    do {
      final now = DateTime.now().millisecondsSinceEpoch;

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

      lastRequestTsForGroupChannelChangeLogs = now;
      token = changeLogs.token;
    } while (changeLogs.hasMore);

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
  }) {
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
  }) {
    final List<GroupChannel> addedChannelsForEvent = [];
    final List<GroupChannel> updatedChannelsForEvent = [];
    final List<String> deletedChannelUrlsForEvent = [];

    if (addedChannels != null && addedChannels.isNotEmpty) {
      for (final addedChannel in addedChannels) {
        bool isChannelExists = false;
        for (final channel in channelCollection.channelList) {
          if (channel.channelUrl == addedChannel.channelUrl) {
            isChannelExists = true;
            break;
          }
        }

        if (!isChannelExists) {
          if (channelCollection.channelList.isEmpty) {
            addedChannelsForEvent.add(addedChannel);
          } else if (channelCollection.canAddChannel(
              eventSource, addedChannel)) {
            addedChannelsForEvent.add(addedChannel);
          }
        }
      }

      if (addedChannelsForEvent.isNotEmpty) {
        channelCollection.channelList.addAll(addedChannelsForEvent);
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

            if (channelCollection.canAddChannel(eventSource, updatedChannel)) {
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
          if (channelCollection.canAddChannel(eventSource, updatedChannel)) {
            addedChannelsForEvent.add(updatedChannel);
          }
        }
      }

      if (addedChannelsForEvent.isNotEmpty) {
        channelCollection.channelList.addAll(addedChannelsForEvent);
      }
    }

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

    if (deletedChannelUrlsForEvent.isNotEmpty) {
      if (!channelCollection.isDisposed) {
        channelCollection.handler.onChannelsDeleted(
            GroupChannelContext(eventSource), deletedChannelUrlsForEvent);
      }
    }
  }
}
