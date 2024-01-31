// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_user.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/sender.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'c_sender.g.dart';

@embedded
class CSender {
  late String userId; // CUser

  late bool isBlockedByMe;

  @enumerated
  late Role role;

  CSender();

  factory CSender.fromSender(Sender sender) {
    return CSender()
      // User
      ..userId = sender.userId
      // Sender
      ..isBlockedByMe = sender.isBlockedByMe
      ..role = sender.role;
  }

  Future<Sender?> toSender(Chat chat, Isar isar) async {
    final cUser = await CUser.getCUser(chat, isar, userId);
    if (cUser == null) return null;

    final sender = Sender(
      // User
      userId: cUser.userId,
      nickname: cUser.nickname,
    )
      ..set(chat)
      // Sender
      ..isBlockedByMe = isBlockedByMe
      ..role = role;
    return CUser.setCUser(sender, cUser) as Sender;
  }
}
