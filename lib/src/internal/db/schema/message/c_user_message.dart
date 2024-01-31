// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_base_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/c_root_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/message/meta/c_channel_message.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_sender.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/root_message.dart';
import 'package:sendbird_chat_sdk/src/public/core/message/user_message.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_data.dart';
import 'package:sendbird_chat_sdk/src/public/main/model/poll/poll_option.dart';

part 'c_user_message.g.dart';

@collection
class CUserMessage extends CBaseMessage {
  late String translations; // Map<String, String>
  List<String>? translationTargetLanguages;
  CPoll? poll;

  CUserMessage();

  factory CUserMessage.fromUserMessage(UserMessage message) {
    return CUserMessage()
      // BaseMessage
      ..setBaseMessage(message)
      // UserMessage
      ..translations = jsonEncode(message.translations)
      ..translationTargetLanguages = message.translationTargetLanguages
      ..poll = message.poll != null ? CPoll.fromPoll(message.poll!) : null;
  }

  Future<UserMessage> toUserMessage(Chat chat, Isar isar) async {
    final userMessage = UserMessage(
      // RootMessage
      channelUrl: channelUrl,
      channelType: channelType,
      // BaseMessage
      messageId: messageId,
      message: message,
      // UserMessage
      translations: (jsonDecode(translations) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString())),
    )..set(chat);
    return await CBaseMessage.setCBaseMessage(chat, isar, userMessage, this)
        as UserMessage
      // UserMessage
      ..translationTargetLanguages = translationTargetLanguages
      ..poll = poll?.toPoll();
  }

  static Future<CUserMessage> upsert(
      Chat chat, Isar isar, UserMessage message) async {
    final cUserMessage = CUserMessage.fromUserMessage(message);

    // RootMessage
    await CRootMessage.upsert(chat, isar, message);

    // BaseMessage
    await CBaseMessage.upsert(chat, isar, message);

    // UserMessage
    await chat.dbManager.write(() async {
      await isar.cUserMessages.put(cUserMessage);
    });

    // ChannelMessage
    await CChannelMessage.upsert(chat, isar, message);

    return cUserMessage;
  }

  static Future<UserMessage?> get(Chat chat, Isar isar, String rootId) async {
    final cUserMessage =
        await isar.cUserMessages.where().rootIdEqualTo(rootId).findFirst();
    return await cUserMessage?.toUserMessage(chat, isar);
  }

  static Future<void> delete(Chat chat, Isar isar, String rootId) async {
    // UserMessage
    await chat.dbManager.write(() async {
      await isar.cUserMessages.deleteByRootId(rootId);
    });

    // ChannelMessage
    await CChannelMessage.delete(chat, isar, rootId);
  }
}

@embedded
class CPoll {
  late int id;
  late String title;
  late int createdAt;
  late int updatedAt;
  late int closeAt;

  @enumerated
  late PollStatus status;

  int? messageId;
  CPollData? data;
  late int voterCount;
  late List<CPollOption> options;

  String? createdBy;
  late bool allowUserSuggestion;
  late bool allowMultipleVotes;
  List<int>? votedPollOptionIds;

  CPoll();

  factory CPoll.fromPoll(Poll poll) {
    return CPoll()
      ..id = poll.id
      ..title = poll.title
      ..createdAt = poll.createdAt
      ..updatedAt = poll.updatedAt
      ..closeAt = poll.closeAt
      ..status = poll.status
      ..messageId = poll.messageId
      ..data = poll.data != null ? CPollData.fromPollData(poll.data!) : null
      ..voterCount = poll.voterCount
      ..options = poll.options
          .map((option) => CPollOption.fromPollOption(option))
          .toList()
      ..createdBy = poll.createdBy
      ..allowUserSuggestion = poll.allowUserSuggestion
      ..allowMultipleVotes = poll.allowMultipleVotes
      ..votedPollOptionIds = poll.votedPollOptionIds;
  }

  Poll toPoll() {
    return Poll(
      id: id,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt,
      closeAt: closeAt,
      status: status,
    )
      ..messageId = messageId
      ..data = data?.toPollData()
      ..voterCount = voterCount
      ..options = options.map((option) => option.toPollOption()).toList()
      ..createdBy = createdBy
      ..allowUserSuggestion = allowUserSuggestion
      ..allowMultipleVotes = allowMultipleVotes
      ..votedPollOptionIds = votedPollOptionIds;
  }
}

@embedded
class CPollData {
  late String text;

  CPollData();

  factory CPollData.fromPollData(PollData data) {
    return CPollData()..text = data.text;
  }

  PollData toPollData() {
    return PollData()..text = text;
  }
}

@embedded
class CPollOption {
  late int pollId;
  late int id;
  late String text;
  String? createdBy;
  late int createdAt;
  late int voteCount;
  late int updatedAt;

  CPollOption();

  factory CPollOption.fromPollOption(PollOption option) {
    return CPollOption()
      ..pollId = option.pollId
      ..id = option.id
      ..text = option.text
      ..createdBy = option.createdBy
      ..createdAt = option.createdAt
      ..voteCount = option.voteCount
      ..updatedAt = option.updatedAt;
  }

  PollOption toPollOption() {
    return PollOption(
      pollId: pollId,
      id: id,
      text: text,
      createdAt: createdAt,
      voteCount: voteCount,
      updatedAt: updatedAt,
    )..createdBy = createdBy;
  }
}
