// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_user_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCUserMessageCollection on Isar {
  IsarCollection<CUserMessage> get cUserMessages => this.collection();
}

final CUserMessageSchema = CollectionSchema(
  name: r'CUserMessage',
  id: BigInt.parse('-5236260095734839382').toInt(),
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
      enumMap: _CUserMessagechannelTypeEnumValueMap,
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
      enumMap: _CUserMessagementionTypeEnumValueMap,
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
    r'messageId': PropertySchema(
      id: 14,
      name: r'messageId',
      type: IsarType.long,
    ),
    r'messageSurvivalSeconds': PropertySchema(
      id: 15,
      name: r'messageSurvivalSeconds',
      type: IsarType.long,
    ),
    r'messageType': PropertySchema(
      id: 16,
      name: r'messageType',
      type: IsarType.byte,
      enumMap: _CUserMessagemessageTypeEnumValueMap,
    ),
    r'ogMetaData': PropertySchema(
      id: 17,
      name: r'ogMetaData',
      type: IsarType.object,
      target: r'COGMetaData',
    ),
    r'parentMessageId': PropertySchema(
      id: 18,
      name: r'parentMessageId',
      type: IsarType.long,
    ),
    r'parentMessageRootId': PropertySchema(
      id: 19,
      name: r'parentMessageRootId',
      type: IsarType.string,
    ),
    r'parentMessageType': PropertySchema(
      id: 20,
      name: r'parentMessageType',
      type: IsarType.byte,
      enumMap: _CUserMessageparentMessageTypeEnumValueMap,
    ),
    r'poll': PropertySchema(
      id: 21,
      name: r'poll',
      type: IsarType.object,
      target: r'CPoll',
    ),
    r'reactions': PropertySchema(
      id: 22,
      name: r'reactions',
      type: IsarType.objectList,
      target: r'CReaction',
    ),
    r'requestId': PropertySchema(
      id: 23,
      name: r'requestId',
      type: IsarType.string,
    ),
    r'rootId': PropertySchema(
      id: 24,
      name: r'rootId',
      type: IsarType.string,
    ),
    r'scheduledInfo': PropertySchema(
      id: 25,
      name: r'scheduledInfo',
      type: IsarType.object,
      target: r'CScheduledInfo',
    ),
    r'sender': PropertySchema(
      id: 26,
      name: r'sender',
      type: IsarType.object,
      target: r'CSender',
    ),
    r'sendingStatus': PropertySchema(
      id: 27,
      name: r'sendingStatus',
      type: IsarType.byte,
      enumMap: _CUserMessagesendingStatusEnumValueMap,
    ),
    r'threadInfo': PropertySchema(
      id: 28,
      name: r'threadInfo',
      type: IsarType.object,
      target: r'CThreadInfo',
    ),
    r'translationTargetLanguages': PropertySchema(
      id: 29,
      name: r'translationTargetLanguages',
      type: IsarType.stringList,
    ),
    r'translations': PropertySchema(
      id: 30,
      name: r'translations',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 31,
      name: r'updatedAt',
      type: IsarType.long,
    )
  },
  estimateSize: _cUserMessageEstimateSize,
  serialize: _cUserMessageSerialize,
  deserialize: _cUserMessageDeserialize,
  deserializeProp: _cUserMessageDeserializeProp,
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
    r'CPoll': CPollSchema,
    r'CPollData': CPollDataSchema,
    r'CPollOption': CPollOptionSchema,
    r'CThreadInfo': CThreadInfoSchema,
    r'COGMetaData': COGMetaDataSchema,
    r'COGImage': COGImageSchema,
    r'CReaction': CReactionSchema,
    r'CScheduledInfo': CScheduledInfoSchema,
    r'CSender': CSenderSchema,
    r'CMessageMetaArray': CMessageMetaArraySchema
  },
  getId: _cUserMessageGetId,
  getLinks: _cUserMessageGetLinks,
  attach: _cUserMessageAttach,
  version: '3.1.0+1',
);

int _cUserMessageEstimateSize(
  CUserMessage object,
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
    final value = object.poll;
    if (value != null) {
      bytesCount +=
          3 + CPollSchema.estimateSize(value, allOffsets[CPoll]!, allOffsets);
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
    final list = object.translationTargetLanguages;
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
  bytesCount += 3 + object.translations.length * 3;
  return bytesCount;
}

void _cUserMessageSerialize(
  CUserMessage object,
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
  writer.writeLong(offsets[14], object.messageId);
  writer.writeLong(offsets[15], object.messageSurvivalSeconds);
  writer.writeByte(offsets[16], object.messageType.index);
  writer.writeObject<COGMetaData>(
    offsets[17],
    allOffsets,
    COGMetaDataSchema.serialize,
    object.ogMetaData,
  );
  writer.writeLong(offsets[18], object.parentMessageId);
  writer.writeString(offsets[19], object.parentMessageRootId);
  writer.writeByte(offsets[20], object.parentMessageType.index);
  writer.writeObject<CPoll>(
    offsets[21],
    allOffsets,
    CPollSchema.serialize,
    object.poll,
  );
  writer.writeObjectList<CReaction>(
    offsets[22],
    allOffsets,
    CReactionSchema.serialize,
    object.reactions,
  );
  writer.writeString(offsets[23], object.requestId);
  writer.writeString(offsets[24], object.rootId);
  writer.writeObject<CScheduledInfo>(
    offsets[25],
    allOffsets,
    CScheduledInfoSchema.serialize,
    object.scheduledInfo,
  );
  writer.writeObject<CSender>(
    offsets[26],
    allOffsets,
    CSenderSchema.serialize,
    object.sender,
  );
  writer.writeByte(offsets[27], object.sendingStatus.index);
  writer.writeObject<CThreadInfo>(
    offsets[28],
    allOffsets,
    CThreadInfoSchema.serialize,
    object.threadInfo,
  );
  writer.writeStringList(offsets[29], object.translationTargetLanguages);
  writer.writeString(offsets[30], object.translations);
  writer.writeLong(offsets[31], object.updatedAt);
}

CUserMessage _cUserMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CUserMessage();
  object.allMetaArrays = reader.readObjectList<CMessageMetaArray>(
    offsets[0],
    CMessageMetaArraySchema.deserialize,
    allOffsets,
    CMessageMetaArray(),
  );
  object.channelType =
      _CUserMessagechannelTypeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
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
  object.mentionType = _CUserMessagementionTypeValueEnumMap[
          reader.readByteOrNull(offsets[11])] ??
      MentionType.users;
  object.mentionedUsers = reader.readStringList(offsets[12]) ?? [];
  object.message = reader.readString(offsets[13]);
  object.messageId = reader.readLong(offsets[14]);
  object.messageSurvivalSeconds = reader.readLongOrNull(offsets[15]);
  object.messageType = _CUserMessagemessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[16])] ??
      MessageType.user;
  object.ogMetaData = reader.readObjectOrNull<COGMetaData>(
    offsets[17],
    COGMetaDataSchema.deserialize,
    allOffsets,
  );
  object.parentMessageId = reader.readLongOrNull(offsets[18]);
  object.parentMessageRootId = reader.readStringOrNull(offsets[19]);
  object.parentMessageType = _CUserMessageparentMessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[20])] ??
      MessageType.user;
  object.poll = reader.readObjectOrNull<CPoll>(
    offsets[21],
    CPollSchema.deserialize,
    allOffsets,
  );
  object.reactions = reader.readObjectList<CReaction>(
    offsets[22],
    CReactionSchema.deserialize,
    allOffsets,
    CReaction(),
  );
  object.requestId = reader.readStringOrNull(offsets[23]);
  object.rootId = reader.readString(offsets[24]);
  object.scheduledInfo = reader.readObjectOrNull<CScheduledInfo>(
    offsets[25],
    CScheduledInfoSchema.deserialize,
    allOffsets,
  );
  object.sender = reader.readObjectOrNull<CSender>(
    offsets[26],
    CSenderSchema.deserialize,
    allOffsets,
  );
  object.sendingStatus = _CUserMessagesendingStatusValueEnumMap[
          reader.readByteOrNull(offsets[27])] ??
      SendingStatus.none;
  object.threadInfo = reader.readObjectOrNull<CThreadInfo>(
    offsets[28],
    CThreadInfoSchema.deserialize,
    allOffsets,
  );
  object.translationTargetLanguages = reader.readStringList(offsets[29]);
  object.translations = reader.readString(offsets[30]);
  object.updatedAt = reader.readLong(offsets[31]);
  return object;
}

P _cUserMessageDeserializeProp<P>(
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
      return (_CUserMessagechannelTypeValueEnumMap[
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
      return (_CUserMessagementionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MentionType.users) as P;
    case 12:
      return (reader.readStringList(offset) ?? []) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (_CUserMessagemessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 17:
      return (reader.readObjectOrNull<COGMetaData>(
        offset,
        COGMetaDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (_CUserMessageparentMessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 21:
      return (reader.readObjectOrNull<CPoll>(
        offset,
        CPollSchema.deserialize,
        allOffsets,
      )) as P;
    case 22:
      return (reader.readObjectList<CReaction>(
        offset,
        CReactionSchema.deserialize,
        allOffsets,
        CReaction(),
      )) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readObjectOrNull<CScheduledInfo>(
        offset,
        CScheduledInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 26:
      return (reader.readObjectOrNull<CSender>(
        offset,
        CSenderSchema.deserialize,
        allOffsets,
      )) as P;
    case 27:
      return (_CUserMessagesendingStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SendingStatus.none) as P;
    case 28:
      return (reader.readObjectOrNull<CThreadInfo>(
        offset,
        CThreadInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 29:
      return (reader.readStringList(offset)) as P;
    case 30:
      return (reader.readString(offset)) as P;
    case 31:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CUserMessagechannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CUserMessagechannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};
const _CUserMessagementionTypeEnumValueMap = {
  'users': 0,
  'channel': 1,
};
const _CUserMessagementionTypeValueEnumMap = {
  0: MentionType.users,
  1: MentionType.channel,
};
const _CUserMessagemessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CUserMessagemessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CUserMessageparentMessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CUserMessageparentMessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CUserMessagesendingStatusEnumValueMap = {
  'none': 0,
  'pending': 1,
  'failed': 2,
  'succeeded': 3,
  'canceled': 4,
};
const _CUserMessagesendingStatusValueEnumMap = {
  0: SendingStatus.none,
  1: SendingStatus.pending,
  2: SendingStatus.failed,
  3: SendingStatus.succeeded,
  4: SendingStatus.canceled,
};

Id _cUserMessageGetId(CUserMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cUserMessageGetLinks(CUserMessage object) {
  return [];
}

void _cUserMessageAttach(
    IsarCollection<dynamic> col, Id id, CUserMessage object) {
  object.id = id;
}

extension CUserMessageByIndex on IsarCollection<CUserMessage> {
  Future<CUserMessage?> getByRootId(String rootId) {
    return getByIndex(r'rootId', [rootId]);
  }

  CUserMessage? getByRootIdSync(String rootId) {
    return getByIndexSync(r'rootId', [rootId]);
  }

  Future<bool> deleteByRootId(String rootId) {
    return deleteByIndex(r'rootId', [rootId]);
  }

  bool deleteByRootIdSync(String rootId) {
    return deleteByIndexSync(r'rootId', [rootId]);
  }

  Future<List<CUserMessage?>> getAllByRootId(List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'rootId', values);
  }

  List<CUserMessage?> getAllByRootIdSync(List<String> rootIdValues) {
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

  Future<Id> putByRootId(CUserMessage object) {
    return putByIndex(r'rootId', object);
  }

  Id putByRootIdSync(CUserMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'rootId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRootId(List<CUserMessage> objects) {
    return putAllByIndex(r'rootId', objects);
  }

  List<Id> putAllByRootIdSync(List<CUserMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rootId', objects, saveLinks: saveLinks);
  }
}

extension CUserMessageQueryWhereSort
    on QueryBuilder<CUserMessage, CUserMessage, QWhere> {
  QueryBuilder<CUserMessage, CUserMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CUserMessageQueryWhere
    on QueryBuilder<CUserMessage, CUserMessage, QWhereClause> {
  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> idBetween(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> rootIdEqualTo(
      String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootId',
        value: [rootId],
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> rootIdNotEqualTo(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
      messageTypeEqualToAnyRootId(MessageType messageType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType],
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
      messageTypeRootIdEqualTo(MessageType messageType, String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType, rootId],
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause> channelUrlEqualTo(
      String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterWhereClause>
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

extension CUserMessageQueryFilter
    on QueryBuilder<CUserMessage, CUserMessage, QFilterCondition> {
  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      allMetaArraysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      allMetaArraysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> dataEqualTo(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> dataLessThan(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> dataBetween(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> dataEndsWith(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> dataContains(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> dataMatches(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      errorCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      errorCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      errorCodeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      extendedMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      extendedMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extendedMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      extendedMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      extendedMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      isOperatorMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOperatorMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      isReplyToChannelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReplyToChannel',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      isSilentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSilent',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      mentionTypeEqualTo(MentionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      mentionedUsersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      mentionedUsersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      mentionedUsersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageSurvivalSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageSurvivalSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageSurvivalSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageSurvivalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      ogMetaDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      ogMetaDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageRootIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageRootIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageRootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageRootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentMessageRootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageRootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageRootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      parentMessageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> pollIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'poll',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      pollIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'poll',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      reactionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      reactionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      requestIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      requestIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      requestIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      requestIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requestId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      requestIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      requestIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> rootIdEqualTo(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> rootIdBetween(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      rootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> rootIdMatches(
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      rootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      rootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      scheduledInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      scheduledInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      senderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      senderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      sendingStatusEqualTo(SendingStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sendingStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      threadInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      threadInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'translationTargetLanguages',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'translationTargetLanguages',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translationTargetLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'translationTargetLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'translationTargetLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'translationTargetLanguages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'translationTargetLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'translationTargetLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'translationTargetLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'translationTargetLanguages',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translationTargetLanguages',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'translationTargetLanguages',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'translationTargetLanguages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'translationTargetLanguages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'translationTargetLanguages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'translationTargetLanguages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'translationTargetLanguages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationTargetLanguagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'translationTargetLanguages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'translations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'translations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'translations',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'translations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'translations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'translations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'translations',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translations',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      translationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'translations',
        value: '',
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      updatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
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
}

extension CUserMessageQueryObject
    on QueryBuilder<CUserMessage, CUserMessage, QFilterCondition> {
  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      allMetaArraysElement(FilterQuery<CMessageMetaArray> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allMetaArrays');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> ogMetaData(
      FilterQuery<COGMetaData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ogMetaData');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> poll(
      FilterQuery<CPoll> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'poll');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition>
      reactionsElement(FilterQuery<CReaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reactions');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> scheduledInfo(
      FilterQuery<CScheduledInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'scheduledInfo');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> sender(
      FilterQuery<CSender> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sender');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterFilterCondition> threadInfo(
      FilterQuery<CThreadInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'threadInfo');
    });
  }
}

extension CUserMessageQueryLinks
    on QueryBuilder<CUserMessage, CUserMessage, QFilterCondition> {}

extension CUserMessageQuerySortBy
    on QueryBuilder<CUserMessage, CUserMessage, QSortBy> {
  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByTranslations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translations', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      sortByTranslationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translations', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CUserMessageQuerySortThenBy
    on QueryBuilder<CUserMessage, CUserMessage, QSortThenBy> {
  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByTranslations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translations', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy>
      thenByTranslationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translations', Sort.desc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CUserMessageQueryWhereDistinct
    on QueryBuilder<CUserMessage, CUserMessage, QDistinct> {
  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByChannelUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByCustomType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorCode');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByExtendedMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extendedMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOperatorMessage');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReplyToChannel');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSilent');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionType');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByMentionedUsers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionedUsers');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageId');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByParentMessageRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageRootId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageType');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByRequestId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requestId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByRootId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sendingStatus');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct>
      distinctByTranslationTargetLanguages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'translationTargetLanguages');
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByTranslations(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'translations', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUserMessage, CUserMessage, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CUserMessageQueryProperty
    on QueryBuilder<CUserMessage, CUserMessage, QQueryProperty> {
  QueryBuilder<CUserMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CUserMessage, List<CMessageMetaArray>?, QQueryOperations>
      allMetaArraysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allMetaArrays');
    });
  }

  QueryBuilder<CUserMessage, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CUserMessage, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CUserMessage, int, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CUserMessage, String?, QQueryOperations> customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CUserMessage, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CUserMessage, int?, QQueryOperations> errorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorCode');
    });
  }

  QueryBuilder<CUserMessage, String, QQueryOperations>
      extendedMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extendedMessage');
    });
  }

  QueryBuilder<CUserMessage, bool, QQueryOperations>
      isOperatorMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOperatorMessage');
    });
  }

  QueryBuilder<CUserMessage, bool, QQueryOperations>
      isReplyToChannelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReplyToChannel');
    });
  }

  QueryBuilder<CUserMessage, bool, QQueryOperations> isSilentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSilent');
    });
  }

  QueryBuilder<CUserMessage, MentionType, QQueryOperations>
      mentionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionType');
    });
  }

  QueryBuilder<CUserMessage, List<String>, QQueryOperations>
      mentionedUsersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionedUsers');
    });
  }

  QueryBuilder<CUserMessage, String, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<CUserMessage, int, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<CUserMessage, int?, QQueryOperations>
      messageSurvivalSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CUserMessage, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<CUserMessage, COGMetaData?, QQueryOperations>
      ogMetaDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ogMetaData');
    });
  }

  QueryBuilder<CUserMessage, int?, QQueryOperations> parentMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageId');
    });
  }

  QueryBuilder<CUserMessage, String?, QQueryOperations>
      parentMessageRootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageRootId');
    });
  }

  QueryBuilder<CUserMessage, MessageType, QQueryOperations>
      parentMessageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageType');
    });
  }

  QueryBuilder<CUserMessage, CPoll?, QQueryOperations> pollProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poll');
    });
  }

  QueryBuilder<CUserMessage, List<CReaction>?, QQueryOperations>
      reactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reactions');
    });
  }

  QueryBuilder<CUserMessage, String?, QQueryOperations> requestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requestId');
    });
  }

  QueryBuilder<CUserMessage, String, QQueryOperations> rootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootId');
    });
  }

  QueryBuilder<CUserMessage, CScheduledInfo?, QQueryOperations>
      scheduledInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledInfo');
    });
  }

  QueryBuilder<CUserMessage, CSender?, QQueryOperations> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sender');
    });
  }

  QueryBuilder<CUserMessage, SendingStatus, QQueryOperations>
      sendingStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sendingStatus');
    });
  }

  QueryBuilder<CUserMessage, CThreadInfo?, QQueryOperations>
      threadInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'threadInfo');
    });
  }

  QueryBuilder<CUserMessage, List<String>?, QQueryOperations>
      translationTargetLanguagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translationTargetLanguages');
    });
  }

  QueryBuilder<CUserMessage, String, QQueryOperations> translationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translations');
    });
  }

  QueryBuilder<CUserMessage, int, QQueryOperations> updatedAtProperty() {
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

final CPollSchema = Schema(
  name: r'CPoll',
  id: BigInt.parse('-6002142452581641545').toInt(),
  properties: {
    r'allowMultipleVotes': PropertySchema(
      id: 0,
      name: r'allowMultipleVotes',
      type: IsarType.bool,
    ),
    r'allowUserSuggestion': PropertySchema(
      id: 1,
      name: r'allowUserSuggestion',
      type: IsarType.bool,
    ),
    r'closeAt': PropertySchema(
      id: 2,
      name: r'closeAt',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.long,
    ),
    r'createdBy': PropertySchema(
      id: 4,
      name: r'createdBy',
      type: IsarType.string,
    ),
    r'data': PropertySchema(
      id: 5,
      name: r'data',
      type: IsarType.object,
      target: r'CPollData',
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.long,
    ),
    r'messageId': PropertySchema(
      id: 7,
      name: r'messageId',
      type: IsarType.long,
    ),
    r'options': PropertySchema(
      id: 8,
      name: r'options',
      type: IsarType.objectList,
      target: r'CPollOption',
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.byte,
      enumMap: _CPollstatusEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 10,
      name: r'title',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 11,
      name: r'updatedAt',
      type: IsarType.long,
    ),
    r'votedPollOptionIds': PropertySchema(
      id: 12,
      name: r'votedPollOptionIds',
      type: IsarType.longList,
    ),
    r'voterCount': PropertySchema(
      id: 13,
      name: r'voterCount',
      type: IsarType.long,
    )
  },
  estimateSize: _cPollEstimateSize,
  serialize: _cPollSerialize,
  deserialize: _cPollDeserialize,
  deserializeProp: _cPollDeserializeProp,
);

int _cPollEstimateSize(
  CPoll object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.createdBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.data;
    if (value != null) {
      bytesCount += 3 +
          CPollDataSchema.estimateSize(
              value, allOffsets[CPollData]!, allOffsets);
    }
  }
  bytesCount += 3 + object.options.length * 3;
  {
    final offsets = allOffsets[CPollOption]!;
    for (var i = 0; i < object.options.length; i++) {
      final value = object.options[i];
      bytesCount += CPollOptionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.title.length * 3;
  {
    final value = object.votedPollOptionIds;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _cPollSerialize(
  CPoll object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.allowMultipleVotes);
  writer.writeBool(offsets[1], object.allowUserSuggestion);
  writer.writeLong(offsets[2], object.closeAt);
  writer.writeLong(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.createdBy);
  writer.writeObject<CPollData>(
    offsets[5],
    allOffsets,
    CPollDataSchema.serialize,
    object.data,
  );
  writer.writeLong(offsets[6], object.id);
  writer.writeLong(offsets[7], object.messageId);
  writer.writeObjectList<CPollOption>(
    offsets[8],
    allOffsets,
    CPollOptionSchema.serialize,
    object.options,
  );
  writer.writeByte(offsets[9], object.status.index);
  writer.writeString(offsets[10], object.title);
  writer.writeLong(offsets[11], object.updatedAt);
  writer.writeLongList(offsets[12], object.votedPollOptionIds);
  writer.writeLong(offsets[13], object.voterCount);
}

CPoll _cPollDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CPoll();
  object.allowMultipleVotes = reader.readBool(offsets[0]);
  object.allowUserSuggestion = reader.readBool(offsets[1]);
  object.closeAt = reader.readLong(offsets[2]);
  object.createdAt = reader.readLong(offsets[3]);
  object.createdBy = reader.readStringOrNull(offsets[4]);
  object.data = reader.readObjectOrNull<CPollData>(
    offsets[5],
    CPollDataSchema.deserialize,
    allOffsets,
  );
  object.id = reader.readLong(offsets[6]);
  object.messageId = reader.readLongOrNull(offsets[7]);
  object.options = reader.readObjectList<CPollOption>(
        offsets[8],
        CPollOptionSchema.deserialize,
        allOffsets,
        CPollOption(),
      ) ??
      [];
  object.status = _CPollstatusValueEnumMap[reader.readByteOrNull(offsets[9])] ??
      PollStatus.open;
  object.title = reader.readString(offsets[10]);
  object.updatedAt = reader.readLong(offsets[11]);
  object.votedPollOptionIds = reader.readLongList(offsets[12]);
  object.voterCount = reader.readLong(offsets[13]);
  return object;
}

P _cPollDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<CPollData>(
        offset,
        CPollDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readObjectList<CPollOption>(
            offset,
            CPollOptionSchema.deserialize,
            allOffsets,
            CPollOption(),
          ) ??
          []) as P;
    case 9:
      return (_CPollstatusValueEnumMap[reader.readByteOrNull(offset)] ??
          PollStatus.open) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLongList(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CPollstatusEnumValueMap = {
  'open': 0,
  'closed': 1,
};
const _CPollstatusValueEnumMap = {
  0: PollStatus.open,
  1: PollStatus.closed,
};

extension CPollQueryFilter on QueryBuilder<CPoll, CPoll, QFilterCondition> {
  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> allowMultipleVotesEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowMultipleVotes',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> allowUserSuggestionEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowUserSuggestion',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> closeAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'closeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> closeAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'closeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> closeAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'closeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> closeAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'closeAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdAtEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdBy',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdBy',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> createdByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> idGreaterThan(
    int value, {
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> idLessThan(
    int value, {
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> messageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> messageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> messageIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> messageIdGreaterThan(
    int? value, {
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> messageIdLessThan(
    int? value, {
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> messageIdBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> optionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> optionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> optionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> optionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> optionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> optionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> statusEqualTo(
      PollStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> statusGreaterThan(
    PollStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> statusLessThan(
    PollStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> statusBetween(
    PollStatus lower,
    PollStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> updatedAtEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> votedPollOptionIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'votedPollOptionIds',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'votedPollOptionIds',
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'votedPollOptionIds',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'votedPollOptionIds',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'votedPollOptionIds',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'votedPollOptionIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'votedPollOptionIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'votedPollOptionIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'votedPollOptionIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'votedPollOptionIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'votedPollOptionIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition>
      votedPollOptionIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'votedPollOptionIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> voterCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voterCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> voterCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voterCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> voterCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voterCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> voterCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voterCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CPollQueryObject on QueryBuilder<CPoll, CPoll, QFilterCondition> {
  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> data(
      FilterQuery<CPollData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'data');
    });
  }

  QueryBuilder<CPoll, CPoll, QAfterFilterCondition> optionsElement(
      FilterQuery<CPollOption> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'options');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CPollDataSchema = Schema(
  name: r'CPollData',
  id: BigInt.parse('213822990569344781').toInt(),
  properties: {
    r'text': PropertySchema(
      id: 0,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _cPollDataEstimateSize,
  serialize: _cPollDataSerialize,
  deserialize: _cPollDataDeserialize,
  deserializeProp: _cPollDataDeserializeProp,
);

int _cPollDataEstimateSize(
  CPollData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _cPollDataSerialize(
  CPollData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.text);
}

CPollData _cPollDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CPollData();
  object.text = reader.readString(offsets[0]);
  return object;
}

P _cPollDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CPollDataQueryFilter
    on QueryBuilder<CPollData, CPollData, QFilterCondition> {
  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<CPollData, CPollData, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension CPollDataQueryObject
    on QueryBuilder<CPollData, CPollData, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CPollOptionSchema = Schema(
  name: r'CPollOption',
  id: BigInt.parse('-1226183442370331930').toInt(),
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.long,
    ),
    r'createdBy': PropertySchema(
      id: 1,
      name: r'createdBy',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.long,
    ),
    r'pollId': PropertySchema(
      id: 3,
      name: r'pollId',
      type: IsarType.long,
    ),
    r'text': PropertySchema(
      id: 4,
      name: r'text',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.long,
    ),
    r'voteCount': PropertySchema(
      id: 6,
      name: r'voteCount',
      type: IsarType.long,
    )
  },
  estimateSize: _cPollOptionEstimateSize,
  serialize: _cPollOptionSerialize,
  deserialize: _cPollOptionDeserialize,
  deserializeProp: _cPollOptionDeserializeProp,
);

int _cPollOptionEstimateSize(
  CPollOption object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.createdBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _cPollOptionSerialize(
  CPollOption object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.createdBy);
  writer.writeLong(offsets[2], object.id);
  writer.writeLong(offsets[3], object.pollId);
  writer.writeString(offsets[4], object.text);
  writer.writeLong(offsets[5], object.updatedAt);
  writer.writeLong(offsets[6], object.voteCount);
}

CPollOption _cPollOptionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CPollOption();
  object.createdAt = reader.readLong(offsets[0]);
  object.createdBy = reader.readStringOrNull(offsets[1]);
  object.id = reader.readLong(offsets[2]);
  object.pollId = reader.readLong(offsets[3]);
  object.text = reader.readString(offsets[4]);
  object.updatedAt = reader.readLong(offsets[5]);
  object.voteCount = reader.readLong(offsets[6]);
  return object;
}

P _cPollOptionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CPollOptionQueryFilter
    on QueryBuilder<CPollOption, CPollOption, QFilterCondition> {
  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdBy',
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdBy',
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      createdByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> idGreaterThan(
    int value, {
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> idLessThan(
    int value, {
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> pollIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pollId',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      pollIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pollId',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> pollIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pollId',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> pollIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pollId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      updatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
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

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      voteCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voteCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      voteCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voteCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      voteCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voteCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CPollOption, CPollOption, QAfterFilterCondition>
      voteCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voteCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CPollOptionQueryObject
    on QueryBuilder<CPollOption, CPollOption, QFilterCondition> {}
