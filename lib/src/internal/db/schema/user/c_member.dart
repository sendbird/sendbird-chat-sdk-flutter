// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:isar/isar.dart';
import 'package:sendbird_chat_sdk/src/internal/db/schema/user/c_user.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/member.dart';
import 'package:sendbird_chat_sdk/src/public/core/user/restricted_user.dart';
import 'package:sendbird_chat_sdk/src/public/main/define/enums.dart';

part 'c_member.g.dart';

@embedded
class CMember {
  late String userId; // CUser
  late String nickname; // CUser for filtering

  @enumerated
  late MemberState memberState;

  late bool isBlockedByMe;
  late bool isBlockingMe;
  late bool isMuted;

  @enumerated
  late Role role;

  CRestrictionInfo? restrictionInfo;

  CMember();

  factory CMember.fromMember(Member member) {
    return CMember()
      // User
      ..userId = member.userId
      ..nickname = member.nickname
      // Member
      ..memberState = member.memberState
      ..isBlockedByMe = member.isBlockedByMe
      ..isBlockingMe = member.isBlockingMe
      ..isMuted = member.isMuted
      ..role = member.role
      ..restrictionInfo = member.restrictionInfo != null
          ? CRestrictionInfo.fromRestrictionInfo(member.restrictionInfo!)
          : null;
  }

  Future<Member?> toMember(Chat chat, Isar isar) async {
    final cUser = await CUser.getCUser(chat, isar, userId);
    if (cUser == null) return null;

    final member = Member(
      // User
      userId: cUser.userId,
      nickname: cUser.nickname,
    )
      ..set(chat)
      // Member
      ..memberState = memberState
      ..isBlockedByMe = isBlockedByMe
      ..isBlockingMe = isBlockingMe
      ..isMuted = isMuted
      ..role = role
      ..restrictionInfo = restrictionInfo?.toRestrictionInfo();
    return CUser.setCUser(member, cUser) as Member;
  }
}

@embedded
class CRestrictionInfo {
  String? description;
  int? endAt;

  @enumerated
  late RestrictionType restrictionType;

  CRestrictionInfo();

  factory CRestrictionInfo.fromRestrictionInfo(RestrictionInfo info) {
    return CRestrictionInfo()
      ..description = info.description
      ..endAt = info.endAt
      ..restrictionType = info.restrictionType;
  }

  RestrictionInfo toRestrictionInfo() {
    return RestrictionInfo()
      ..description = description
      ..endAt = endAt
      ..restrictionType = restrictionType;
  }
}
