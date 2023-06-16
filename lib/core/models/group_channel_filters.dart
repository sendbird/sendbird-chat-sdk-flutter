import 'package:json_annotation/json_annotation.dart';
import 'package:sendbird_sdk/constant/enums.dart';

part 'group_channel_filters.g.dart';

/// Represents a group of filter that is used for group channel query.
@JsonSerializable()
class GroupChannelFilter {
  /// Sets the member state filter
  @JsonKey(toJson: memberStateFilterEnumForQuery)
  MemberStateFilter memberStateFilter = MemberStateFilter.all;

  /// Sets to filter super channel. Default is `all`
  @JsonKey(toJson: groupChannelSuperFilterEnum)
  SuperChannelFilter superMode = SuperChannelFilter.all;

  /// Sets to filter public channel. Default is `all`
  PublicChannelFilter publicMode = PublicChannelFilter.all;

  /// Sets to filter channels by custom type that starts with
  String? customTypeStartswith;

  /// Sets the custom type filter.
  List<String>? customTypes;

  /// Sets the filter with nickname. Query result will contains
  /// channels that any one of member contains given nickname
  String? membersNicknameContains;

  /// Sets the filter with user IDs that query result will return
  /// if any one of user id matches with channel's members
  @JsonKey(ignore: true)
  List<String>? membersIncludeIn;

  /// Sets the filter with user IDs that query result will return
  /// only if channel's members are exactly matched with this property
  List<String>? membersExactlyIn;

  /// Sets a filter to return only channels that contains the
  /// specified group channel name
  String? nameContains;

  /// Sets to filter channels by the unread messages.
  /// The default value is `all`
  UnreadChannelFilter unreadFilter = UnreadChannelFilter.all;

  /// Sets a key for ordering by value in the metadata.
  /// This is valid when the `order` is `channelMetaDataValueAlphabetical` only
  @JsonKey(ignore: true)
  String? metadataOrderKey;

  /// Sets to filter channels by the hidden state.
  /// The default value is `unhiddenOnly`
  ChannelHiddenStateFilter hiddenMode = ChannelHiddenStateFilter.unhiddenOnly;

  @JsonKey(name: 'public_membership_mode')
  PublicGroupChannelMembershipFilter publicMembershipFilter =
      PublicGroupChannelMembershipFilter.all;

  /// Searches for group channels with metadata containing an item with the
  /// specified value as its key
  @JsonKey(name: 'metadata_key')
  String? metaDataKey;

  /// Searches for group channels with metadata containing an item with the
  /// key specified by the metaDataKey
  @JsonKey(name: 'metadata_values')
  List<String>? metaDataValues;

  /// Searches for group channels with metadata containing an item with the
  /// key specified by the metaDataKey and the values of that item start with
  /// the specified value
  @JsonKey(name: 'metadata_value_startswith')
  String? metaDataValueStartWithFilter;

  Map<String, dynamic> toJson() {
    final json = _$GroupChannelFilterToJson(this);
    if (json['metadata_key'] == null) {
      json.remove('metadata_values');
      json.remove('metadata_value_startswith');
    }
    return json;
  }
}
