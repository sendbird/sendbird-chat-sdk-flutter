// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_group_channel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCGroupChannelCollection on Isar {
  IsarCollection<CGroupChannel> get cGroupChannels => this.collection();
}

final CGroupChannelSchema = CollectionSchema(
  name: r'CGroupChannel',
  id: BigInt.parse('-4229950044315142915').toInt(),
  properties: {
    r'channelType': PropertySchema(
      id: 0,
      name: r'channelType',
      type: IsarType.byte,
      enumMap: _CGroupChannelchannelTypeEnumValueMap,
    ),
    r'channelUrl': PropertySchema(
      id: 1,
      name: r'channelUrl',
      type: IsarType.string,
    ),
    r'coverUrl': PropertySchema(
      id: 2,
      name: r'coverUrl',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.long,
    ),
    r'creator': PropertySchema(
      id: 4,
      name: r'creator',
      type: IsarType.string,
    ),
    r'customType': PropertySchema(
      id: 5,
      name: r'customType',
      type: IsarType.string,
    ),
    r'data': PropertySchema(
      id: 6,
      name: r'data',
      type: IsarType.string,
    ),
    r'dirty': PropertySchema(
      id: 7,
      name: r'dirty',
      type: IsarType.bool,
    ),
    r'fromCache': PropertySchema(
      id: 8,
      name: r'fromCache',
      type: IsarType.bool,
    ),
    r'hiddenState': PropertySchema(
      id: 9,
      name: r'hiddenState',
      type: IsarType.byte,
      enumMap: _CGroupChannelhiddenStateEnumValueMap,
    ),
    r'invitedAt': PropertySchema(
      id: 10,
      name: r'invitedAt',
      type: IsarType.long,
    ),
    r'inviter': PropertySchema(
      id: 11,
      name: r'inviter',
      type: IsarType.object,
      target: r'CMember',
    ),
    r'isAccessCodeRequired': PropertySchema(
      id: 12,
      name: r'isAccessCodeRequired',
      type: IsarType.bool,
    ),
    r'isBroadcast': PropertySchema(
      id: 13,
      name: r'isBroadcast',
      type: IsarType.bool,
    ),
    r'isChatNotification': PropertySchema(
      id: 14,
      name: r'isChatNotification',
      type: IsarType.bool,
    ),
    r'isDiscoverable': PropertySchema(
      id: 15,
      name: r'isDiscoverable',
      type: IsarType.bool,
    ),
    r'isDistinct': PropertySchema(
      id: 16,
      name: r'isDistinct',
      type: IsarType.bool,
    ),
    r'isEphemeral': PropertySchema(
      id: 17,
      name: r'isEphemeral',
      type: IsarType.bool,
    ),
    r'isExclusive': PropertySchema(
      id: 18,
      name: r'isExclusive',
      type: IsarType.bool,
    ),
    r'isFrozen': PropertySchema(
      id: 19,
      name: r'isFrozen',
      type: IsarType.bool,
    ),
    r'isHidden': PropertySchema(
      id: 20,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'isPublic': PropertySchema(
      id: 21,
      name: r'isPublic',
      type: IsarType.bool,
    ),
    r'isSuper': PropertySchema(
      id: 22,
      name: r'isSuper',
      type: IsarType.bool,
    ),
    r'joinedAt': PropertySchema(
      id: 23,
      name: r'joinedAt',
      type: IsarType.long,
    ),
    r'joinedMemberCount': PropertySchema(
      id: 24,
      name: r'joinedMemberCount',
      type: IsarType.long,
    ),
    r'lastMessageCreatedAt': PropertySchema(
      id: 25,
      name: r'lastMessageCreatedAt',
      type: IsarType.long,
    ),
    r'lastMessageRootId': PropertySchema(
      id: 26,
      name: r'lastMessageRootId',
      type: IsarType.string,
    ),
    r'lastMessageType': PropertySchema(
      id: 27,
      name: r'lastMessageType',
      type: IsarType.byte,
      enumMap: _CGroupChannellastMessageTypeEnumValueMap,
    ),
    r'lastPinnedMessageRootId': PropertySchema(
      id: 28,
      name: r'lastPinnedMessageRootId',
      type: IsarType.string,
    ),
    r'lastPinnedMessageType': PropertySchema(
      id: 29,
      name: r'lastPinnedMessageType',
      type: IsarType.byte,
      enumMap: _CGroupChannellastPinnedMessageTypeEnumValueMap,
    ),
    r'memberCount': PropertySchema(
      id: 30,
      name: r'memberCount',
      type: IsarType.long,
    ),
    r'members': PropertySchema(
      id: 31,
      name: r'members',
      type: IsarType.objectList,
      target: r'CMember',
    ),
    r'messageOffsetTimestamp': PropertySchema(
      id: 32,
      name: r'messageOffsetTimestamp',
      type: IsarType.long,
    ),
    r'messageSurvivalSeconds': PropertySchema(
      id: 33,
      name: r'messageSurvivalSeconds',
      type: IsarType.long,
    ),
    r'myCountPreference': PropertySchema(
      id: 34,
      name: r'myCountPreference',
      type: IsarType.byte,
      enumMap: _CGroupChannelmyCountPreferenceEnumValueMap,
    ),
    r'myLastRead': PropertySchema(
      id: 35,
      name: r'myLastRead',
      type: IsarType.long,
    ),
    r'myMemberState': PropertySchema(
      id: 36,
      name: r'myMemberState',
      type: IsarType.byte,
      enumMap: _CGroupChannelmyMemberStateEnumValueMap,
    ),
    r'myMutedState': PropertySchema(
      id: 37,
      name: r'myMutedState',
      type: IsarType.byte,
      enumMap: _CGroupChannelmyMutedStateEnumValueMap,
    ),
    r'myPushTriggerOption': PropertySchema(
      id: 38,
      name: r'myPushTriggerOption',
      type: IsarType.byte,
      enumMap: _CGroupChannelmyPushTriggerOptionEnumValueMap,
    ),
    r'myRole': PropertySchema(
      id: 39,
      name: r'myRole',
      type: IsarType.byte,
      enumMap: _CGroupChannelmyRoleEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 40,
      name: r'name',
      type: IsarType.string,
    ),
    r'pinnedMessageIds': PropertySchema(
      id: 41,
      name: r'pinnedMessageIds',
      type: IsarType.longList,
    ),
    r'pinnedMessageUpdatedAt': PropertySchema(
      id: 42,
      name: r'pinnedMessageUpdatedAt',
      type: IsarType.long,
    ),
    r'unreadMentionCount': PropertySchema(
      id: 43,
      name: r'unreadMentionCount',
      type: IsarType.long,
    ),
    r'unreadMessageCount': PropertySchema(
      id: 44,
      name: r'unreadMessageCount',
      type: IsarType.long,
    )
  },
  estimateSize: _cGroupChannelEstimateSize,
  serialize: _cGroupChannelSerialize,
  deserialize: _cGroupChannelDeserialize,
  deserializeProp: _cGroupChannelDeserializeProp,
  idName: r'id',
  indexes: {
    r'channelUrl': IndexSchema(
      id: BigInt.parse('6636052684858767397').toInt(),
      name: r'channelUrl',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'channelUrl',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'channelType_channelUrl': IndexSchema(
      id: BigInt.parse('-5957547153902522682').toInt(),
      name: r'channelType_channelUrl',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'channelType',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'channelUrl',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'CMember': CMemberSchema,
    r'CRestrictionInfo': CRestrictionInfoSchema
  },
  getId: _cGroupChannelGetId,
  getLinks: _cGroupChannelGetLinks,
  attach: _cGroupChannelAttach,
  version: '3.1.0+1',
);

int _cGroupChannelEstimateSize(
  CGroupChannel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.channelUrl.length * 3;
  {
    final value = object.coverUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.creator;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.data;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.inviter;
    if (value != null) {
      bytesCount += 3 +
          CMemberSchema.estimateSize(value, allOffsets[CMember]!, allOffsets);
    }
  }
  {
    final value = object.lastMessageRootId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastPinnedMessageRootId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.members.length * 3;
  {
    final offsets = allOffsets[CMember]!;
    for (var i = 0; i < object.members.length; i++) {
      final value = object.members[i];
      bytesCount += CMemberSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pinnedMessageIds.length * 8;
  return bytesCount;
}

void _cGroupChannelSerialize(
  CGroupChannel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.channelType.index);
  writer.writeString(offsets[1], object.channelUrl);
  writer.writeString(offsets[2], object.coverUrl);
  writer.writeLong(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.creator);
  writer.writeString(offsets[5], object.customType);
  writer.writeString(offsets[6], object.data);
  writer.writeBool(offsets[7], object.dirty);
  writer.writeBool(offsets[8], object.fromCache);
  writer.writeByte(offsets[9], object.hiddenState.index);
  writer.writeLong(offsets[10], object.invitedAt);
  writer.writeObject<CMember>(
    offsets[11],
    allOffsets,
    CMemberSchema.serialize,
    object.inviter,
  );
  writer.writeBool(offsets[12], object.isAccessCodeRequired);
  writer.writeBool(offsets[13], object.isBroadcast);
  writer.writeBool(offsets[14], object.isChatNotification);
  writer.writeBool(offsets[15], object.isDiscoverable);
  writer.writeBool(offsets[16], object.isDistinct);
  writer.writeBool(offsets[17], object.isEphemeral);
  writer.writeBool(offsets[18], object.isExclusive);
  writer.writeBool(offsets[19], object.isFrozen);
  writer.writeBool(offsets[20], object.isHidden);
  writer.writeBool(offsets[21], object.isPublic);
  writer.writeBool(offsets[22], object.isSuper);
  writer.writeLong(offsets[23], object.joinedAt);
  writer.writeLong(offsets[24], object.joinedMemberCount);
  writer.writeLong(offsets[25], object.lastMessageCreatedAt);
  writer.writeString(offsets[26], object.lastMessageRootId);
  writer.writeByte(offsets[27], object.lastMessageType.index);
  writer.writeString(offsets[28], object.lastPinnedMessageRootId);
  writer.writeByte(offsets[29], object.lastPinnedMessageType.index);
  writer.writeLong(offsets[30], object.memberCount);
  writer.writeObjectList<CMember>(
    offsets[31],
    allOffsets,
    CMemberSchema.serialize,
    object.members,
  );
  writer.writeLong(offsets[32], object.messageOffsetTimestamp);
  writer.writeLong(offsets[33], object.messageSurvivalSeconds);
  writer.writeByte(offsets[34], object.myCountPreference.index);
  writer.writeLong(offsets[35], object.myLastRead);
  writer.writeByte(offsets[36], object.myMemberState.index);
  writer.writeByte(offsets[37], object.myMutedState.index);
  writer.writeByte(offsets[38], object.myPushTriggerOption.index);
  writer.writeByte(offsets[39], object.myRole.index);
  writer.writeString(offsets[40], object.name);
  writer.writeLongList(offsets[41], object.pinnedMessageIds);
  writer.writeLong(offsets[42], object.pinnedMessageUpdatedAt);
  writer.writeLong(offsets[43], object.unreadMentionCount);
  writer.writeLong(offsets[44], object.unreadMessageCount);
}

CGroupChannel _cGroupChannelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CGroupChannel();
  object.channelType = _CGroupChannelchannelTypeValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      ChannelType.group;
  object.channelUrl = reader.readString(offsets[1]);
  object.coverUrl = reader.readStringOrNull(offsets[2]);
  object.createdAt = reader.readLongOrNull(offsets[3]);
  object.creator = reader.readStringOrNull(offsets[4]);
  object.customType = reader.readStringOrNull(offsets[5]);
  object.data = reader.readStringOrNull(offsets[6]);
  object.dirty = reader.readBool(offsets[7]);
  object.fromCache = reader.readBool(offsets[8]);
  object.hiddenState = _CGroupChannelhiddenStateValueEnumMap[
          reader.readByteOrNull(offsets[9])] ??
      GroupChannelHiddenState.unhidden;
  object.id = id;
  object.invitedAt = reader.readLong(offsets[10]);
  object.inviter = reader.readObjectOrNull<CMember>(
    offsets[11],
    CMemberSchema.deserialize,
    allOffsets,
  );
  object.isAccessCodeRequired = reader.readBool(offsets[12]);
  object.isBroadcast = reader.readBool(offsets[13]);
  object.isChatNotification = reader.readBool(offsets[14]);
  object.isDiscoverable = reader.readBool(offsets[15]);
  object.isDistinct = reader.readBool(offsets[16]);
  object.isEphemeral = reader.readBoolOrNull(offsets[17]);
  object.isExclusive = reader.readBool(offsets[18]);
  object.isFrozen = reader.readBoolOrNull(offsets[19]);
  object.isHidden = reader.readBool(offsets[20]);
  object.isPublic = reader.readBool(offsets[21]);
  object.isSuper = reader.readBool(offsets[22]);
  object.joinedAt = reader.readLong(offsets[23]);
  object.joinedMemberCount = reader.readLong(offsets[24]);
  object.lastMessageCreatedAt = reader.readLongOrNull(offsets[25]);
  object.lastMessageRootId = reader.readStringOrNull(offsets[26]);
  object.lastMessageType = _CGroupChannellastMessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[27])] ??
      MessageType.user;
  object.lastPinnedMessageRootId = reader.readStringOrNull(offsets[28]);
  object.lastPinnedMessageType =
      _CGroupChannellastPinnedMessageTypeValueEnumMap[
              reader.readByteOrNull(offsets[29])] ??
          MessageType.user;
  object.memberCount = reader.readLong(offsets[30]);
  object.members = reader.readObjectList<CMember>(
        offsets[31],
        CMemberSchema.deserialize,
        allOffsets,
        CMember(),
      ) ??
      [];
  object.messageOffsetTimestamp = reader.readLongOrNull(offsets[32]);
  object.messageSurvivalSeconds = reader.readLong(offsets[33]);
  object.myCountPreference = _CGroupChannelmyCountPreferenceValueEnumMap[
          reader.readByteOrNull(offsets[34])] ??
      CountPreference.all;
  object.myLastRead = reader.readLong(offsets[35]);
  object.myMemberState = _CGroupChannelmyMemberStateValueEnumMap[
          reader.readByteOrNull(offsets[36])] ??
      MemberState.none;
  object.myMutedState = _CGroupChannelmyMutedStateValueEnumMap[
          reader.readByteOrNull(offsets[37])] ??
      MuteState.unmuted;
  object.myPushTriggerOption = _CGroupChannelmyPushTriggerOptionValueEnumMap[
          reader.readByteOrNull(offsets[38])] ??
      GroupChannelPushTriggerOption.defaultValue;
  object.myRole =
      _CGroupChannelmyRoleValueEnumMap[reader.readByteOrNull(offsets[39])] ??
          Role.none;
  object.name = reader.readString(offsets[40]);
  object.pinnedMessageIds = reader.readLongList(offsets[41]) ?? [];
  object.pinnedMessageUpdatedAt = reader.readLong(offsets[42]);
  object.unreadMentionCount = reader.readLong(offsets[43]);
  object.unreadMessageCount = reader.readLong(offsets[44]);
  return object;
}

P _cGroupChannelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CGroupChannelchannelTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ChannelType.group) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (_CGroupChannelhiddenStateValueEnumMap[
              reader.readByteOrNull(offset)] ??
          GroupChannelHiddenState.unhidden) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readObjectOrNull<CMember>(
        offset,
        CMemberSchema.deserialize,
        allOffsets,
      )) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readBoolOrNull(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readBoolOrNull(offset)) as P;
    case 20:
      return (reader.readBool(offset)) as P;
    case 21:
      return (reader.readBool(offset)) as P;
    case 22:
      return (reader.readBool(offset)) as P;
    case 23:
      return (reader.readLong(offset)) as P;
    case 24:
      return (reader.readLong(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (_CGroupChannellastMessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    case 29:
      return (_CGroupChannellastPinnedMessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 30:
      return (reader.readLong(offset)) as P;
    case 31:
      return (reader.readObjectList<CMember>(
            offset,
            CMemberSchema.deserialize,
            allOffsets,
            CMember(),
          ) ??
          []) as P;
    case 32:
      return (reader.readLongOrNull(offset)) as P;
    case 33:
      return (reader.readLong(offset)) as P;
    case 34:
      return (_CGroupChannelmyCountPreferenceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          CountPreference.all) as P;
    case 35:
      return (reader.readLong(offset)) as P;
    case 36:
      return (_CGroupChannelmyMemberStateValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MemberState.none) as P;
    case 37:
      return (_CGroupChannelmyMutedStateValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MuteState.unmuted) as P;
    case 38:
      return (_CGroupChannelmyPushTriggerOptionValueEnumMap[
              reader.readByteOrNull(offset)] ??
          GroupChannelPushTriggerOption.defaultValue) as P;
    case 39:
      return (_CGroupChannelmyRoleValueEnumMap[reader.readByteOrNull(offset)] ??
          Role.none) as P;
    case 40:
      return (reader.readString(offset)) as P;
    case 41:
      return (reader.readLongList(offset) ?? []) as P;
    case 42:
      return (reader.readLong(offset)) as P;
    case 43:
      return (reader.readLong(offset)) as P;
    case 44:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CGroupChannelchannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CGroupChannelchannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};
const _CGroupChannelhiddenStateEnumValueMap = {
  'unhidden': 0,
  'allowAutoUnhide': 1,
  'preventAutoUnhide': 2,
};
const _CGroupChannelhiddenStateValueEnumMap = {
  0: GroupChannelHiddenState.unhidden,
  1: GroupChannelHiddenState.allowAutoUnhide,
  2: GroupChannelHiddenState.preventAutoUnhide,
};
const _CGroupChannellastMessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CGroupChannellastMessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CGroupChannellastPinnedMessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CGroupChannellastPinnedMessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CGroupChannelmyCountPreferenceEnumValueMap = {
  'all': 0,
  'unreadMessageCountOnly': 1,
  'unrealMentionCountOnly': 2,
  'off': 3,
};
const _CGroupChannelmyCountPreferenceValueEnumMap = {
  0: CountPreference.all,
  1: CountPreference.unreadMessageCountOnly,
  2: CountPreference.unrealMentionCountOnly,
  3: CountPreference.off,
};
const _CGroupChannelmyMemberStateEnumValueMap = {
  'none': 0,
  'invited': 1,
  'joined': 2,
};
const _CGroupChannelmyMemberStateValueEnumMap = {
  0: MemberState.none,
  1: MemberState.invited,
  2: MemberState.joined,
};
const _CGroupChannelmyMutedStateEnumValueMap = {
  'unmuted': 0,
  'muted': 1,
};
const _CGroupChannelmyMutedStateValueEnumMap = {
  0: MuteState.unmuted,
  1: MuteState.muted,
};
const _CGroupChannelmyPushTriggerOptionEnumValueMap = {
  'defaultValue': 0,
  'all': 1,
  'off': 2,
  'mentionOnly': 3,
};
const _CGroupChannelmyPushTriggerOptionValueEnumMap = {
  0: GroupChannelPushTriggerOption.defaultValue,
  1: GroupChannelPushTriggerOption.all,
  2: GroupChannelPushTriggerOption.off,
  3: GroupChannelPushTriggerOption.mentionOnly,
};
const _CGroupChannelmyRoleEnumValueMap = {
  'none': 0,
  'operator': 1,
};
const _CGroupChannelmyRoleValueEnumMap = {
  0: Role.none,
  1: Role.operator,
};

Id _cGroupChannelGetId(CGroupChannel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cGroupChannelGetLinks(CGroupChannel object) {
  return [];
}

void _cGroupChannelAttach(
    IsarCollection<dynamic> col, Id id, CGroupChannel object) {
  object.id = id;
}

extension CGroupChannelByIndex on IsarCollection<CGroupChannel> {
  Future<CGroupChannel?> getByChannelUrl(String channelUrl) {
    return getByIndex(r'channelUrl', [channelUrl]);
  }

  CGroupChannel? getByChannelUrlSync(String channelUrl) {
    return getByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<bool> deleteByChannelUrl(String channelUrl) {
    return deleteByIndex(r'channelUrl', [channelUrl]);
  }

  bool deleteByChannelUrlSync(String channelUrl) {
    return deleteByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<List<CGroupChannel?>> getAllByChannelUrl(
      List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return getAllByIndex(r'channelUrl', values);
  }

  List<CGroupChannel?> getAllByChannelUrlSync(List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'channelUrl', values);
  }

  Future<int> deleteAllByChannelUrl(List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'channelUrl', values);
  }

  int deleteAllByChannelUrlSync(List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'channelUrl', values);
  }

  Future<Id> putByChannelUrl(CGroupChannel object) {
    return putByIndex(r'channelUrl', object);
  }

  Id putByChannelUrlSync(CGroupChannel object, {bool saveLinks = true}) {
    return putByIndexSync(r'channelUrl', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByChannelUrl(List<CGroupChannel> objects) {
    return putAllByIndex(r'channelUrl', objects);
  }

  List<Id> putAllByChannelUrlSync(List<CGroupChannel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'channelUrl', objects, saveLinks: saveLinks);
  }
}

extension CGroupChannelQueryWhereSort
    on QueryBuilder<CGroupChannel, CGroupChannel, QWhere> {
  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CGroupChannelQueryWhere
    on QueryBuilder<CGroupChannel, CGroupChannel, QWhereClause> {
  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelUrlNotEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelUrl',
              lower: [],
              upper: [channelUrl],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelUrl',
              lower: [channelUrl],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelUrl',
              lower: [channelUrl],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelUrl',
              lower: [],
              upper: [channelUrl],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelTypeNotEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [],
              upper: [channelType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [channelType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [channelType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [],
              upper: [channelType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelTypeGreaterThanAnyChannelUrl(
    ChannelType channelType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelType_channelUrl',
        lower: [channelType],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelTypeLessThanAnyChannelUrl(
    ChannelType channelType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelType_channelUrl',
        lower: [],
        upper: [channelType],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelTypeBetweenAnyChannelUrl(
    ChannelType lowerChannelType,
    ChannelType upperChannelType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelType_channelUrl',
        lower: [lowerChannelType],
        includeLower: includeLower,
        upper: [upperChannelType],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterWhereClause>
      channelTypeEqualToChannelUrlNotEqualTo(
          ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [channelType],
              upper: [channelType, channelUrl],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [channelType, channelUrl],
              includeLower: false,
              upper: [channelType],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [channelType, channelUrl],
              includeLower: false,
              upper: [channelType],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelType_channelUrl',
              lower: [channelType],
              upper: [channelType, channelUrl],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CGroupChannelQueryFilter
    on QueryBuilder<CGroupChannel, CGroupChannel, QFilterCondition> {
  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelTypeGreaterThan(
    ChannelType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelTypeLessThan(
    ChannelType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelTypeBetween(
    ChannelType lower,
    ChannelType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'channelType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'channelUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverUrl',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverUrl',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      coverUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      createdAtEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      createdAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      createdAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      createdAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creator',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creator',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creator',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      creatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creator',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> dataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> dataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'data',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> dataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'data',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      dirtyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dirty',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      fromCacheEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCache',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      hiddenStateEqualTo(GroupChannelHiddenState value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hiddenState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      hiddenStateGreaterThan(
    GroupChannelHiddenState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hiddenState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      hiddenStateLessThan(
    GroupChannelHiddenState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hiddenState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      hiddenStateBetween(
    GroupChannelHiddenState lower,
    GroupChannelHiddenState upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hiddenState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      invitedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invitedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      invitedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invitedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      invitedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invitedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      invitedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invitedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      inviterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inviter',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      inviterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inviter',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isAccessCodeRequiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAccessCodeRequired',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isBroadcastEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBroadcast',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isChatNotificationEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isChatNotification',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isDiscoverableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDiscoverable',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isDistinctEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDistinct',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isEphemeralIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isEphemeral',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isEphemeralIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isEphemeral',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isEphemeralEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEphemeral',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isExclusiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExclusive',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isFrozenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFrozen',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isFrozenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFrozen',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isFrozenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFrozen',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isHiddenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isPublicEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublic',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      isSuperEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSuper',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'joinedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'joinedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'joinedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedMemberCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinedMemberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedMemberCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'joinedMemberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedMemberCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'joinedMemberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      joinedMemberCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'joinedMemberCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageCreatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessageCreatedAt',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageCreatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessageCreatedAt',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageCreatedAtEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageCreatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageCreatedAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageCreatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageCreatedAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageCreatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageCreatedAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageCreatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessageRootId',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessageRootId',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageRootId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessageRootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageRootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageTypeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageTypeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastMessageTypeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPinnedMessageRootId',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPinnedMessageRootId',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPinnedMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPinnedMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPinnedMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPinnedMessageRootId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastPinnedMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastPinnedMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastPinnedMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastPinnedMessageRootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPinnedMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageRootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastPinnedMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPinnedMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageTypeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPinnedMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageTypeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPinnedMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      lastPinnedMessageTypeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPinnedMessageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      memberCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      memberCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      memberCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      memberCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      membersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'members',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      membersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'members',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      membersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'members',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      membersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'members',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      membersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'members',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      membersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'members',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageOffsetTimestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageOffsetTimestamp',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageOffsetTimestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageOffsetTimestamp',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageOffsetTimestampEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageOffsetTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageOffsetTimestampGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageOffsetTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageOffsetTimestampLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageOffsetTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageOffsetTimestampBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageOffsetTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageSurvivalSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageSurvivalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageSurvivalSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageSurvivalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageSurvivalSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageSurvivalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      messageSurvivalSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageSurvivalSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myCountPreferenceEqualTo(CountPreference value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'myCountPreference',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myCountPreferenceGreaterThan(
    CountPreference value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'myCountPreference',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myCountPreferenceLessThan(
    CountPreference value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'myCountPreference',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myCountPreferenceBetween(
    CountPreference lower,
    CountPreference upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'myCountPreference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myLastReadEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'myLastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myLastReadGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'myLastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myLastReadLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'myLastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myLastReadBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'myLastRead',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMemberStateEqualTo(MemberState value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'myMemberState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMemberStateGreaterThan(
    MemberState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'myMemberState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMemberStateLessThan(
    MemberState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'myMemberState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMemberStateBetween(
    MemberState lower,
    MemberState upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'myMemberState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMutedStateEqualTo(MuteState value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'myMutedState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMutedStateGreaterThan(
    MuteState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'myMutedState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMutedStateLessThan(
    MuteState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'myMutedState',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myMutedStateBetween(
    MuteState lower,
    MuteState upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'myMutedState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myPushTriggerOptionEqualTo(GroupChannelPushTriggerOption value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'myPushTriggerOption',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myPushTriggerOptionGreaterThan(
    GroupChannelPushTriggerOption value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'myPushTriggerOption',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myPushTriggerOptionLessThan(
    GroupChannelPushTriggerOption value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'myPushTriggerOption',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myPushTriggerOptionBetween(
    GroupChannelPushTriggerOption lower,
    GroupChannelPushTriggerOption upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'myPushTriggerOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myRoleEqualTo(Role value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'myRole',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myRoleGreaterThan(
    Role value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'myRole',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myRoleLessThan(
    Role value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'myRole',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      myRoleBetween(
    Role lower,
    Role upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'myRole',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pinnedMessageIds',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pinnedMessageIds',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pinnedMessageIds',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pinnedMessageIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pinnedMessageIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pinnedMessageIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pinnedMessageIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pinnedMessageIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pinnedMessageIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pinnedMessageIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageUpdatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pinnedMessageUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageUpdatedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pinnedMessageUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageUpdatedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pinnedMessageUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      pinnedMessageUpdatedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pinnedMessageUpdatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMentionCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unreadMentionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMentionCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unreadMentionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMentionCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unreadMentionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMentionCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unreadMentionCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMessageCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unreadMessageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMessageCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unreadMessageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMessageCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unreadMessageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      unreadMessageCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unreadMessageCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CGroupChannelQueryObject
    on QueryBuilder<CGroupChannel, CGroupChannel, QFilterCondition> {
  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition> inviter(
      FilterQuery<CMember> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'inviter');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterFilterCondition>
      membersElement(FilterQuery<CMember> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'members');
    });
  }
}

extension CGroupChannelQueryLinks
    on QueryBuilder<CGroupChannel, CGroupChannel, QFilterCondition> {}

extension CGroupChannelQuerySortBy
    on QueryBuilder<CGroupChannel, CGroupChannel, QSortBy> {
  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByCoverUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByCoverUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByFromCache() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByFromCacheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByHiddenState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenState', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByHiddenStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenState', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByInvitedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByInvitedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsAccessCodeRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccessCodeRequired', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsAccessCodeRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccessCodeRequired', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsBroadcast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcast', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsBroadcastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcast', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsChatNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChatNotification', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsChatNotificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChatNotification', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsDiscoverable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDiscoverable', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsDiscoverableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDiscoverable', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsDistinct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDistinct', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsDistinctDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDistinct', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsEphemeral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsEphemeralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsExclusive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExclusive', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsExclusiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExclusive', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsFrozen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsFrozenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsSuper() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuper', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByIsSuperDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuper', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByJoinedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByJoinedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByJoinedMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedMemberCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByJoinedMemberCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedMemberCount', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastMessageCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageCreatedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastMessageCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageCreatedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastPinnedMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastPinnedMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastPinnedMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByLastPinnedMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMemberCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMessageOffsetTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageOffsetTimestamp', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMessageOffsetTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageOffsetTimestamp', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyCountPreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myCountPreference', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyCountPreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myCountPreference', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByMyLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myLastRead', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myLastRead', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyMemberState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMemberState', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyMemberStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMemberState', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyMutedState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMutedState', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyMutedStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMutedState', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyPushTriggerOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myPushTriggerOption', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByMyPushTriggerOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myPushTriggerOption', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByMyRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myRole', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByMyRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myRole', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByPinnedMessageUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedMessageUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByPinnedMessageUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedMessageUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByUnreadMentionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMentionCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByUnreadMentionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMentionCount', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByUnreadMessageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMessageCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      sortByUnreadMessageCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMessageCount', Sort.desc);
    });
  }
}

extension CGroupChannelQuerySortThenBy
    on QueryBuilder<CGroupChannel, CGroupChannel, QSortThenBy> {
  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByCoverUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByCoverUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByFromCache() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByFromCacheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByHiddenState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenState', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByHiddenStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiddenState', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByInvitedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByInvitedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invitedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsAccessCodeRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccessCodeRequired', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsAccessCodeRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccessCodeRequired', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsBroadcast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcast', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsBroadcastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBroadcast', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsChatNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChatNotification', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsChatNotificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChatNotification', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsDiscoverable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDiscoverable', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsDiscoverableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDiscoverable', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsDistinct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDistinct', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsDistinctDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDistinct', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsEphemeral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsEphemeralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsExclusive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExclusive', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsExclusiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExclusive', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsFrozen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsFrozenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsSuper() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuper', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByIsSuperDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSuper', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByJoinedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByJoinedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByJoinedMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedMemberCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByJoinedMemberCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedMemberCount', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastMessageCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageCreatedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastMessageCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageCreatedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastPinnedMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastPinnedMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastPinnedMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageType', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByLastPinnedMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPinnedMessageType', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMemberCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberCount', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMessageOffsetTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageOffsetTimestamp', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMessageOffsetTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageOffsetTimestamp', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyCountPreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myCountPreference', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyCountPreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myCountPreference', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByMyLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myLastRead', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myLastRead', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyMemberState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMemberState', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyMemberStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMemberState', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyMutedState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMutedState', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyMutedStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myMutedState', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyPushTriggerOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myPushTriggerOption', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByMyPushTriggerOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myPushTriggerOption', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByMyRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myRole', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByMyRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'myRole', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByPinnedMessageUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedMessageUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByPinnedMessageUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pinnedMessageUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByUnreadMentionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMentionCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByUnreadMentionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMentionCount', Sort.desc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByUnreadMessageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMessageCount', Sort.asc);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QAfterSortBy>
      thenByUnreadMessageCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadMessageCount', Sort.desc);
    });
  }
}

extension CGroupChannelQueryWhereDistinct
    on QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> {
  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByChannelUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByCoverUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByCustomType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dirty');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByFromCache() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromCache');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByHiddenState() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hiddenState');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByInvitedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invitedAt');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByIsAccessCodeRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAccessCodeRequired');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByIsBroadcast() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBroadcast');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByIsChatNotification() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isChatNotification');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByIsDiscoverable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDiscoverable');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByIsDistinct() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDistinct');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByIsEphemeral() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEphemeral');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByIsExclusive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExclusive');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByIsFrozen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFrozen');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHidden');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublic');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByIsSuper() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSuper');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByJoinedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'joinedAt');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByJoinedMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'joinedMemberCount');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByLastMessageCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageCreatedAt');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByLastMessageRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageRootId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByLastMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageType');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByLastPinnedMessageRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPinnedMessageRootId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByLastPinnedMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPinnedMessageType');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByMemberCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberCount');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByMessageOffsetTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageOffsetTimestamp');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByMyCountPreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'myCountPreference');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByMyLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'myLastRead');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByMyMemberState() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'myMemberState');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByMyMutedState() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'myMutedState');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByMyPushTriggerOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'myPushTriggerOption');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByMyRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'myRole');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByPinnedMessageIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pinnedMessageIds');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByPinnedMessageUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pinnedMessageUpdatedAt');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByUnreadMentionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unreadMentionCount');
    });
  }

  QueryBuilder<CGroupChannel, CGroupChannel, QDistinct>
      distinctByUnreadMessageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unreadMessageCount');
    });
  }
}

extension CGroupChannelQueryProperty
    on QueryBuilder<CGroupChannel, CGroupChannel, QQueryProperty> {
  QueryBuilder<CGroupChannel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CGroupChannel, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CGroupChannel, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CGroupChannel, String?, QQueryOperations> coverUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverUrl');
    });
  }

  QueryBuilder<CGroupChannel, int?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CGroupChannel, String?, QQueryOperations> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creator');
    });
  }

  QueryBuilder<CGroupChannel, String?, QQueryOperations> customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CGroupChannel, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dirty');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> fromCacheProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromCache');
    });
  }

  QueryBuilder<CGroupChannel, GroupChannelHiddenState, QQueryOperations>
      hiddenStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hiddenState');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations> invitedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invitedAt');
    });
  }

  QueryBuilder<CGroupChannel, CMember?, QQueryOperations> inviterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inviter');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations>
      isAccessCodeRequiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAccessCodeRequired');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> isBroadcastProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBroadcast');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations>
      isChatNotificationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isChatNotification');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> isDiscoverableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDiscoverable');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> isDistinctProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDistinct');
    });
  }

  QueryBuilder<CGroupChannel, bool?, QQueryOperations> isEphemeralProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEphemeral');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> isExclusiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExclusive');
    });
  }

  QueryBuilder<CGroupChannel, bool?, QQueryOperations> isFrozenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFrozen');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> isHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHidden');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> isPublicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublic');
    });
  }

  QueryBuilder<CGroupChannel, bool, QQueryOperations> isSuperProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSuper');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations> joinedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'joinedAt');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations>
      joinedMemberCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'joinedMemberCount');
    });
  }

  QueryBuilder<CGroupChannel, int?, QQueryOperations>
      lastMessageCreatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageCreatedAt');
    });
  }

  QueryBuilder<CGroupChannel, String?, QQueryOperations>
      lastMessageRootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageRootId');
    });
  }

  QueryBuilder<CGroupChannel, MessageType, QQueryOperations>
      lastMessageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageType');
    });
  }

  QueryBuilder<CGroupChannel, String?, QQueryOperations>
      lastPinnedMessageRootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPinnedMessageRootId');
    });
  }

  QueryBuilder<CGroupChannel, MessageType, QQueryOperations>
      lastPinnedMessageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPinnedMessageType');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations> memberCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberCount');
    });
  }

  QueryBuilder<CGroupChannel, List<CMember>, QQueryOperations>
      membersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'members');
    });
  }

  QueryBuilder<CGroupChannel, int?, QQueryOperations>
      messageOffsetTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageOffsetTimestamp');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations>
      messageSurvivalSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CGroupChannel, CountPreference, QQueryOperations>
      myCountPreferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'myCountPreference');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations> myLastReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'myLastRead');
    });
  }

  QueryBuilder<CGroupChannel, MemberState, QQueryOperations>
      myMemberStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'myMemberState');
    });
  }

  QueryBuilder<CGroupChannel, MuteState, QQueryOperations>
      myMutedStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'myMutedState');
    });
  }

  QueryBuilder<CGroupChannel, GroupChannelPushTriggerOption, QQueryOperations>
      myPushTriggerOptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'myPushTriggerOption');
    });
  }

  QueryBuilder<CGroupChannel, Role, QQueryOperations> myRoleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'myRole');
    });
  }

  QueryBuilder<CGroupChannel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CGroupChannel, List<int>, QQueryOperations>
      pinnedMessageIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pinnedMessageIds');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations>
      pinnedMessageUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pinnedMessageUpdatedAt');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations>
      unreadMentionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unreadMentionCount');
    });
  }

  QueryBuilder<CGroupChannel, int, QQueryOperations>
      unreadMessageCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unreadMessageCount');
    });
  }
}
