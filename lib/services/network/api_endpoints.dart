const needleRegex = r'{#}';
const needle = '{#}';
final RegExp exp = new RegExp(needleRegex);

extension Helpers on String {
  String format(List args) {
    Iterable<RegExpMatch> matches = exp.allMatches(this);
    assert(args.length == matches.length);

    var i = -1;
    return this.replaceAllMapped(exp, (match) {
      i = i + 1;
      return '${args[i]}';
    });
  }
}

class Users {
  static const users = '/v3/users';
  static const userid = '/v3/users/{#}';
  static const userid_push = '/v3/users/{#}/push';
  static const userid_push_tokentype = '/v3/users/{#}/push/{#}';
  static const userid_push_tokentype_token = '/v3/users/{#}/push/{#}/{#}';
  static const userid_push_type_device_tokens =
      '/v3/users/{#}/push/{#}/device_tokens';
  static const userid_readall = '/v3/users/{#}/mark_as_read_all';
  static const userid_block = '/v3/users/{#}/block';
  static const userid_block_targetid = '/v3/users/{#}/block/{#}';
  static const userid_unread_message_count =
      '/v3/users/{#}/unread_message_count';
  static const userid_unread_channel_count =
      '/v3/users/{#}/unread_channel_count';
  static const userid_push_preference = '/v3/users/{#}/push_preference';
  static const userid_push_preference_channelurl =
      '/v3/users/{#}/push_preference/{#}';
  static const userid_my_groupchannel = '/v3/users/{#}/my_group_channels';
  static const userid_push_template = '/v3/users/{#}/push/template';
  static const userid_channel_invitation_preference =
      '/v3/users/{#}/channel_invitation_preference';
  static const userid_metadata = '/v3/users/{#}/metadata';
  static const userid_metadata_key = '/v3/users/{#}/metadata/{#}';
  static const userid_groupchannel_count = '/v3/users/{#}/group_channel_count';
  static const userid_unread_item_count = '/v3/users/{#}/unread_item_count';
  static const userid_count_preference_channelurl =
      '/v3/users/{#}/count_preference/{#}';
  static const userid_groupchannel_changelogs =
      '/v3/users/{#}/my_group_channels/changelogs';
  static const userid_session_key = '/v3/users/{#}/session_key';

// #define SBD_API_USERS_USERID_FRIENDS @"/v3/users/{#}/friends"
// #define SBD_API_USERS_USERID_FRIENDS_USERID @"/v3/users/{#}/friends/{#}"
// #define SBD_API_USERS_USERID_FRIENDS_CHANGELOGS @"/v3/users/{#}/friends/changelogs"
// #define SBD_API_USERS_USERID_FRIENDDISCOVERIES @"/v3/users/{#}/friend_discoveries"
// #define SBD_API_USERS_USERID_FRIENDDISCOVERIES_DISCOVERYKEY @"/v3/users/{#}/friend_discoveries/%"
}

class Channels {
  static const channelurl = '/v3/{#}/{#}';
  static const channelurl_passively = '/v3/sdk/{#}/{#}';
  static const channelurl_ban = '/v3/{#}/{#}/ban';
  static const channelurl_ban_banned_userid = '/v3/{#}/{#}/ban/{#}';
  static const channelurl_mute = '/v3/{#}/{#}/mute';
  static const channelurl_mute_muted_userid = '/v3/{#}/{#}/mute/{#}';
  static const channelurl_freeze = '/v3/{#}/{#}/freeze';
  static const channelurl_operators = '/v3/{#}/{#}/operators';
  static const channelurl_scheduled_message = '/v3/{#}/{#}/scheduled_messages';
  static const channelurl_messages = '/v3/{#}/{#}/messages';
  static const channelurl_messages_changelogs =
      '/v3/{#}/{#}/messages/changelogs';
  static const channelurl_messages_messageid = '/v3/{#}/{#}/messages/{#}';
  static const channelurl_messages_messageid_metaarray =
      '/v3/{#}/{#}/messages/{#}/sorted_metaarray';
  static const channelurl_messages_messageid_translation =
      '/v3/{#}/{#}/messages/{#}/translation';
  static const channelurl_messages_messageid_reactions =
      '/v3/{#}/{#}/messages/{#}/reactions';
  static const channelurl_metadata = '/v3/{#}/{#}/metadata';
  static const channelurl_metadata_key = '/v3/{#}/{#}/metadata/{#}';
  static const channelurl_metacounter = '/v3/{#}/{#}/metacounter';
  static const channelurl_metacounter_key = '/v3/{#}/{#}/metacounter/{#}';
}

/// SDK
// #define SBD_API_SDK_USERS_USERID_PUSH_TOKENTYPE @"/v3/sdk/users/{#}/push/apns" // POST ONLY
// #define SBD_API_SDK_GROUPCHANNELS_CHANNELURL @"/v3/sdk/group_channels/{#}" // GET ONLY
// #define SBD_API_SDK_OPENCHANNELS_CHANNELURL @"/v3/sdk/open_channels/{#}" // GET ONLY

class OpenChannels {
  static const origin = '/v3/open_channels';
  static const channelurl = '/v3/open_channels/{#}';
  static const channelurl_members = '/v3/open_channels/{#}/participants';
}

class GroupChannels {
  static const origin = '/v3/group_channels';
  static const channelurl = '/v3/group_channels/{#}';
  static const channelurl_invite = '/v3/group_channels/{#}/invite';
  static const channelurl_accept = '/v3/group_channels/{#}/accept';
  static const channelurl_decline = '/v3/group_channels/{#}/decline';
  static const channelurl_hide = '/v3/group_channels/{#}/hide';
  static const channelurl_join = '/v3/group_channels/{#}/join';
  static const channelurl_leave = '/v3/group_channels/{#}/leave';
  static const channelurl_messages_read =
      '/v3/group_channels/{#}/messages/mark_as_read';
  static const channelurl_messages_delivered =
      '/v3/group_channels/{#}/messages/mark_as_delivered';
  static const channelurl_reset_history =
      '/v3/group_channels/{#}/reset_user_history';
  static const channelurl_members = '/v3/group_channels/{#}/members';
  static const channelurl_screenshot = '/v3/group_channels/{#}/screenshot/';
}

class Misc {
  static const report_channelurl = '/v3/report/{#}/{#}';
  static const report_channelurl_messageid = '/v3/report/{#}/{#}/messages/{#}';
  static const report_userid = '/v3/report/users/{#}';
  static const storage_upload_file = '/v3/storage/file';
  static const storage_profile_image = '/v3/storage/profile_image';
  static const search_messages = '/v3/search/messages';
  static const emoji = '/v3/emojis';
  static const emoji_emojiid = '/v3/emojis/{#}';
  static const emoji_categories = '/v3/emoji_categories';
  static const emoji_categories_categoryid = '/v3/emoji_categories/{#}';
}
