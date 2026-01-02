// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_multiple_files_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCMultipleFilesMessageCollection on Isar {
  IsarCollection<CMultipleFilesMessage> get cMultipleFilesMessages =>
      this.collection();
}

final CMultipleFilesMessageSchema = CollectionSchema(
  name: r'CMultipleFilesMessage',
  id: BigInt.parse('6282540580451750083').toInt(),
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
      enumMap: _CMultipleFilesMessagechannelTypeEnumValueMap,
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
    r'files': PropertySchema(
      id: 8,
      name: r'files',
      type: IsarType.objectList,
      target: r'CUploadedFileInfo',
    ),
    r'isOperatorMessage': PropertySchema(
      id: 9,
      name: r'isOperatorMessage',
      type: IsarType.bool,
    ),
    r'isReplyToChannel': PropertySchema(
      id: 10,
      name: r'isReplyToChannel',
      type: IsarType.bool,
    ),
    r'isSilent': PropertySchema(
      id: 11,
      name: r'isSilent',
      type: IsarType.bool,
    ),
    r'mentionType': PropertySchema(
      id: 12,
      name: r'mentionType',
      type: IsarType.byte,
      enumMap: _CMultipleFilesMessagementionTypeEnumValueMap,
    ),
    r'mentionedUserIds': PropertySchema(
      id: 13,
      name: r'mentionedUserIds',
      type: IsarType.stringList,
    ),
    r'mentionedUsers': PropertySchema(
      id: 14,
      name: r'mentionedUsers',
      type: IsarType.stringList,
    ),
    r'message': PropertySchema(
      id: 15,
      name: r'message',
      type: IsarType.string,
    ),
    r'messageCreateParams': PropertySchema(
      id: 16,
      name: r'messageCreateParams',
      type: IsarType.object,
      target: r'CMultipleFilesMessageCreateParams',
    ),
    r'messageId': PropertySchema(
      id: 17,
      name: r'messageId',
      type: IsarType.long,
    ),
    r'messageSurvivalSeconds': PropertySchema(
      id: 18,
      name: r'messageSurvivalSeconds',
      type: IsarType.long,
    ),
    r'messageType': PropertySchema(
      id: 19,
      name: r'messageType',
      type: IsarType.byte,
      enumMap: _CMultipleFilesMessagemessageTypeEnumValueMap,
    ),
    r'ogMetaData': PropertySchema(
      id: 20,
      name: r'ogMetaData',
      type: IsarType.object,
      target: r'COGMetaData',
    ),
    r'parentMessageId': PropertySchema(
      id: 21,
      name: r'parentMessageId',
      type: IsarType.long,
    ),
    r'parentMessageRootId': PropertySchema(
      id: 22,
      name: r'parentMessageRootId',
      type: IsarType.string,
    ),
    r'parentMessageType': PropertySchema(
      id: 23,
      name: r'parentMessageType',
      type: IsarType.byte,
      enumMap: _CMultipleFilesMessageparentMessageTypeEnumValueMap,
    ),
    r'reactions': PropertySchema(
      id: 24,
      name: r'reactions',
      type: IsarType.objectList,
      target: r'CReaction',
    ),
    r'requestId': PropertySchema(
      id: 25,
      name: r'requestId',
      type: IsarType.string,
    ),
    r'requireAuth': PropertySchema(
      id: 26,
      name: r'requireAuth',
      type: IsarType.bool,
    ),
    r'rootId': PropertySchema(
      id: 27,
      name: r'rootId',
      type: IsarType.string,
    ),
    r'scheduledInfo': PropertySchema(
      id: 28,
      name: r'scheduledInfo',
      type: IsarType.object,
      target: r'CScheduledInfo',
    ),
    r'sender': PropertySchema(
      id: 29,
      name: r'sender',
      type: IsarType.object,
      target: r'CSender',
    ),
    r'sendingStatus': PropertySchema(
      id: 30,
      name: r'sendingStatus',
      type: IsarType.byte,
      enumMap: _CMultipleFilesMessagesendingStatusEnumValueMap,
    ),
    r'threadInfo': PropertySchema(
      id: 31,
      name: r'threadInfo',
      type: IsarType.object,
      target: r'CThreadInfo',
    ),
    r'updatedAt': PropertySchema(
      id: 32,
      name: r'updatedAt',
      type: IsarType.long,
    )
  },
  estimateSize: _cMultipleFilesMessageEstimateSize,
  serialize: _cMultipleFilesMessageSerialize,
  deserialize: _cMultipleFilesMessageDeserialize,
  deserializeProp: _cMultipleFilesMessageDeserializeProp,
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
    r'CUploadedFileInfo': CUploadedFileInfoSchema,
    r'CThumbnail': CThumbnailSchema,
    r'CMultipleFilesMessageCreateParams':
        CMultipleFilesMessageCreateParamsSchema,
    r'CMessageMetaArray': CMessageMetaArraySchema,
    r'CUploadableFileInfo': CUploadableFileInfoSchema,
    r'CFileInfo': CFileInfoSchema,
    r'CSize': CSizeSchema,
    r'CThreadInfo': CThreadInfoSchema,
    r'COGMetaData': COGMetaDataSchema,
    r'COGImage': COGImageSchema,
    r'CReaction': CReactionSchema,
    r'CScheduledInfo': CScheduledInfoSchema,
    r'CSender': CSenderSchema
  },
  getId: _cMultipleFilesMessageGetId,
  getLinks: _cMultipleFilesMessageGetLinks,
  attach: _cMultipleFilesMessageAttach,
  version: '3.3.0',
);

int _cMultipleFilesMessageEstimateSize(
  CMultipleFilesMessage object,
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
  bytesCount += 3 + object.files.length * 3;
  {
    final offsets = allOffsets[CUploadedFileInfo]!;
    for (var i = 0; i < object.files.length; i++) {
      final value = object.files[i];
      bytesCount +=
          CUploadedFileInfoSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.mentionedUserIds.length * 3;
  {
    for (var i = 0; i < object.mentionedUserIds.length; i++) {
      final value = object.mentionedUserIds[i];
      bytesCount += value.length * 3;
    }
  }
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
          CMultipleFilesMessageCreateParamsSchema.estimateSize(value,
              allOffsets[CMultipleFilesMessageCreateParams]!, allOffsets);
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
  return bytesCount;
}

void _cMultipleFilesMessageSerialize(
  CMultipleFilesMessage object,
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
  writer.writeObjectList<CUploadedFileInfo>(
    offsets[8],
    allOffsets,
    CUploadedFileInfoSchema.serialize,
    object.files,
  );
  writer.writeBool(offsets[9], object.isOperatorMessage);
  writer.writeBool(offsets[10], object.isReplyToChannel);
  writer.writeBool(offsets[11], object.isSilent);
  writer.writeByte(offsets[12], object.mentionType.index);
  writer.writeStringList(offsets[13], object.mentionedUserIds);
  writer.writeStringList(offsets[14], object.mentionedUsers);
  writer.writeString(offsets[15], object.message);
  writer.writeObject<CMultipleFilesMessageCreateParams>(
    offsets[16],
    allOffsets,
    CMultipleFilesMessageCreateParamsSchema.serialize,
    object.messageCreateParams,
  );
  writer.writeLong(offsets[17], object.messageId);
  writer.writeLong(offsets[18], object.messageSurvivalSeconds);
  writer.writeByte(offsets[19], object.messageType.index);
  writer.writeObject<COGMetaData>(
    offsets[20],
    allOffsets,
    COGMetaDataSchema.serialize,
    object.ogMetaData,
  );
  writer.writeLong(offsets[21], object.parentMessageId);
  writer.writeString(offsets[22], object.parentMessageRootId);
  writer.writeByte(offsets[23], object.parentMessageType.index);
  writer.writeObjectList<CReaction>(
    offsets[24],
    allOffsets,
    CReactionSchema.serialize,
    object.reactions,
  );
  writer.writeString(offsets[25], object.requestId);
  writer.writeBool(offsets[26], object.requireAuth);
  writer.writeString(offsets[27], object.rootId);
  writer.writeObject<CScheduledInfo>(
    offsets[28],
    allOffsets,
    CScheduledInfoSchema.serialize,
    object.scheduledInfo,
  );
  writer.writeObject<CSender>(
    offsets[29],
    allOffsets,
    CSenderSchema.serialize,
    object.sender,
  );
  writer.writeByte(offsets[30], object.sendingStatus.index);
  writer.writeObject<CThreadInfo>(
    offsets[31],
    allOffsets,
    CThreadInfoSchema.serialize,
    object.threadInfo,
  );
  writer.writeLong(offsets[32], object.updatedAt);
}

CMultipleFilesMessage _cMultipleFilesMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CMultipleFilesMessage();
  object.allMetaArrays = reader.readObjectList<CMessageMetaArray>(
    offsets[0],
    CMessageMetaArraySchema.deserialize,
    allOffsets,
    CMessageMetaArray(),
  );
  object.channelType = _CMultipleFilesMessagechannelTypeValueEnumMap[
          reader.readByteOrNull(offsets[1])] ??
      ChannelType.group;
  object.channelUrl = reader.readString(offsets[2]);
  object.createdAt = reader.readLong(offsets[3]);
  object.customType = reader.readStringOrNull(offsets[4]);
  object.data = reader.readStringOrNull(offsets[5]);
  object.errorCode = reader.readLongOrNull(offsets[6]);
  object.extendedMessage = reader.readString(offsets[7]);
  object.files = reader.readObjectList<CUploadedFileInfo>(
        offsets[8],
        CUploadedFileInfoSchema.deserialize,
        allOffsets,
        CUploadedFileInfo(),
      ) ??
      [];
  object.id = id;
  object.isOperatorMessage = reader.readBool(offsets[9]);
  object.isReplyToChannel = reader.readBool(offsets[10]);
  object.isSilent = reader.readBool(offsets[11]);
  object.mentionType = _CMultipleFilesMessagementionTypeValueEnumMap[
          reader.readByteOrNull(offsets[12])] ??
      MentionType.users;
  object.mentionedUserIds = reader.readStringList(offsets[13]) ?? [];
  object.mentionedUsers = reader.readStringList(offsets[14]) ?? [];
  object.message = reader.readString(offsets[15]);
  object.messageCreateParams =
      reader.readObjectOrNull<CMultipleFilesMessageCreateParams>(
    offsets[16],
    CMultipleFilesMessageCreateParamsSchema.deserialize,
    allOffsets,
  );
  object.messageId = reader.readLong(offsets[17]);
  object.messageSurvivalSeconds = reader.readLongOrNull(offsets[18]);
  object.messageType = _CMultipleFilesMessagemessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[19])] ??
      MessageType.user;
  object.ogMetaData = reader.readObjectOrNull<COGMetaData>(
    offsets[20],
    COGMetaDataSchema.deserialize,
    allOffsets,
  );
  object.parentMessageId = reader.readLongOrNull(offsets[21]);
  object.parentMessageRootId = reader.readStringOrNull(offsets[22]);
  object.parentMessageType =
      _CMultipleFilesMessageparentMessageTypeValueEnumMap[
              reader.readByteOrNull(offsets[23])] ??
          MessageType.user;
  object.reactions = reader.readObjectList<CReaction>(
    offsets[24],
    CReactionSchema.deserialize,
    allOffsets,
    CReaction(),
  );
  object.requestId = reader.readStringOrNull(offsets[25]);
  object.requireAuth = reader.readBool(offsets[26]);
  object.rootId = reader.readString(offsets[27]);
  object.scheduledInfo = reader.readObjectOrNull<CScheduledInfo>(
    offsets[28],
    CScheduledInfoSchema.deserialize,
    allOffsets,
  );
  object.sender = reader.readObjectOrNull<CSender>(
    offsets[29],
    CSenderSchema.deserialize,
    allOffsets,
  );
  object.sendingStatus = _CMultipleFilesMessagesendingStatusValueEnumMap[
          reader.readByteOrNull(offsets[30])] ??
      SendingStatus.none;
  object.threadInfo = reader.readObjectOrNull<CThreadInfo>(
    offsets[31],
    CThreadInfoSchema.deserialize,
    allOffsets,
  );
  object.updatedAt = reader.readLong(offsets[32]);
  return object;
}

P _cMultipleFilesMessageDeserializeProp<P>(
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
      return (_CMultipleFilesMessagechannelTypeValueEnumMap[
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
      return (reader.readObjectList<CUploadedFileInfo>(
            offset,
            CUploadedFileInfoSchema.deserialize,
            allOffsets,
            CUploadedFileInfo(),
          ) ??
          []) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (_CMultipleFilesMessagementionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MentionType.users) as P;
    case 13:
      return (reader.readStringList(offset) ?? []) as P;
    case 14:
      return (reader.readStringList(offset) ?? []) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readObjectOrNull<CMultipleFilesMessageCreateParams>(
        offset,
        CMultipleFilesMessageCreateParamsSchema.deserialize,
        allOffsets,
      )) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (_CMultipleFilesMessagemessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 20:
      return (reader.readObjectOrNull<COGMetaData>(
        offset,
        COGMetaDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (_CMultipleFilesMessageparentMessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 24:
      return (reader.readObjectList<CReaction>(
        offset,
        CReactionSchema.deserialize,
        allOffsets,
        CReaction(),
      )) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readBool(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readObjectOrNull<CScheduledInfo>(
        offset,
        CScheduledInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 29:
      return (reader.readObjectOrNull<CSender>(
        offset,
        CSenderSchema.deserialize,
        allOffsets,
      )) as P;
    case 30:
      return (_CMultipleFilesMessagesendingStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SendingStatus.none) as P;
    case 31:
      return (reader.readObjectOrNull<CThreadInfo>(
        offset,
        CThreadInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 32:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CMultipleFilesMessagechannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CMultipleFilesMessagechannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};
const _CMultipleFilesMessagementionTypeEnumValueMap = {
  'users': 0,
  'channel': 1,
};
const _CMultipleFilesMessagementionTypeValueEnumMap = {
  0: MentionType.users,
  1: MentionType.channel,
};
const _CMultipleFilesMessagemessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CMultipleFilesMessagemessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CMultipleFilesMessageparentMessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CMultipleFilesMessageparentMessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CMultipleFilesMessagesendingStatusEnumValueMap = {
  'none': 0,
  'pending': 1,
  'failed': 2,
  'succeeded': 3,
  'canceled': 4,
};
const _CMultipleFilesMessagesendingStatusValueEnumMap = {
  0: SendingStatus.none,
  1: SendingStatus.pending,
  2: SendingStatus.failed,
  3: SendingStatus.succeeded,
  4: SendingStatus.canceled,
};

Id _cMultipleFilesMessageGetId(CMultipleFilesMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cMultipleFilesMessageGetLinks(
    CMultipleFilesMessage object) {
  return [];
}

void _cMultipleFilesMessageAttach(
    IsarCollection<dynamic> col, Id id, CMultipleFilesMessage object) {
  object.id = id;
}

extension CMultipleFilesMessageByIndex
    on IsarCollection<CMultipleFilesMessage> {
  Future<CMultipleFilesMessage?> getByRootId(String rootId) {
    return getByIndex(r'rootId', [rootId]);
  }

  CMultipleFilesMessage? getByRootIdSync(String rootId) {
    return getByIndexSync(r'rootId', [rootId]);
  }

  Future<bool> deleteByRootId(String rootId) {
    return deleteByIndex(r'rootId', [rootId]);
  }

  bool deleteByRootIdSync(String rootId) {
    return deleteByIndexSync(r'rootId', [rootId]);
  }

  Future<List<CMultipleFilesMessage?>> getAllByRootId(
      List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'rootId', values);
  }

  List<CMultipleFilesMessage?> getAllByRootIdSync(List<String> rootIdValues) {
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

  Future<Id> putByRootId(CMultipleFilesMessage object) {
    return putByIndex(r'rootId', object);
  }

  Id putByRootIdSync(CMultipleFilesMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'rootId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRootId(List<CMultipleFilesMessage> objects) {
    return putAllByIndex(r'rootId', objects);
  }

  List<Id> putAllByRootIdSync(List<CMultipleFilesMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rootId', objects, saveLinks: saveLinks);
  }
}

extension CMultipleFilesMessageQueryWhereSort
    on QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QWhere> {
  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CMultipleFilesMessageQueryWhere on QueryBuilder<CMultipleFilesMessage,
    CMultipleFilesMessage, QWhereClause> {
  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      rootIdEqualTo(String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootId',
        value: [rootId],
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      rootIdNotEqualTo(String rootId) {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      messageTypeEqualToAnyRootId(MessageType messageType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType],
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      messageTypeRootIdEqualTo(MessageType messageType, String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType, rootId],
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterWhereClause>
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

extension CMultipleFilesMessageQueryFilter on QueryBuilder<
    CMultipleFilesMessage, CMultipleFilesMessage, QFilterCondition> {
  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysLengthEqualTo(int length) {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysIsEmpty() {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysIsNotEmpty() {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysLengthLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysLengthGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> allMetaArraysLengthBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelTypeGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelTypeLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelTypeBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlEqualTo(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlStartsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlEndsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> errorCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> errorCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> errorCodeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> errorCodeGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> errorCodeLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> errorCodeBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageEqualTo(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageStartsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageEndsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      extendedMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      extendedMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extendedMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> extendedMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> filesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> filesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> filesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> filesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> filesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> filesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'files',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> isOperatorMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOperatorMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> isReplyToChannelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReplyToChannel',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> isSilentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSilent',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionTypeEqualTo(MentionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUserIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUserIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementEqualTo(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementStartsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementEndsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      mentionedUsersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersLengthEqualTo(int length) {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersIsEmpty() {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersIsNotEmpty() {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersLengthLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersLengthGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> mentionedUsersLengthBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageEqualTo(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageStartsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageEndsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageCreateParamsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageCreateParams',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageCreateParamsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageCreateParams',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageIdGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageIdLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageIdBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageSurvivalSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageSurvivalSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageSurvivalSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageSurvivalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageSurvivalSecondsGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageSurvivalSecondsLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageSurvivalSecondsBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageTypeGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageTypeLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> messageTypeBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> ogMetaDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> ogMetaDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdEqualTo(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdStartsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdEndsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      parentMessageRootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      parentMessageRootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentMessageRootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageRootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageTypeGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageTypeLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> parentMessageTypeBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsLengthEqualTo(int length) {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsIsEmpty() {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsIsNotEmpty() {
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsLengthLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsLengthGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsLengthBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdEqualTo(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdStartsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdEndsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      requestIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      requestIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requestId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requestIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> requireAuthEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireAuth',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdEqualTo(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdStartsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdEndsWith(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      rootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      rootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> rootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> scheduledInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> scheduledInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> senderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> senderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> sendingStatusEqualTo(SendingStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sendingStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> sendingStatusGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> sendingStatusLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> sendingStatusBetween(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> threadInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> threadInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> updatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> updatedAtBetween(
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
}

extension CMultipleFilesMessageQueryObject on QueryBuilder<
    CMultipleFilesMessage, CMultipleFilesMessage, QFilterCondition> {
  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      allMetaArraysElement(FilterQuery<CMessageMetaArray> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allMetaArrays');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> filesElement(FilterQuery<CUploadedFileInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'files');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
          QAfterFilterCondition>
      messageCreateParams(FilterQuery<CMultipleFilesMessageCreateParams> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'messageCreateParams');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> ogMetaData(FilterQuery<COGMetaData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ogMetaData');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> reactionsElement(FilterQuery<CReaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reactions');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> scheduledInfo(FilterQuery<CScheduledInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'scheduledInfo');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> sender(FilterQuery<CSender> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sender');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage,
      QAfterFilterCondition> threadInfo(FilterQuery<CThreadInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'threadInfo');
    });
  }
}

extension CMultipleFilesMessageQueryLinks on QueryBuilder<CMultipleFilesMessage,
    CMultipleFilesMessage, QFilterCondition> {}

extension CMultipleFilesMessageQuerySortBy
    on QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QSortBy> {
  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByRequireAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CMultipleFilesMessageQuerySortThenBy
    on QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QSortThenBy> {
  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByRequireAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CMultipleFilesMessageQueryWhereDistinct
    on QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct> {
  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByChannelUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByCustomType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorCode');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByExtendedMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extendedMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOperatorMessage');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReplyToChannel');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSilent');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByMentionedUserIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionedUserIds');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByMentionedUsers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionedUsers');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageId');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByParentMessageRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageRootId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByRequestId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requestId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requireAuth');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sendingStatus');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessage, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CMultipleFilesMessageQueryProperty on QueryBuilder<
    CMultipleFilesMessage, CMultipleFilesMessage, QQueryProperty> {
  QueryBuilder<CMultipleFilesMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CMultipleFilesMessage, List<CMessageMetaArray>?,
      QQueryOperations> allMetaArraysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allMetaArrays');
    });
  }

  QueryBuilder<CMultipleFilesMessage, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String, QQueryOperations>
      channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CMultipleFilesMessage, int, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String?, QQueryOperations>
      customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String?, QQueryOperations>
      dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CMultipleFilesMessage, int?, QQueryOperations>
      errorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorCode');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String, QQueryOperations>
      extendedMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extendedMessage');
    });
  }

  QueryBuilder<CMultipleFilesMessage, List<CUploadedFileInfo>, QQueryOperations>
      filesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'files');
    });
  }

  QueryBuilder<CMultipleFilesMessage, bool, QQueryOperations>
      isOperatorMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOperatorMessage');
    });
  }

  QueryBuilder<CMultipleFilesMessage, bool, QQueryOperations>
      isReplyToChannelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReplyToChannel');
    });
  }

  QueryBuilder<CMultipleFilesMessage, bool, QQueryOperations>
      isSilentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSilent');
    });
  }

  QueryBuilder<CMultipleFilesMessage, MentionType, QQueryOperations>
      mentionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, List<String>, QQueryOperations>
      mentionedUserIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionedUserIds');
    });
  }

  QueryBuilder<CMultipleFilesMessage, List<String>, QQueryOperations>
      mentionedUsersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionedUsers');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String, QQueryOperations>
      messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CMultipleFilesMessageCreateParams?,
      QQueryOperations> messageCreateParamsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageCreateParams');
    });
  }

  QueryBuilder<CMultipleFilesMessage, int, QQueryOperations>
      messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<CMultipleFilesMessage, int?, QQueryOperations>
      messageSurvivalSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CMultipleFilesMessage, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, COGMetaData?, QQueryOperations>
      ogMetaDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ogMetaData');
    });
  }

  QueryBuilder<CMultipleFilesMessage, int?, QQueryOperations>
      parentMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageId');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String?, QQueryOperations>
      parentMessageRootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageRootId');
    });
  }

  QueryBuilder<CMultipleFilesMessage, MessageType, QQueryOperations>
      parentMessageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageType');
    });
  }

  QueryBuilder<CMultipleFilesMessage, List<CReaction>?, QQueryOperations>
      reactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reactions');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String?, QQueryOperations>
      requestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requestId');
    });
  }

  QueryBuilder<CMultipleFilesMessage, bool, QQueryOperations>
      requireAuthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requireAuth');
    });
  }

  QueryBuilder<CMultipleFilesMessage, String, QQueryOperations>
      rootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootId');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CScheduledInfo?, QQueryOperations>
      scheduledInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledInfo');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CSender?, QQueryOperations>
      senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sender');
    });
  }

  QueryBuilder<CMultipleFilesMessage, SendingStatus, QQueryOperations>
      sendingStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sendingStatus');
    });
  }

  QueryBuilder<CMultipleFilesMessage, CThreadInfo?, QQueryOperations>
      threadInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'threadInfo');
    });
  }

  QueryBuilder<CMultipleFilesMessage, int, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CUploadedFileInfoSchema = Schema(
  name: r'CUploadedFileInfo',
  id: BigInt.parse('7074409426857052605').toInt(),
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'requireAuth': PropertySchema(
      id: 1,
      name: r'requireAuth',
      type: IsarType.bool,
    ),
    r'size': PropertySchema(
      id: 2,
      name: r'size',
      type: IsarType.long,
    ),
    r'thumbnails': PropertySchema(
      id: 3,
      name: r'thumbnails',
      type: IsarType.objectList,
      target: r'CThumbnail',
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 5,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _cUploadedFileInfoEstimateSize,
  serialize: _cUploadedFileInfoSerialize,
  deserialize: _cUploadedFileInfoDeserialize,
  deserializeProp: _cUploadedFileInfoDeserializeProp,
);

int _cUploadedFileInfoEstimateSize(
  CUploadedFileInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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

void _cUploadedFileInfoSerialize(
  CUploadedFileInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeBool(offsets[1], object.requireAuth);
  writer.writeLong(offsets[2], object.size);
  writer.writeObjectList<CThumbnail>(
    offsets[3],
    allOffsets,
    CThumbnailSchema.serialize,
    object.thumbnails,
  );
  writer.writeString(offsets[4], object.type);
  writer.writeString(offsets[5], object.url);
}

CUploadedFileInfo _cUploadedFileInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CUploadedFileInfo();
  object.name = reader.readStringOrNull(offsets[0]);
  object.requireAuth = reader.readBool(offsets[1]);
  object.size = reader.readLongOrNull(offsets[2]);
  object.thumbnails = reader.readObjectList<CThumbnail>(
    offsets[3],
    CThumbnailSchema.deserialize,
    allOffsets,
    CThumbnail(),
  );
  object.type = reader.readStringOrNull(offsets[4]);
  object.url = reader.readString(offsets[5]);
  return object;
}

P _cUploadedFileInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readObjectList<CThumbnail>(
        offset,
        CThumbnailSchema.deserialize,
        allOffsets,
        CThumbnail(),
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CUploadedFileInfoQueryFilter
    on QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QFilterCondition> {
  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      requireAuthEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireAuth',
        value: value,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      sizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      sizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      sizeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      sizeLessThan(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      sizeBetween(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      thumbnailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnails',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      thumbnailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnails',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeEqualTo(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeLessThan(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeBetween(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeEndsWith(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlEqualTo(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlLessThan(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlBetween(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlStartsWith(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlEndsWith(
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

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension CUploadedFileInfoQueryObject
    on QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QFilterCondition> {
  QueryBuilder<CUploadedFileInfo, CUploadedFileInfo, QAfterFilterCondition>
      thumbnailsElement(FilterQuery<CThumbnail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnails');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CMultipleFilesMessageCreateParamsSchema = Schema(
  name: r'CMultipleFilesMessageCreateParams',
  id: BigInt.parse('43571134612513255').toInt(),
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
    r'isPinnedMessage': PropertySchema(
      id: 2,
      name: r'isPinnedMessage',
      type: IsarType.bool,
    ),
    r'mentionType': PropertySchema(
      id: 3,
      name: r'mentionType',
      type: IsarType.byte,
      enumMap: _CMultipleFilesMessageCreateParamsmentionTypeEnumValueMap,
    ),
    r'mentionedUserIds': PropertySchema(
      id: 4,
      name: r'mentionedUserIds',
      type: IsarType.stringList,
    ),
    r'metaArrays': PropertySchema(
      id: 5,
      name: r'metaArrays',
      type: IsarType.objectList,
      target: r'CMessageMetaArray',
    ),
    r'parentMessageId': PropertySchema(
      id: 6,
      name: r'parentMessageId',
      type: IsarType.long,
    ),
    r'pushNotificationDeliveryOption': PropertySchema(
      id: 7,
      name: r'pushNotificationDeliveryOption',
      type: IsarType.byte,
      enumMap:
          _CMultipleFilesMessageCreateParamspushNotificationDeliveryOptionEnumValueMap,
    ),
    r'replyToChannel': PropertySchema(
      id: 8,
      name: r'replyToChannel',
      type: IsarType.bool,
    ),
    r'uploadableFileInfoList': PropertySchema(
      id: 9,
      name: r'uploadableFileInfoList',
      type: IsarType.objectList,
      target: r'CUploadableFileInfo',
    )
  },
  estimateSize: _cMultipleFilesMessageCreateParamsEstimateSize,
  serialize: _cMultipleFilesMessageCreateParamsSerialize,
  deserialize: _cMultipleFilesMessageCreateParamsDeserialize,
  deserializeProp: _cMultipleFilesMessageCreateParamsDeserializeProp,
);

int _cMultipleFilesMessageCreateParamsEstimateSize(
  CMultipleFilesMessageCreateParams object,
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
  bytesCount += 3 + object.uploadableFileInfoList.length * 3;
  {
    final offsets = allOffsets[CUploadableFileInfo]!;
    for (var i = 0; i < object.uploadableFileInfoList.length; i++) {
      final value = object.uploadableFileInfoList[i];
      bytesCount +=
          CUploadableFileInfoSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _cMultipleFilesMessageCreateParamsSerialize(
  CMultipleFilesMessageCreateParams object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customType);
  writer.writeString(offsets[1], object.data);
  writer.writeBool(offsets[2], object.isPinnedMessage);
  writer.writeByte(offsets[3], object.mentionType.index);
  writer.writeStringList(offsets[4], object.mentionedUserIds);
  writer.writeObjectList<CMessageMetaArray>(
    offsets[5],
    allOffsets,
    CMessageMetaArraySchema.serialize,
    object.metaArrays,
  );
  writer.writeLong(offsets[6], object.parentMessageId);
  writer.writeByte(offsets[7], object.pushNotificationDeliveryOption.index);
  writer.writeBool(offsets[8], object.replyToChannel);
  writer.writeObjectList<CUploadableFileInfo>(
    offsets[9],
    allOffsets,
    CUploadableFileInfoSchema.serialize,
    object.uploadableFileInfoList,
  );
}

CMultipleFilesMessageCreateParams _cMultipleFilesMessageCreateParamsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CMultipleFilesMessageCreateParams();
  object.customType = reader.readStringOrNull(offsets[0]);
  object.data = reader.readStringOrNull(offsets[1]);
  object.isPinnedMessage = reader.readBool(offsets[2]);
  object.mentionType =
      _CMultipleFilesMessageCreateParamsmentionTypeValueEnumMap[
              reader.readByteOrNull(offsets[3])] ??
          MentionType.users;
  object.mentionedUserIds = reader.readStringList(offsets[4]);
  object.metaArrays = reader.readObjectList<CMessageMetaArray>(
    offsets[5],
    CMessageMetaArraySchema.deserialize,
    allOffsets,
    CMessageMetaArray(),
  );
  object.parentMessageId = reader.readLongOrNull(offsets[6]);
  object.pushNotificationDeliveryOption =
      _CMultipleFilesMessageCreateParamspushNotificationDeliveryOptionValueEnumMap[
              reader.readByteOrNull(offsets[7])] ??
          PushNotificationDeliveryOption.normal;
  object.replyToChannel = reader.readBool(offsets[8]);
  object.uploadableFileInfoList = reader.readObjectList<CUploadableFileInfo>(
        offsets[9],
        CUploadableFileInfoSchema.deserialize,
        allOffsets,
        CUploadableFileInfo(),
      ) ??
      [];
  return object;
}

P _cMultipleFilesMessageCreateParamsDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (_CMultipleFilesMessageCreateParamsmentionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MentionType.users) as P;
    case 4:
      return (reader.readStringList(offset)) as P;
    case 5:
      return (reader.readObjectList<CMessageMetaArray>(
        offset,
        CMessageMetaArraySchema.deserialize,
        allOffsets,
        CMessageMetaArray(),
      )) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (_CMultipleFilesMessageCreateParamspushNotificationDeliveryOptionValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PushNotificationDeliveryOption.normal) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readObjectList<CUploadableFileInfo>(
            offset,
            CUploadableFileInfoSchema.deserialize,
            allOffsets,
            CUploadableFileInfo(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CMultipleFilesMessageCreateParamsmentionTypeEnumValueMap = {
  'users': 0,
  'channel': 1,
};
const _CMultipleFilesMessageCreateParamsmentionTypeValueEnumMap = {
  0: MentionType.users,
  1: MentionType.channel,
};
const _CMultipleFilesMessageCreateParamspushNotificationDeliveryOptionEnumValueMap =
    {
  'normal': 0,
  'suppress': 1,
  'force': 2,
};
const _CMultipleFilesMessageCreateParamspushNotificationDeliveryOptionValueEnumMap =
    {
  0: PushNotificationDeliveryOption.normal,
  1: PushNotificationDeliveryOption.suppress,
  2: PushNotificationDeliveryOption.force,
};

extension CMultipleFilesMessageCreateParamsQueryFilter on QueryBuilder<
    CMultipleFilesMessageCreateParams,
    CMultipleFilesMessageCreateParams,
    QFilterCondition> {
  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataEqualTo(
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataGreaterThan(
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataLessThan(
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataBetween(
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataStartsWith(
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataEndsWith(
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
      dataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
      dataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'data',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams, QAfterFilterCondition> dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> isPinnedMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPinnedMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> mentionTypeEqualTo(MentionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mentionedUserIds',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mentionedUserIds',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> mentionedUserIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> metaArraysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'metaArrays',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> metaArraysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'metaArrays',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> parentMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> parentMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> parentMessageIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
      pushNotificationDeliveryOptionEqualTo(
          PushNotificationDeliveryOption value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pushNotificationDeliveryOption',
        value: value,
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
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

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> replyToChannelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'replyToChannel',
        value: value,
      ));
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> uploadableFileInfoListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uploadableFileInfoList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> uploadableFileInfoListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uploadableFileInfoList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> uploadableFileInfoListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uploadableFileInfoList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> uploadableFileInfoListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uploadableFileInfoList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> uploadableFileInfoListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uploadableFileInfoList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<
      CMultipleFilesMessageCreateParams,
      CMultipleFilesMessageCreateParams,
      QAfterFilterCondition> uploadableFileInfoListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'uploadableFileInfoList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CMultipleFilesMessageCreateParamsQueryObject on QueryBuilder<
    CMultipleFilesMessageCreateParams,
    CMultipleFilesMessageCreateParams,
    QFilterCondition> {
  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
      metaArraysElement(FilterQuery<CMessageMetaArray> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'metaArrays');
    });
  }

  QueryBuilder<CMultipleFilesMessageCreateParams,
          CMultipleFilesMessageCreateParams, QAfterFilterCondition>
      uploadableFileInfoListElement(FilterQuery<CUploadableFileInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'uploadableFileInfoList');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CUploadableFileInfoSchema = Schema(
  name: r'CUploadableFileInfo',
  id: BigInt.parse('-6703378113458311977').toInt(),
  properties: {
    r'fileInfo': PropertySchema(
      id: 0,
      name: r'fileInfo',
      type: IsarType.object,
      target: r'CFileInfo',
    ),
    r'thumbnailSizes': PropertySchema(
      id: 1,
      name: r'thumbnailSizes',
      type: IsarType.objectList,
      target: r'CSize',
    )
  },
  estimateSize: _cUploadableFileInfoEstimateSize,
  serialize: _cUploadableFileInfoSerialize,
  deserialize: _cUploadableFileInfoDeserialize,
  deserializeProp: _cUploadableFileInfoDeserializeProp,
);

int _cUploadableFileInfoEstimateSize(
  CUploadableFileInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      CFileInfoSchema.estimateSize(
          object.fileInfo, allOffsets[CFileInfo]!, allOffsets);
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

void _cUploadableFileInfoSerialize(
  CUploadableFileInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<CFileInfo>(
    offsets[0],
    allOffsets,
    CFileInfoSchema.serialize,
    object.fileInfo,
  );
  writer.writeObjectList<CSize>(
    offsets[1],
    allOffsets,
    CSizeSchema.serialize,
    object.thumbnailSizes,
  );
}

CUploadableFileInfo _cUploadableFileInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CUploadableFileInfo();
  object.fileInfo = reader.readObjectOrNull<CFileInfo>(
        offsets[0],
        CFileInfoSchema.deserialize,
        allOffsets,
      ) ??
      CFileInfo();
  object.thumbnailSizes = reader.readObjectList<CSize>(
    offsets[1],
    CSizeSchema.deserialize,
    allOffsets,
    CSize(),
  );
  return object;
}

P _cUploadableFileInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<CFileInfo>(
            offset,
            CFileInfoSchema.deserialize,
            allOffsets,
          ) ??
          CFileInfo()) as P;
    case 1:
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

extension CUploadableFileInfoQueryFilter on QueryBuilder<CUploadableFileInfo,
    CUploadableFileInfo, QFilterCondition> {
  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailSizes',
      ));
    });
  }

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailSizes',
      ));
    });
  }

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesLengthEqualTo(int length) {
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

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesIsEmpty() {
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

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesIsNotEmpty() {
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

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesLengthLessThan(
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

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesLengthGreaterThan(
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

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesLengthBetween(
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

extension CUploadableFileInfoQueryObject on QueryBuilder<CUploadableFileInfo,
    CUploadableFileInfo, QFilterCondition> {
  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      fileInfo(FilterQuery<CFileInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fileInfo');
    });
  }

  QueryBuilder<CUploadableFileInfo, CUploadableFileInfo, QAfterFilterCondition>
      thumbnailSizesElement(FilterQuery<CSize> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'thumbnailSizes');
    });
  }
}
