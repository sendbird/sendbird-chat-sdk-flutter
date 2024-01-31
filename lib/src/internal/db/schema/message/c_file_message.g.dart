// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_file_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCFileMessageCollection on Isar {
  IsarCollection<CFileMessage> get cFileMessages => this.collection();
}

final CFileMessageSchema = CollectionSchema(
  name: r'CFileMessage',
  id: BigInt.parse('5183317174548444251').toInt(),
  properties: {
    r'allMetaArrays': PropertySchema(
      id: 0,
      name: r'allMetaArrays',
      type: IsarType.objectList,
      target: r'CMessageMetaArray',
    ),
    r'channelType': PropertySchema(
      id: 1,
      name: r'channelType',
      type: IsarType.byte,
      enumMap: _CFileMessagechannelTypeEnumValueMap,
    ),
    r'channelUrl': PropertySchema(
      id: 2,
      name: r'channelUrl',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.long,
    ),
    r'customType': PropertySchema(
      id: 4,
      name: r'customType',
      type: IsarType.string,
    ),
    r'data': PropertySchema(
      id: 5,
      name: r'data',
      type: IsarType.string,
    ),
    r'errorCode': PropertySchema(
      id: 6,
      name: r'errorCode',
      type: IsarType.long,
    ),
    r'extendedMessage': PropertySchema(
      id: 7,
      name: r'extendedMessage',
      type: IsarType.string,
    ),
    r'isOperatorMessage': PropertySchema(
      id: 8,
      name: r'isOperatorMessage',
      type: IsarType.bool,
    ),
    r'isReplyToChannel': PropertySchema(
      id: 9,
      name: r'isReplyToChannel',
      type: IsarType.bool,
    ),
    r'isSilent': PropertySchema(
      id: 10,
      name: r'isSilent',
      type: IsarType.bool,
    ),
    r'mentionType': PropertySchema(
      id: 11,
      name: r'mentionType',
      type: IsarType.byte,
      enumMap: _CFileMessagementionTypeEnumValueMap,
    ),
    r'mentionedUsers': PropertySchema(
      id: 12,
      name: r'mentionedUsers',
      type: IsarType.stringList,
    ),
    r'message': PropertySchema(
      id: 13,
      name: r'message',
      type: IsarType.string,
    ),
    r'messageCreateParams': PropertySchema(
      id: 14,
      name: r'messageCreateParams',
      type: IsarType.object,
      target: r'CFileMessageCreateParams',
    ),
    r'messageId': PropertySchema(
      id: 15,
      name: r'messageId',
      type: IsarType.long,
    ),
    r'messageSurvivalSeconds': PropertySchema(
      id: 16,
      name: r'messageSurvivalSeconds',
      type: IsarType.long,
    ),
    r'messageType': PropertySchema(
      id: 17,
      name: r'messageType',
      type: IsarType.byte,
      enumMap: _CFileMessagemessageTypeEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 18,
      name: r'name',
      type: IsarType.string,
    ),
    r'ogMetaData': PropertySchema(
      id: 19,
      name: r'ogMetaData',
      type: IsarType.object,
      target: r'COGMetaData',
    ),
    r'parentMessageId': PropertySchema(
      id: 20,
      name: r'parentMessageId',
      type: IsarType.long,
    ),
    r'parentMessageRootId': PropertySchema(
      id: 21,
      name: r'parentMessageRootId',
      type: IsarType.string,
    ),
    r'parentMessageType': PropertySchema(
      id: 22,
      name: r'parentMessageType',
      type: IsarType.byte,
      enumMap: _CFileMessageparentMessageTypeEnumValueMap,
    ),
    r'reactions': PropertySchema(
      id: 23,
      name: r'reactions',
      type: IsarType.objectList,
      target: r'CReaction',
    ),
    r'requestId': PropertySchema(
      id: 24,
      name: r'requestId',
      type: IsarType.string,
    ),
    r'requireAuth': PropertySchema(
      id: 25,
      name: r'requireAuth',
      type: IsarType.bool,
    ),
    r'rootId': PropertySchema(
      id: 26,
      name: r'rootId',
      type: IsarType.string,
    ),
    r'scheduledInfo': PropertySchema(
      id: 27,
      name: r'scheduledInfo',
      type: IsarType.object,
      target: r'CScheduledInfo',
    ),
    r'sender': PropertySchema(
      id: 28,
      name: r'sender',
      type: IsarType.object,
      target: r'CSender',
    ),
    r'sendingStatus': PropertySchema(
      id: 29,
      name: r'sendingStatus',
      type: IsarType.byte,
      enumMap: _CFileMessagesendingStatusEnumValueMap,
    ),
    r'size': PropertySchema(
      id: 30,
      name: r'size',
      type: IsarType.long,
    ),
    r'threadInfo': PropertySchema(
      id: 31,
      name: r'threadInfo',
      type: IsarType.object,
      target: r'CThreadInfo',
    ),
    r'thumbnails': PropertySchema(
      id: 32,
      name: r'thumbnails',
      type: IsarType.objectList,
      target: r'CThumbnail',
    ),
    r'type': PropertySchema(
      id: 33,
      name: r'type',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 34,
      name: r'updatedAt',
      type: IsarType.long,
    ),
    r'url': PropertySchema(
      id: 35,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _cFileMessageEstimateSize,
  serialize: _cFileMessageSerialize,
  deserialize: _cFileMessageDeserialize,
  deserializeProp: _cFileMessageDeserializeProp,
  idName: r'id',
  indexes: {
    r'rootId': IndexSchema(
      id: BigInt.parse('5087693435549841488').toInt(),
      name: r'rootId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'rootId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'messageType_rootId': IndexSchema(
      id: BigInt.parse('-7060804333380842370').toInt(),
      name: r'messageType_rootId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'messageType',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'rootId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'channelUrl': IndexSchema(
      id: BigInt.parse('6636052684858767397').toInt(),
      name: r'channelUrl',
      unique: false,
      replace: false,
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
    r'CThumbnail': CThumbnailSchema,
    r'CFileMessageCreateParams': CFileMessageCreateParamsSchema,
    r'CMessageMetaArray': CMessageMetaArraySchema,
    r'CFileInfo': CFileInfoSchema,
    r'CSize': CSizeSchema,
    r'CThreadInfo': CThreadInfoSchema,
    r'COGMetaData': COGMetaDataSchema,
    r'COGImage': COGImageSchema,
    r'CReaction': CReactionSchema,
    r'CScheduledInfo': CScheduledInfoSchema,
    r'CSender': CSenderSchema
  },
  getId: _cFileMessageGetId,
  getLinks: _cFileMessageGetLinks,
  attach: _cFileMessageAttach,
  version: '3.1.0+1',
);

int _cFileMessageEstimateSize(
  CFileMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.allMetaArrays;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CMessageMetaArray]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CMessageMetaArraySchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.channelUrl.length * 3;
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
  bytesCount += 3 + object.extendedMessage.length * 3;
  bytesCount += 3 + object.mentionedUsers.length * 3;
  {
    for (var i = 0; i < object.mentionedUsers.length; i++) {
      final value = object.mentionedUsers[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.message.length * 3;
  {
    final value = object.messageCreateParams;
    if (value != null) {
      bytesCount += 3 +
          CFileMessageCreateParamsSchema.estimateSize(
              value, allOffsets[CFileMessageCreateParams]!, allOffsets);
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ogMetaData;
    if (value != null) {
      bytesCount += 3 +
          COGMetaDataSchema.estimateSize(
              value, allOffsets[COGMetaData]!, allOffsets);
    }
  }
  {
    final value = object.parentMessageRootId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.reactions;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CReaction]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CReactionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.requestId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.rootId.length * 3;
  {
    final value = object.scheduledInfo;
    if (value != null) {
      bytesCount += 3 +
          CScheduledInfoSchema.estimateSize(
              value, allOffsets[CScheduledInfo]!, allOffsets);
    }
  }
  {
    final value = object.sender;
    if (value != null) {
      bytesCount += 3 +
          CSenderSchema.estimateSize(value, allOffsets[CSender]!, allOffsets);
    }
  }
  {
    final value = object.threadInfo;
    if (value != null) {
      bytesCount += 3 +
          CThreadInfoSchema.estimateSize(
              value, allOffsets[CThreadInfo]!, allOffsets);
    }
  }
  {
    final list = object.thumbnails;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CThumbnail]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CThumbnailSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _cFileMessageSerialize(
  CFileMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<CMessageMetaArray>(
    offsets[0],
    allOffsets,
    CMessageMetaArraySchema.serialize,
    object.allMetaArrays,
  );
  writer.writeByte(offsets[1], object.channelType.index);
  writer.writeString(offsets[2], object.channelUrl);
  writer.writeLong(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.customType);
  writer.writeString(offsets[5], object.data);
  writer.writeLong(offsets[6], object.errorCode);
  writer.writeString(offsets[7], object.extendedMessage);
  writer.writeBool(offsets[8], object.isOperatorMessage);
  writer.writeBool(offsets[9], object.isReplyToChannel);
  writer.writeBool(offsets[10], object.isSilent);
  writer.writeByte(offsets[11], object.mentionType.index);
  writer.writeStringList(offsets[12], object.mentionedUsers);
  writer.writeString(offsets[13], object.message);
  writer.writeObject<CFileMessageCreateParams>(
    offsets[14],
    allOffsets,
    CFileMessageCreateParamsSchema.serialize,
    object.messageCreateParams,
  );
  writer.writeLong(offsets[15], object.messageId);
  writer.writeLong(offsets[16], object.messageSurvivalSeconds);
  writer.writeByte(offsets[17], object.messageType.index);
  writer.writeString(offsets[18], object.name);
  writer.writeObject<COGMetaData>(
    offsets[19],
    allOffsets,
    COGMetaDataSchema.serialize,
    object.ogMetaData,
  );
  writer.writeLong(offsets[20], object.parentMessageId);
  writer.writeString(offsets[21], object.parentMessageRootId);
  writer.writeByte(offsets[22], object.parentMessageType.index);
  writer.writeObjectList<CReaction>(
    offsets[23],
    allOffsets,
    CReactionSchema.serialize,
    object.reactions,
  );
  writer.writeString(offsets[24], object.requestId);
  writer.writeBool(offsets[25], object.requireAuth);
  writer.writeString(offsets[26], object.rootId);
  writer.writeObject<CScheduledInfo>(
    offsets[27],
    allOffsets,
    CScheduledInfoSchema.serialize,
    object.scheduledInfo,
  );
  writer.writeObject<CSender>(
    offsets[28],
    allOffsets,
    CSenderSchema.serialize,
    object.sender,
  );
  writer.writeByte(offsets[29], object.sendingStatus.index);
  writer.writeLong(offsets[30], object.size);
  writer.writeObject<CThreadInfo>(
    offsets[31],
    allOffsets,
    CThreadInfoSchema.serialize,
    object.threadInfo,
  );
  writer.writeObjectList<CThumbnail>(
    offsets[32],
    allOffsets,
    CThumbnailSchema.serialize,
    object.thumbnails,
  );
  writer.writeString(offsets[33], object.type);
  writer.writeLong(offsets[34], object.updatedAt);
  writer.writeString(offsets[35], object.url);
}

CFileMessage _cFileMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CFileMessage();
  object.allMetaArrays = reader.readObjectList<CMessageMetaArray>(
    offsets[0],
    CMessageMetaArraySchema.deserialize,
    allOffsets,
    CMessageMetaArray(),
  );
  object.channelType =
      _CFileMessagechannelTypeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
          ChannelType.group;
  object.channelUrl = reader.readString(offsets[2]);
  object.createdAt = reader.readLong(offsets[3]);
  object.customType = reader.readStringOrNull(offsets[4]);
  object.data = reader.readStringOrNull(offsets[5]);
  object.errorCode = reader.readLongOrNull(offsets[6]);
  object.extendedMessage = reader.readString(offsets[7]);
  object.id = id;
  object.isOperatorMessage = reader.readBool(offsets[8]);
  object.isReplyToChannel = reader.readBool(offsets[9]);
  object.isSilent = reader.readBool(offsets[10]);
  object.mentionType = _CFileMessagementionTypeValueEnumMap[
          reader.readByteOrNull(offsets[11])] ??
      MentionType.users;
  object.mentionedUsers = reader.readStringList(offsets[12]) ?? [];
  object.message = reader.readString(offsets[13]);
  object.messageCreateParams =
      reader.readObjectOrNull<CFileMessageCreateParams>(
    offsets[14],
    CFileMessageCreateParamsSchema.deserialize,
    allOffsets,
  );
  object.messageId = reader.readLong(offsets[15]);
  object.messageSurvivalSeconds = reader.readLongOrNull(offsets[16]);
  object.messageType = _CFileMessagemessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[17])] ??
      MessageType.user;
  object.name = reader.readStringOrNull(offsets[18]);
  object.ogMetaData = reader.readObjectOrNull<COGMetaData>(
    offsets[19],
    COGMetaDataSchema.deserialize,
    allOffsets,
  );
  object.parentMessageId = reader.readLongOrNull(offsets[20]);
  object.parentMessageRootId = reader.readStringOrNull(offsets[21]);
  object.parentMessageType = _CFileMessageparentMessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[22])] ??
      MessageType.user;
  object.reactions = reader.readObjectList<CReaction>(
    offsets[23],
    CReactionSchema.deserialize,
    allOffsets,
    CReaction(),
  );
  object.requestId = reader.readStringOrNull(offsets[24]);
  object.requireAuth = reader.readBool(offsets[25]);
  object.rootId = reader.readString(offsets[26]);
  object.scheduledInfo = reader.readObjectOrNull<CScheduledInfo>(
    offsets[27],
    CScheduledInfoSchema.deserialize,
    allOffsets,
  );
  object.sender = reader.readObjectOrNull<CSender>(
    offsets[28],
    CSenderSchema.deserialize,
    allOffsets,
  );
  object.sendingStatus = _CFileMessagesendingStatusValueEnumMap[
          reader.readByteOrNull(offsets[29])] ??
      SendingStatus.none;
  object.size = reader.readLongOrNull(offsets[30]);
  object.threadInfo = reader.readObjectOrNull<CThreadInfo>(
    offsets[31],
    CThreadInfoSchema.deserialize,
    allOffsets,
  );
  object.thumbnails = reader.readObjectList<CThumbnail>(
    offsets[32],
    CThumbnailSchema.deserialize,
    allOffsets,
    CThumbnail(),
  );
  object.type = reader.readStringOrNull(offsets[33]);
  object.updatedAt = reader.readLong(offsets[34]);
  object.url = reader.readString(offsets[35]);
  return object;
}

P _cFileMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<CMessageMetaArray>(
        offset,
        CMessageMetaArraySchema.deserialize,
        allOffsets,
        CMessageMetaArray(),
      )) as P;
    case 1:
      return (_CFileMessagechannelTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ChannelType.group) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (_CFileMessagementionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MentionType.users) as P;
    case 12:
      return (reader.readStringList(offset) ?? []) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readObjectOrNull<CFileMessageCreateParams>(
        offset,
        CFileMessageCreateParamsSchema.deserialize,
        allOffsets,
      )) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (_CFileMessagemessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readObjectOrNull<COGMetaData>(
        offset,
        COGMetaDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (_CFileMessageparentMessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 23:
      return (reader.readObjectList<CReaction>(
        offset,
        CReactionSchema.deserialize,
        allOffsets,
        CReaction(),
      )) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readBool(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readObjectOrNull<CScheduledInfo>(
        offset,
        CScheduledInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 28:
      return (reader.readObjectOrNull<CSender>(
        offset,
        CSenderSchema.deserialize,
        allOffsets,
      )) as P;
    case 29:
      return (_CFileMessagesendingStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SendingStatus.none) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    case 31:
      return (reader.readObjectOrNull<CThreadInfo>(
        offset,
        CThreadInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 32:
      return (reader.readObjectList<CThumbnail>(
        offset,
        CThumbnailSchema.deserialize,
        allOffsets,
        CThumbnail(),
      )) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readLong(offset)) as P;
    case 35:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CFileMessagechannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CFileMessagechannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};
const _CFileMessagementionTypeEnumValueMap = {
  'users': 0,
  'channel': 1,
};
const _CFileMessagementionTypeValueEnumMap = {
  0: MentionType.users,
  1: MentionType.channel,
};
const _CFileMessagemessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CFileMessagemessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CFileMessageparentMessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CFileMessageparentMessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CFileMessagesendingStatusEnumValueMap = {
  'none': 0,
  'pending': 1,
  'failed': 2,
  'succeeded': 3,
  'canceled': 4,
};
const _CFileMessagesendingStatusValueEnumMap = {
  0: SendingStatus.none,
  1: SendingStatus.pending,
  2: SendingStatus.failed,
  3: SendingStatus.succeeded,
  4: SendingStatus.canceled,
};

Id _cFileMessageGetId(CFileMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cFileMessageGetLinks(CFileMessage object) {
  return [];
}

void _cFileMessageAttach(
    IsarCollection<dynamic> col, Id id, CFileMessage object) {
  object.id = id;
}

extension CFileMessageByIndex on IsarCollection<CFileMessage> {
  Future<CFileMessage?> getByRootId(String rootId) {
    return getByIndex(r'rootId', [rootId]);
  }

  CFileMessage? getByRootIdSync(String rootId) {
    return getByIndexSync(r'rootId', [rootId]);
  }

  Future<bool> deleteByRootId(String rootId) {
    return deleteByIndex(r'rootId', [rootId]);
  }

  bool deleteByRootIdSync(String rootId) {
    return deleteByIndexSync(r'rootId', [rootId]);
  }

  Future<List<CFileMessage?>> getAllByRootId(List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'rootId', values);
  }

  List<CFileMessage?> getAllByRootIdSync(List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'rootId', values);
  }

  Future<int> deleteAllByRootId(List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'rootId', values);
  }

  int deleteAllByRootIdSync(List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'rootId', values);
  }

  Future<Id> putByRootId(CFileMessage object) {
    return putByIndex(r'rootId', object);
  }

  Id putByRootIdSync(CFileMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'rootId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRootId(List<CFileMessage> objects) {
    return putAllByIndex(r'rootId', objects);
  }

  List<Id> putAllByRootIdSync(List<CFileMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rootId', objects, saveLinks: saveLinks);
  }
}

extension CFileMessageQueryWhereSort
    on QueryBuilder<CFileMessage, CFileMessage, QWhere> {
  QueryBuilder<CFileMessage, CFileMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CFileMessageQueryWhere
    on QueryBuilder<CFileMessage, CFileMessage, QWhereClause> {
  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> idBetween(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> rootIdEqualTo(
      String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootId',
        value: [rootId],
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> rootIdNotEqualTo(
      String rootId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootId',
              lower: [],
              upper: [rootId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootId',
              lower: [rootId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootId',
              lower: [rootId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootId',
              lower: [],
              upper: [rootId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      messageTypeEqualToAnyRootId(MessageType messageType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType],
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      messageTypeNotEqualToAnyRootId(MessageType messageType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [],
              upper: [messageType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [messageType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [messageType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [],
              upper: [messageType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      messageTypeGreaterThanAnyRootId(
    MessageType messageType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageType_rootId',
        lower: [messageType],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      messageTypeLessThanAnyRootId(
    MessageType messageType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageType_rootId',
        lower: [],
        upper: [messageType],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      messageTypeBetweenAnyRootId(
    MessageType lowerMessageType,
    MessageType upperMessageType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'messageType_rootId',
        lower: [lowerMessageType],
        includeLower: includeLower,
        upper: [upperMessageType],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      messageTypeRootIdEqualTo(MessageType messageType, String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType, rootId],
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      messageTypeEqualToRootIdNotEqualTo(
          MessageType messageType, String rootId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [messageType],
              upper: [messageType, rootId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [messageType, rootId],
              includeLower: false,
              upper: [messageType],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [messageType, rootId],
              includeLower: false,
              upper: [messageType],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageType_rootId',
              lower: [messageType],
              upper: [messageType, rootId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause> channelUrlEqualTo(
      String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterWhereClause>
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

extension CFileMessageQueryFilter
    on QueryBuilder<CFileMessage, CFileMessage, QFilterCondition> {
  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allMetaArrays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allMetaArrays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allMetaArrays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allMetaArrays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allMetaArrays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allMetaArrays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      createdAtGreaterThan(
    int value, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      createdAtLessThan(
    int value, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      createdAtBetween(
    int lower,
    int upper, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> dataEqualTo(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> dataLessThan(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> dataBetween(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> dataEndsWith(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> dataContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> dataMatches(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      errorCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      errorCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      errorCodeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      errorCodeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'errorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      errorCodeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'errorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      errorCodeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'errorCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'extendedMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extendedMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      extendedMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      isOperatorMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOperatorMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      isReplyToChannelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReplyToChannel',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      isSilentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSilent',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionTypeEqualTo(MentionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionTypeGreaterThan(
    MentionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionTypeLessThan(
    MentionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionTypeBetween(
    MentionType lower,
    MentionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mentionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mentionedUsers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mentionedUsers',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUsers',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUsers',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUsers',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUsers',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUsers',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      mentionedUsersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUsers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageCreateParamsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageCreateParams',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageCreateParamsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageCreateParams',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageSurvivalSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageSurvivalSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageSurvivalSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageSurvivalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageSurvivalSecondsGreaterThan(
    int? value, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageSurvivalSecondsLessThan(
    int? value, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageSurvivalSecondsBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageTypeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageTypeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageTypeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> nameEqualTo(
    String? value, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> nameLessThan(
    String? value, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      ogMetaDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      ogMetaDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentMessageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentMessageRootId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentMessageRootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageRootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageTypeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageTypeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      parentMessageTypeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentMessageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reactions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reactions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reactions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reactions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reactions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reactions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requestId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requestId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requestIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      requireAuthEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireAuth',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> rootIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      rootIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      rootIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> rootIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rootId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      rootIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      rootIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      rootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> rootIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      rootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      rootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      scheduledInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      scheduledInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      senderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      senderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      sendingStatusEqualTo(SendingStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sendingStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      sendingStatusGreaterThan(
    SendingStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sendingStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      sendingStatusLessThan(
    SendingStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sendingStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      sendingStatusBetween(
    SendingStatus lower,
    SendingStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sendingStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> sizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      sizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> sizeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      sizeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> sizeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> sizeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      threadInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      threadInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnails',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnails',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnails',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      updatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      updatedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      updatedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      updatedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension CFileMessageQueryObject
    on QueryBuilder<CFileMessage, CFileMessage, QFilterCondition> {
  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      allMetaArraysElement(FilterQuery<CMessageMetaArray> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allMetaArrays');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      messageCreateParams(FilterQuery<CFileMessageCreateParams> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'messageCreateParams');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> ogMetaData(
      FilterQuery<COGMetaData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ogMetaData');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      reactionsElement(FilterQuery<CReaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reactions');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> scheduledInfo(
      FilterQuery<CScheduledInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'scheduledInfo');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> sender(
      FilterQuery<CSender> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sender');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition> threadInfo(
      FilterQuery<CThreadInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'threadInfo');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterFilterCondition>
      thumbnailsElement(FilterQuery<CThumbnail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnails');
    });
  }
}

extension CFileMessageQueryLinks
    on QueryBuilder<CFileMessage, CFileMessage, QFilterCondition> {}

extension CFileMessageQuerySortBy
    on QueryBuilder<CFileMessage, CFileMessage, QSortBy> {
  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortByRequireAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      sortBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension CFileMessageQuerySortThenBy
    on QueryBuilder<CFileMessage, CFileMessage, QSortThenBy> {
  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenByRequireAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy>
      thenBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension CFileMessageQueryWhereDistinct
    on QueryBuilder<CFileMessage, CFileMessage, QDistinct> {
  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByChannelUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByCustomType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorCode');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByExtendedMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extendedMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOperatorMessage');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReplyToChannel');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSilent');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionType');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctByMentionedUsers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionedUsers');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageId');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctByParentMessageRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageRootId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageType');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByRequestId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requestId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requireAuth');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByRootId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct>
      distinctBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sendingStatus');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'size');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<CFileMessage, CFileMessage, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }
}

extension CFileMessageQueryProperty
    on QueryBuilder<CFileMessage, CFileMessage, QQueryProperty> {
  QueryBuilder<CFileMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CFileMessage, List<CMessageMetaArray>?, QQueryOperations>
      allMetaArraysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allMetaArrays');
    });
  }

  QueryBuilder<CFileMessage, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CFileMessage, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CFileMessage, int, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CFileMessage, String?, QQueryOperations> customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CFileMessage, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CFileMessage, int?, QQueryOperations> errorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorCode');
    });
  }

  QueryBuilder<CFileMessage, String, QQueryOperations>
      extendedMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extendedMessage');
    });
  }

  QueryBuilder<CFileMessage, bool, QQueryOperations>
      isOperatorMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOperatorMessage');
    });
  }

  QueryBuilder<CFileMessage, bool, QQueryOperations>
      isReplyToChannelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReplyToChannel');
    });
  }

  QueryBuilder<CFileMessage, bool, QQueryOperations> isSilentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSilent');
    });
  }

  QueryBuilder<CFileMessage, MentionType, QQueryOperations>
      mentionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionType');
    });
  }

  QueryBuilder<CFileMessage, List<String>, QQueryOperations>
      mentionedUsersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionedUsers');
    });
  }

  QueryBuilder<CFileMessage, String, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<CFileMessage, CFileMessageCreateParams?, QQueryOperations>
      messageCreateParamsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageCreateParams');
    });
  }

  QueryBuilder<CFileMessage, int, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<CFileMessage, int?, QQueryOperations>
      messageSurvivalSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CFileMessage, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<CFileMessage, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CFileMessage, COGMetaData?, QQueryOperations>
      ogMetaDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ogMetaData');
    });
  }

  QueryBuilder<CFileMessage, int?, QQueryOperations> parentMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageId');
    });
  }

  QueryBuilder<CFileMessage, String?, QQueryOperations>
      parentMessageRootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageRootId');
    });
  }

  QueryBuilder<CFileMessage, MessageType, QQueryOperations>
      parentMessageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageType');
    });
  }

  QueryBuilder<CFileMessage, List<CReaction>?, QQueryOperations>
      reactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reactions');
    });
  }

  QueryBuilder<CFileMessage, String?, QQueryOperations> requestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requestId');
    });
  }

  QueryBuilder<CFileMessage, bool, QQueryOperations> requireAuthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requireAuth');
    });
  }

  QueryBuilder<CFileMessage, String, QQueryOperations> rootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootId');
    });
  }

  QueryBuilder<CFileMessage, CScheduledInfo?, QQueryOperations>
      scheduledInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledInfo');
    });
  }

  QueryBuilder<CFileMessage, CSender?, QQueryOperations> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sender');
    });
  }

  QueryBuilder<CFileMessage, SendingStatus, QQueryOperations>
      sendingStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sendingStatus');
    });
  }

  QueryBuilder<CFileMessage, int?, QQueryOperations> sizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'size');
    });
  }

  QueryBuilder<CFileMessage, CThreadInfo?, QQueryOperations>
      threadInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'threadInfo');
    });
  }

  QueryBuilder<CFileMessage, List<CThumbnail>?, QQueryOperations>
      thumbnailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnails');
    });
  }

  QueryBuilder<CFileMessage, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<CFileMessage, int, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<CFileMessage, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CThumbnailSchema = Schema(
  name: r'CThumbnail',
  id: BigInt.parse('9179756824618085965').toInt(),
  properties: {
    r'height': PropertySchema(
      id: 0,
      name: r'height',
      type: IsarType.double,
    ),
    r'plainUrl': PropertySchema(
      id: 1,
      name: r'plainUrl',
      type: IsarType.string,
    ),
    r'realHeight': PropertySchema(
      id: 2,
      name: r'realHeight',
      type: IsarType.double,
    ),
    r'realWidth': PropertySchema(
      id: 3,
      name: r'realWidth',
      type: IsarType.double,
    ),
    r'url': PropertySchema(
      id: 4,
      name: r'url',
      type: IsarType.string,
    ),
    r'width': PropertySchema(
      id: 5,
      name: r'width',
      type: IsarType.double,
    )
  },
  estimateSize: _cThumbnailEstimateSize,
  serialize: _cThumbnailSerialize,
  deserialize: _cThumbnailDeserialize,
  deserializeProp: _cThumbnailDeserializeProp,
);

int _cThumbnailEstimateSize(
  CThumbnail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.plainUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _cThumbnailSerialize(
  CThumbnail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeString(offsets[1], object.plainUrl);
  writer.writeDouble(offsets[2], object.realHeight);
  writer.writeDouble(offsets[3], object.realWidth);
  writer.writeString(offsets[4], object.url);
  writer.writeDouble(offsets[5], object.width);
}

CThumbnail _cThumbnailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CThumbnail();
  object.height = reader.readDoubleOrNull(offsets[0]);
  object.plainUrl = reader.readStringOrNull(offsets[1]);
  object.realHeight = reader.readDoubleOrNull(offsets[2]);
  object.realWidth = reader.readDoubleOrNull(offsets[3]);
  object.url = reader.readString(offsets[4]);
  object.width = reader.readDoubleOrNull(offsets[5]);
  return object;
}

P _cThumbnailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CThumbnailQueryFilter
    on QueryBuilder<CThumbnail, CThumbnail, QFilterCondition> {
  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> heightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> heightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> heightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> heightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> plainUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'plainUrl',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      plainUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'plainUrl',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> plainUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plainUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      plainUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plainUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> plainUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plainUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> plainUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plainUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      plainUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plainUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> plainUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plainUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> plainUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plainUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> plainUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plainUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      plainUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plainUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      plainUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plainUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      realHeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'realHeight',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      realHeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'realHeight',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> realHeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      realHeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'realHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      realHeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'realHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> realHeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'realHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      realWidthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'realWidth',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      realWidthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'realWidth',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> realWidthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition>
      realWidthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'realWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> realWidthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'realWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> realWidthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'realWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> widthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> widthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> widthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CThumbnail, CThumbnail, QAfterFilterCondition> widthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CThumbnailQueryObject
    on QueryBuilder<CThumbnail, CThumbnail, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CFileMessageCreateParamsSchema = Schema(
  name: r'CFileMessageCreateParams',
  id: BigInt.parse('-28171588097914807').toInt(),
  properties: {
    r'customType': PropertySchema(
      id: 0,
      name: r'customType',
      type: IsarType.string,
    ),
    r'data': PropertySchema(
      id: 1,
      name: r'data',
      type: IsarType.string,
    ),
    r'fileInfo': PropertySchema(
      id: 2,
      name: r'fileInfo',
      type: IsarType.object,
      target: r'CFileInfo',
    ),
    r'isPinnedMessage': PropertySchema(
      id: 3,
      name: r'isPinnedMessage',
      type: IsarType.bool,
    ),
    r'mentionType': PropertySchema(
      id: 4,
      name: r'mentionType',
      type: IsarType.byte,
      enumMap: _CFileMessageCreateParamsmentionTypeEnumValueMap,
    ),
    r'mentionedUserIds': PropertySchema(
      id: 5,
      name: r'mentionedUserIds',
      type: IsarType.stringList,
    ),
    r'metaArrays': PropertySchema(
      id: 6,
      name: r'metaArrays',
      type: IsarType.objectList,
      target: r'CMessageMetaArray',
    ),
    r'parentMessageId': PropertySchema(
      id: 7,
      name: r'parentMessageId',
      type: IsarType.long,
    ),
    r'pushNotificationDeliveryOption': PropertySchema(
      id: 8,
      name: r'pushNotificationDeliveryOption',
      type: IsarType.byte,
      enumMap:
          _CFileMessageCreateParamspushNotificationDeliveryOptionEnumValueMap,
    ),
    r'replyToChannel': PropertySchema(
      id: 9,
      name: r'replyToChannel',
      type: IsarType.bool,
    ),
    r'thumbnailSizes': PropertySchema(
      id: 10,
      name: r'thumbnailSizes',
      type: IsarType.objectList,
      target: r'CSize',
    )
  },
  estimateSize: _cFileMessageCreateParamsEstimateSize,
  serialize: _cFileMessageCreateParamsSerialize,
  deserialize: _cFileMessageCreateParamsDeserialize,
  deserializeProp: _cFileMessageCreateParamsDeserializeProp,
);

int _cFileMessageCreateParamsEstimateSize(
  CFileMessageCreateParams object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
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
  bytesCount += 3 +
      CFileInfoSchema.estimateSize(
          object.fileInfo, allOffsets[CFileInfo]!, allOffsets);
  {
    final list = object.mentionedUserIds;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.metaArrays;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CMessageMetaArray]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CMessageMetaArraySchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.thumbnailSizes;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CSize]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += CSizeSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _cFileMessageCreateParamsSerialize(
  CFileMessageCreateParams object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customType);
  writer.writeString(offsets[1], object.data);
  writer.writeObject<CFileInfo>(
    offsets[2],
    allOffsets,
    CFileInfoSchema.serialize,
    object.fileInfo,
  );
  writer.writeBool(offsets[3], object.isPinnedMessage);
  writer.writeByte(offsets[4], object.mentionType.index);
  writer.writeStringList(offsets[5], object.mentionedUserIds);
  writer.writeObjectList<CMessageMetaArray>(
    offsets[6],
    allOffsets,
    CMessageMetaArraySchema.serialize,
    object.metaArrays,
  );
  writer.writeLong(offsets[7], object.parentMessageId);
  writer.writeByte(offsets[8], object.pushNotificationDeliveryOption.index);
  writer.writeBool(offsets[9], object.replyToChannel);
  writer.writeObjectList<CSize>(
    offsets[10],
    allOffsets,
    CSizeSchema.serialize,
    object.thumbnailSizes,
  );
}

CFileMessageCreateParams _cFileMessageCreateParamsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CFileMessageCreateParams();
  object.customType = reader.readStringOrNull(offsets[0]);
  object.data = reader.readStringOrNull(offsets[1]);
  object.fileInfo = reader.readObjectOrNull<CFileInfo>(
        offsets[2],
        CFileInfoSchema.deserialize,
        allOffsets,
      ) ??
      CFileInfo();
  object.isPinnedMessage = reader.readBool(offsets[3]);
  object.mentionType = _CFileMessageCreateParamsmentionTypeValueEnumMap[
          reader.readByteOrNull(offsets[4])] ??
      MentionType.users;
  object.mentionedUserIds = reader.readStringList(offsets[5]);
  object.metaArrays = reader.readObjectList<CMessageMetaArray>(
    offsets[6],
    CMessageMetaArraySchema.deserialize,
    allOffsets,
    CMessageMetaArray(),
  );
  object.parentMessageId = reader.readLongOrNull(offsets[7]);
  object.pushNotificationDeliveryOption =
      _CFileMessageCreateParamspushNotificationDeliveryOptionValueEnumMap[
              reader.readByteOrNull(offsets[8])] ??
          PushNotificationDeliveryOption.normal;
  object.replyToChannel = reader.readBool(offsets[9]);
  object.thumbnailSizes = reader.readObjectList<CSize>(
    offsets[10],
    CSizeSchema.deserialize,
    allOffsets,
    CSize(),
  );
  return object;
}

P _cFileMessageCreateParamsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<CFileInfo>(
            offset,
            CFileInfoSchema.deserialize,
            allOffsets,
          ) ??
          CFileInfo()) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (_CFileMessageCreateParamsmentionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MentionType.users) as P;
    case 5:
      return (reader.readStringList(offset)) as P;
    case 6:
      return (reader.readObjectList<CMessageMetaArray>(
        offset,
        CMessageMetaArraySchema.deserialize,
        allOffsets,
        CMessageMetaArray(),
      )) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (_CFileMessageCreateParamspushNotificationDeliveryOptionValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PushNotificationDeliveryOption.normal) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readObjectList<CSize>(
        offset,
        CSizeSchema.deserialize,
        allOffsets,
        CSize(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CFileMessageCreateParamsmentionTypeEnumValueMap = {
  'users': 0,
  'channel': 1,
};
const _CFileMessageCreateParamsmentionTypeValueEnumMap = {
  0: MentionType.users,
  1: MentionType.channel,
};
const _CFileMessageCreateParamspushNotificationDeliveryOptionEnumValueMap = {
  'normal': 0,
  'suppress': 1,
  'force': 2,
};
const _CFileMessageCreateParamspushNotificationDeliveryOptionValueEnumMap = {
  0: PushNotificationDeliveryOption.normal,
  1: PushNotificationDeliveryOption.suppress,
  2: PushNotificationDeliveryOption.force,
};

extension CFileMessageCreateParamsQueryFilter on QueryBuilder<
    CFileMessageCreateParams, CFileMessageCreateParams, QFilterCondition> {
  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeEqualTo(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeGreaterThan(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeLessThan(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeBetween(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeStartsWith(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeEndsWith(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataEqualTo(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataGreaterThan(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataLessThan(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataBetween(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataStartsWith(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataEndsWith(
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

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      dataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      dataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'data',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> isPinnedMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPinnedMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionTypeEqualTo(MentionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionTypeGreaterThan(
    MentionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionTypeLessThan(
    MentionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionTypeBetween(
    MentionType lower,
    MentionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mentionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mentionedUserIds',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mentionedUserIds',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUserIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mentionedUserIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mentionedUserIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mentionedUserIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mentionedUserIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mentionedUserIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      mentionedUserIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mentionedUserIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      mentionedUserIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mentionedUserIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUserIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUserIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUserIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUserIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUserIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mentionedUserIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'metaArrays',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'metaArrays',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'metaArrays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'metaArrays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'metaArrays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'metaArrays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'metaArrays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> metaArraysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'metaArrays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> parentMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> parentMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> parentMessageIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> parentMessageIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> parentMessageIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> parentMessageIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentMessageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      pushNotificationDeliveryOptionEqualTo(
          PushNotificationDeliveryOption value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pushNotificationDeliveryOption',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> pushNotificationDeliveryOptionGreaterThan(
    PushNotificationDeliveryOption value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pushNotificationDeliveryOption',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> pushNotificationDeliveryOptionLessThan(
    PushNotificationDeliveryOption value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pushNotificationDeliveryOption',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> pushNotificationDeliveryOptionBetween(
    PushNotificationDeliveryOption lower,
    PushNotificationDeliveryOption upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pushNotificationDeliveryOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> replyToChannelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'replyToChannel',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailSizes',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailSizes',
      ));
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailSizes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailSizes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailSizes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailSizes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailSizes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailSizes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CFileMessageCreateParamsQueryObject on QueryBuilder<
    CFileMessageCreateParams, CFileMessageCreateParams, QFilterCondition> {
  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> fileInfo(FilterQuery<CFileInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fileInfo');
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
          QAfterFilterCondition>
      metaArraysElement(FilterQuery<CMessageMetaArray> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'metaArrays');
    });
  }

  QueryBuilder<CFileMessageCreateParams, CFileMessageCreateParams,
      QAfterFilterCondition> thumbnailSizesElement(FilterQuery<CSize> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnailSizes');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CFileInfoSchema = Schema(
  name: r'CFileInfo',
  id: BigInt.parse('996992686443270943').toInt(),
  properties: {
    r'fileName': PropertySchema(
      id: 0,
      name: r'fileName',
      type: IsarType.string,
    ),
    r'fileSize': PropertySchema(
      id: 1,
      name: r'fileSize',
      type: IsarType.long,
    ),
    r'fileUrl': PropertySchema(
      id: 2,
      name: r'fileUrl',
      type: IsarType.string,
    ),
    r'localFilePath': PropertySchema(
      id: 3,
      name: r'localFilePath',
      type: IsarType.string,
    ),
    r'mimeType': PropertySchema(
      id: 4,
      name: r'mimeType',
      type: IsarType.string,
    )
  },
  estimateSize: _cFileInfoEstimateSize,
  serialize: _cFileInfoSerialize,
  deserialize: _cFileInfoDeserialize,
  deserializeProp: _cFileInfoDeserializeProp,
);

int _cFileInfoEstimateSize(
  CFileInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fileName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fileUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.localFilePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mimeType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cFileInfoSerialize(
  CFileInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fileName);
  writer.writeLong(offsets[1], object.fileSize);
  writer.writeString(offsets[2], object.fileUrl);
  writer.writeString(offsets[3], object.localFilePath);
  writer.writeString(offsets[4], object.mimeType);
}

CFileInfo _cFileInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CFileInfo();
  object.fileName = reader.readStringOrNull(offsets[0]);
  object.fileSize = reader.readLongOrNull(offsets[1]);
  object.fileUrl = reader.readStringOrNull(offsets[2]);
  object.localFilePath = reader.readStringOrNull(offsets[3]);
  object.mimeType = reader.readStringOrNull(offsets[4]);
  return object;
}

P _cFileInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CFileInfoQueryFilter
    on QueryBuilder<CFileInfo, CFileInfo, QFilterCondition> {
  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileName',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      fileNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileName',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileSizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileSize',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      fileSizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileSize',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileSizeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileSizeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileSizeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileSizeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileUrl',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileUrl',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> fileUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      fileUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localFilePath',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localFilePath',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localFilePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localFilePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      localFilePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mimeType',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      mimeTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mimeType',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mimeType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mimeType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition> mimeTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mimeType',
        value: '',
      ));
    });
  }

  QueryBuilder<CFileInfo, CFileInfo, QAfterFilterCondition>
      mimeTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mimeType',
        value: '',
      ));
    });
  }
}

extension CFileInfoQueryObject
    on QueryBuilder<CFileInfo, CFileInfo, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CSizeSchema = Schema(
  name: r'CSize',
  id: BigInt.parse('5020865885922142944').toInt(),
  properties: {
    r'height': PropertySchema(
      id: 0,
      name: r'height',
      type: IsarType.double,
    ),
    r'width': PropertySchema(
      id: 1,
      name: r'width',
      type: IsarType.double,
    )
  },
  estimateSize: _cSizeEstimateSize,
  serialize: _cSizeSerialize,
  deserialize: _cSizeDeserialize,
  deserializeProp: _cSizeDeserializeProp,
);

int _cSizeEstimateSize(
  CSize object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _cSizeSerialize(
  CSize object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeDouble(offsets[1], object.width);
}

CSize _cSizeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CSize();
  object.height = reader.readDouble(offsets[0]);
  object.width = reader.readDouble(offsets[1]);
  return object;
}

P _cSizeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CSizeQueryFilter on QueryBuilder<CSize, CSize, QFilterCondition> {
  QueryBuilder<CSize, CSize, QAfterFilterCondition> heightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CSize, CSize, QAfterFilterCondition> heightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CSize, CSize, QAfterFilterCondition> heightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CSize, CSize, QAfterFilterCondition> heightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CSize, CSize, QAfterFilterCondition> widthEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CSize, CSize, QAfterFilterCondition> widthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CSize, CSize, QAfterFilterCondition> widthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CSize, CSize, QAfterFilterCondition> widthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CSizeQueryObject on QueryBuilder<CSize, CSize, QFilterCondition> {}
