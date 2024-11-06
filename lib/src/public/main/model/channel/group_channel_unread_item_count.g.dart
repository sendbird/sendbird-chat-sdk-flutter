// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_channel_unread_item_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChannelUnreadItemCount _$GroupChannelUnreadItemCountFromJson(
        Map<String, dynamic> json) =>
    GroupChannelUnreadItemCount(
      groupChannelInvitationCount:
          (json['group_channel_invitation_count'] as num?)?.toInt(),
      groupChannelUnreadMentionCount:
          (json['group_channel_unread_mention_count'] as num?)?.toInt(),
      groupChannelUnreadMessageCount:
          (json['group_channel_unread_message_count'] as num?)?.toInt(),
      superGroupChannelInvitationCount:
          (json['super_group_channel_invitation_count'] as num?)?.toInt(),
      superGroupChannelUnreadMentionCount:
          (json['super_group_channel_unread_mention_count'] as num?)?.toInt(),
      superGroupChannelUnreadMessageCount:
          (json['super_group_channel_unread_message_count'] as num?)?.toInt(),
      nonSuperGroupChannelInvitationCount:
          (json['non_super_group_channel_invitation_count'] as num?)?.toInt(),
      nonSuperGroupChannelUnreadMentionCount:
          (json['non_super_group_channel_unread_mention_count'] as num?)
              ?.toInt(),
      nonSuperGroupChannelUnreadMessageCount:
          (json['non_super_group_channel_unread_message_count'] as num?)
              ?.toInt(),
    );
