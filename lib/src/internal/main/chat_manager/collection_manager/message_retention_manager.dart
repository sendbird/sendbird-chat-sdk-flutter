// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat_manager/collection_manager/collection_manager.dart';
import 'package:sendbird_chat_sdk/src/internal/main/logger/sendbird_logger.dart';
import 'package:sendbird_chat_sdk/src/internal/main/model/application_settings.dart';
import 'package:sendbird_chat_sdk/src/internal/main/utils/json_converter.dart';
import 'package:sendbird_chat_sdk/src/internal/network/http/http_client/request/main/application_settings_get_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageRetentionManager {
  MessageRetentionManager._();

  static final MessageRetentionManager _instance = MessageRetentionManager._();

  factory MessageRetentionManager() => _instance;

  final String _configTsKey = 'com.sendbird.chat.config_ts';
  int? applicationSettingsLimit;
  int latestPaginationCount = 0;

  void checkApplicationSettings(Chat chat) async {
    sbLog.i(StackTrace.current, 'Started');

    try {
      int? lastConfigTs = await getConfigTs();
      String? token;
      ApplicationSettings settings;

      latestPaginationCount = 0;

      do {
        if (lastConfigTs != null && token == null) {
          sbLog.d(StackTrace.current,
              '[lastConfigTs] ${DateTime.fromMillisecondsSinceEpoch(lastConfigTs).toString()}');
        }

        settings = await _getApplicationSettings(
          chat,
          ts: token == null ? lastConfigTs : null,
          token: token,
          limit: applicationSettingsLimit,
        );

        sbLog.d(
            StackTrace.current,
            '\n[paginationCount] ${++latestPaginationCount}'
            '\n[settings] ${jsonEncoder.convert(settings.configs)}'
            '\n[hasMore] ${settings.hasMore}'
            '\n[token]: ${settings.next}'
            '\n[ts]: ${settings.ts}');

        final messagePurgeOffset = settings.configs['message_purge_offset'];
        if (messagePurgeOffset != null) {
          final groupChannels = await chat.dbManager
              .getGroupChannels(query: GroupChannelListQuery());

          for (final groupChannel in groupChannels) {
            int? ts;
            if (groupChannel.customType.isEmpty) {
              ts = messagePurgeOffset['global'];
            } else if (messagePurgeOffset[groupChannel.customType] != null) {
              ts = messagePurgeOffset[groupChannel.customType];
            } else {
              ts = messagePurgeOffset['global'];
            }

            if (ts != null && groupChannel.messageDeletionTimestamp != ts) {
              await syncGroupChannelMessages(
                chat,
                channel: groupChannel,
                messageDeletionTimestamp: ts,
                canNotifyChannelChanged: true,
              );
            }
          }
        }

        token = settings.next;
      } while (settings.hasMore);

      if (settings.ts != null) {
        setConfigTs(settings.ts!);
      }
    } catch (e) {
      sbLog.e(StackTrace.current, e.toString());
    }

    sbLog.i(StackTrace.current, 'Ended');
  }

  Future<void> syncGroupChannelMessages(
    Chat chat, {
    required GroupChannel channel,
    required int messageDeletionTimestamp,
    required bool canNotifyChannelChanged,
  }) async {
    // Channel
    if (channel.lastMessage?.createdAt != null &&
        channel.lastMessage!.createdAt <= messageDeletionTimestamp) {
      channel.lastMessage = null;

      if (canNotifyChannelChanged) {
        chat.eventManager.notifyChannelChanged(channel);
      }
    }

    // MessageCollection
    if (!await chat.collectionManager.updateMessageOffset(
      channelUrl: channel.channelUrl,
      messageOffset: messageDeletionTimestamp,
    )) {
      // Delete messages in DB if there is no MessageCollection in memory.
      final messages = await chat.dbManager.getMessages(
        channelType: ChannelType.group,
        channelUrl: channel.channelUrl,
        sendingStatus: SendingStatus.succeeded,
        timestamp: SendbirdChat.maxInt,
        params: MessageListParams(),
        isPrevious: true,
      );

      if (messages.isNotEmpty) {
        final messagesToDelete = messages.where((message) {
          return message.createdAt <= messageDeletionTimestamp;
        });

        if (messagesToDelete.isNotEmpty) {
          await chat.dbManager.deleteMessages(
            channel,
            messagesToDelete.map((e) => e.getMessageId().toString()).toList(),
          );
        }
      }
    }
  }

  Future<ApplicationSettings> _getApplicationSettings(
    Chat chat, {
    int? ts,
    String? token,
    int? limit,
  }) async {
    sbLog.i(StackTrace.current, 'token: $token');

    final settings = await chat.apiClient
        .send<ApplicationSettings>(ApplicationSettingsGetRequest(
      chat,
      ts: ts,
      token: token,
      limit: limit,
    ));
    return settings;
  }

  Future<bool> setConfigTs(int configTs) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(_configTsKey, configTs);
  }

  Future<int?> getConfigTs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_configTsKey);
  }

  Future<void> clearConfigTs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_configTsKey);
  }
}
