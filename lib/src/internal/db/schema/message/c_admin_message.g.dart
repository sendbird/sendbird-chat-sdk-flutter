// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_admin_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCAdminMessageCollection on Isar {
  IsarCollection<CAdminMessage> get cAdminMessages => this.collection();
}

final CAdminMessageSchema = CollectionSchema(
  name: r'CAdminMessage',
  id: BigInt.parse('-4690870483801023253').toInt(),
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
      enumMap: _CAdminMessagechannelTypeEnumValueMap,
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
      enumMap: _CAdminMessagementionTypeEnumValueMap,
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
      enumMap: _CAdminMessagemessageTypeEnumValueMap,
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
      enumMap: _CAdminMessageparentMessageTypeEnumValueMap,
    ),
    r'reactions': PropertySchema(
      id: 21,
      name: r'reactions',
      type: IsarType.objectList,
      target: r'CReaction',
    ),
    r'requestId': PropertySchema(
      id: 22,
      name: r'requestId',
      type: IsarType.string,
    ),
    r'rootId': PropertySchema(
      id: 23,
      name: r'rootId',
      type: IsarType.string,
    ),
    r'scheduledInfo': PropertySchema(
      id: 24,
      name: r'scheduledInfo',
      type: IsarType.object,
      target: r'CScheduledInfo',
    ),
    r'sender': PropertySchema(
      id: 25,
      name: r'sender',
      type: IsarType.object,
      target: r'CSender',
    ),
    r'sendingStatus': PropertySchema(
      id: 26,
      name: r'sendingStatus',
      type: IsarType.byte,
      enumMap: _CAdminMessagesendingStatusEnumValueMap,
    ),
    r'threadInfo': PropertySchema(
      id: 27,
      name: r'threadInfo',
      type: IsarType.object,
      target: r'CThreadInfo',
    ),
    r'updatedAt': PropertySchema(
      id: 28,
      name: r'updatedAt',
      type: IsarType.long,
    )
  },
  estimateSize: _cAdminMessageEstimateSize,
  serialize: _cAdminMessageSerialize,
  deserialize: _cAdminMessageDeserialize,
  deserializeProp: _cAdminMessageDeserializeProp,
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
    r'CThreadInfo': CThreadInfoSchema,
    r'COGMetaData': COGMetaDataSchema,
    r'COGImage': COGImageSchema,
    r'CReaction': CReactionSchema,
    r'CScheduledInfo': CScheduledInfoSchema,
    r'CSender': CSenderSchema,
    r'CMessageMetaArray': CMessageMetaArraySchema
  },
  getId: _cAdminMessageGetId,
  getLinks: _cAdminMessageGetLinks,
  attach: _cAdminMessageAttach,
  version: '3.1.0+1',
);

int _cAdminMessageEstimateSize(
  CAdminMessage object,
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

void _cAdminMessageSerialize(
  CAdminMessage object,
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
  writer.writeObjectList<CReaction>(
    offsets[21],
    allOffsets,
    CReactionSchema.serialize,
    object.reactions,
  );
  writer.writeString(offsets[22], object.requestId);
  writer.writeString(offsets[23], object.rootId);
  writer.writeObject<CScheduledInfo>(
    offsets[24],
    allOffsets,
    CScheduledInfoSchema.serialize,
    object.scheduledInfo,
  );
  writer.writeObject<CSender>(
    offsets[25],
    allOffsets,
    CSenderSchema.serialize,
    object.sender,
  );
  writer.writeByte(offsets[26], object.sendingStatus.index);
  writer.writeObject<CThreadInfo>(
    offsets[27],
    allOffsets,
    CThreadInfoSchema.serialize,
    object.threadInfo,
  );
  writer.writeLong(offsets[28], object.updatedAt);
}

CAdminMessage _cAdminMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CAdminMessage();
  object.allMetaArrays = reader.readObjectList<CMessageMetaArray>(
    offsets[0],
    CMessageMetaArraySchema.deserialize,
    allOffsets,
    CMessageMetaArray(),
  );
  object.channelType = _CAdminMessagechannelTypeValueEnumMap[
          reader.readByteOrNull(offsets[1])] ??
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
  object.mentionType = _CAdminMessagementionTypeValueEnumMap[
          reader.readByteOrNull(offsets[11])] ??
      MentionType.users;
  object.mentionedUsers = reader.readStringList(offsets[12]) ?? [];
  object.message = reader.readString(offsets[13]);
  object.messageId = reader.readLong(offsets[14]);
  object.messageSurvivalSeconds = reader.readLongOrNull(offsets[15]);
  object.messageType = _CAdminMessagemessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[16])] ??
      MessageType.user;
  object.ogMetaData = reader.readObjectOrNull<COGMetaData>(
    offsets[17],
    COGMetaDataSchema.deserialize,
    allOffsets,
  );
  object.parentMessageId = reader.readLongOrNull(offsets[18]);
  object.parentMessageRootId = reader.readStringOrNull(offsets[19]);
  object.parentMessageType = _CAdminMessageparentMessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[20])] ??
      MessageType.user;
  object.reactions = reader.readObjectList<CReaction>(
    offsets[21],
    CReactionSchema.deserialize,
    allOffsets,
    CReaction(),
  );
  object.requestId = reader.readStringOrNull(offsets[22]);
  object.rootId = reader.readString(offsets[23]);
  object.scheduledInfo = reader.readObjectOrNull<CScheduledInfo>(
    offsets[24],
    CScheduledInfoSchema.deserialize,
    allOffsets,
  );
  object.sender = reader.readObjectOrNull<CSender>(
    offsets[25],
    CSenderSchema.deserialize,
    allOffsets,
  );
  object.sendingStatus = _CAdminMessagesendingStatusValueEnumMap[
          reader.readByteOrNull(offsets[26])] ??
      SendingStatus.none;
  object.threadInfo = reader.readObjectOrNull<CThreadInfo>(
    offsets[27],
    CThreadInfoSchema.deserialize,
    allOffsets,
  );
  object.updatedAt = reader.readLong(offsets[28]);
  return object;
}

P _cAdminMessageDeserializeProp<P>(
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
      return (_CAdminMessagechannelTypeValueEnumMap[
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
      return (_CAdminMessagementionTypeValueEnumMap[
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
      return (_CAdminMessagemessageTypeValueEnumMap[
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
      return (_CAdminMessageparentMessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 21:
      return (reader.readObjectList<CReaction>(
        offset,
        CReactionSchema.deserialize,
        allOffsets,
        CReaction(),
      )) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readObjectOrNull<CScheduledInfo>(
        offset,
        CScheduledInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 25:
      return (reader.readObjectOrNull<CSender>(
        offset,
        CSenderSchema.deserialize,
        allOffsets,
      )) as P;
    case 26:
      return (_CAdminMessagesendingStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SendingStatus.none) as P;
    case 27:
      return (reader.readObjectOrNull<CThreadInfo>(
        offset,
        CThreadInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 28:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CAdminMessagechannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CAdminMessagechannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};
const _CAdminMessagementionTypeEnumValueMap = {
  'users': 0,
  'channel': 1,
};
const _CAdminMessagementionTypeValueEnumMap = {
  0: MentionType.users,
  1: MentionType.channel,
};
const _CAdminMessagemessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CAdminMessagemessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CAdminMessageparentMessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CAdminMessageparentMessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CAdminMessagesendingStatusEnumValueMap = {
  'none': 0,
  'pending': 1,
  'failed': 2,
  'succeeded': 3,
  'canceled': 4,
};
const _CAdminMessagesendingStatusValueEnumMap = {
  0: SendingStatus.none,
  1: SendingStatus.pending,
  2: SendingStatus.failed,
  3: SendingStatus.succeeded,
  4: SendingStatus.canceled,
};

Id _cAdminMessageGetId(CAdminMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cAdminMessageGetLinks(CAdminMessage object) {
  return [];
}

void _cAdminMessageAttach(
    IsarCollection<dynamic> col, Id id, CAdminMessage object) {
  object.id = id;
}

extension CAdminMessageByIndex on IsarCollection<CAdminMessage> {
  Future<CAdminMessage?> getByRootId(String rootId) {
    return getByIndex(r'rootId', [rootId]);
  }

  CAdminMessage? getByRootIdSync(String rootId) {
    return getByIndexSync(r'rootId', [rootId]);
  }

  Future<bool> deleteByRootId(String rootId) {
    return deleteByIndex(r'rootId', [rootId]);
  }

  bool deleteByRootIdSync(String rootId) {
    return deleteByIndexSync(r'rootId', [rootId]);
  }

  Future<List<CAdminMessage?>> getAllByRootId(List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'rootId', values);
  }

  List<CAdminMessage?> getAllByRootIdSync(List<String> rootIdValues) {
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

  Future<Id> putByRootId(CAdminMessage object) {
    return putByIndex(r'rootId', object);
  }

  Id putByRootIdSync(CAdminMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'rootId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRootId(List<CAdminMessage> objects) {
    return putAllByIndex(r'rootId', objects);
  }

  List<Id> putAllByRootIdSync(List<CAdminMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rootId', objects, saveLinks: saveLinks);
  }
}

extension CAdminMessageQueryWhereSort
    on QueryBuilder<CAdminMessage, CAdminMessage, QWhere> {
  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CAdminMessageQueryWhere
    on QueryBuilder<CAdminMessage, CAdminMessage, QWhereClause> {
  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause> idBetween(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause> rootIdEqualTo(
      String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootId',
        value: [rootId],
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
      messageTypeEqualToAnyRootId(MessageType messageType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType],
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
      messageTypeRootIdEqualTo(MessageType messageType, String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType, rootId],
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterWhereClause>
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

extension CAdminMessageQueryFilter
    on QueryBuilder<CAdminMessage, CAdminMessage, QFilterCondition> {
  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      allMetaArraysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      allMetaArraysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> dataEqualTo(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> dataBetween(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      dataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> dataMatches(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      errorCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      errorCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorCode',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      errorCodeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      extendedMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extendedMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      extendedMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extendedMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      extendedMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      extendedMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      isOperatorMessageEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOperatorMessage',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      isReplyToChannelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReplyToChannel',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      isSilentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSilent',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      mentionTypeEqualTo(MentionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      mentionedUsersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mentionedUsers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      mentionedUsersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      mentionedUsersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageSurvivalSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageSurvivalSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageSurvivalSeconds',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageSurvivalSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageSurvivalSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      ogMetaDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      ogMetaDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ogMetaData',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageId',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageId',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageRootIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageRootIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentMessageRootId',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageRootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageRootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentMessageRootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageRootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageRootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      parentMessageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentMessageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      reactionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      reactionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reactions',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      requestIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      requestIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requestId',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      requestIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requestId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      requestIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requestId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      requestIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      requestIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requestId',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      rootIdEqualTo(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      rootIdBetween(
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      rootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      rootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      rootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      rootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      scheduledInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      scheduledInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduledInfo',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      senderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      senderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sender',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      sendingStatusEqualTo(SendingStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sendingStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      threadInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      threadInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'threadInfo',
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      updatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
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

extension CAdminMessageQueryObject
    on QueryBuilder<CAdminMessage, CAdminMessage, QFilterCondition> {
  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      allMetaArraysElement(FilterQuery<CMessageMetaArray> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allMetaArrays');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> ogMetaData(
      FilterQuery<COGMetaData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ogMetaData');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      reactionsElement(FilterQuery<CReaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reactions');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition>
      scheduledInfo(FilterQuery<CScheduledInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'scheduledInfo');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> sender(
      FilterQuery<CSender> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sender');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterFilterCondition> threadInfo(
      FilterQuery<CThreadInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'threadInfo');
    });
  }
}

extension CAdminMessageQueryLinks
    on QueryBuilder<CAdminMessage, CAdminMessage, QFilterCondition> {}

extension CAdminMessageQuerySortBy
    on QueryBuilder<CAdminMessage, CAdminMessage, QSortBy> {
  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CAdminMessageQuerySortThenBy
    on QueryBuilder<CAdminMessage, CAdminMessage, QSortThenBy> {
  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByErrorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorCode', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByIsOperatorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOperatorMessage', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByIsReplyToChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReplyToChannel', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByIsSilentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSilent', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByMessageSurvivalSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageSurvivalSeconds', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByParentMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByParentMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByParentMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByParentMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentMessageType', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByRequestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByRequestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CAdminMessageQueryWhereDistinct
    on QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> {
  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByChannelUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByCustomType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByErrorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorCode');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByExtendedMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extendedMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByIsOperatorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOperatorMessage');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByIsReplyToChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReplyToChannel');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByIsSilent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSilent');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionType');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByMentionedUsers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionedUsers');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByMessageSurvivalSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByParentMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageId');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByParentMessageRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageRootId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctByParentMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentMessageType');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByRequestId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requestId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByRootId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct>
      distinctBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sendingStatus');
    });
  }

  QueryBuilder<CAdminMessage, CAdminMessage, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CAdminMessageQueryProperty
    on QueryBuilder<CAdminMessage, CAdminMessage, QQueryProperty> {
  QueryBuilder<CAdminMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CAdminMessage, List<CMessageMetaArray>?, QQueryOperations>
      allMetaArraysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allMetaArrays');
    });
  }

  QueryBuilder<CAdminMessage, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CAdminMessage, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CAdminMessage, int, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CAdminMessage, String?, QQueryOperations> customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CAdminMessage, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CAdminMessage, int?, QQueryOperations> errorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorCode');
    });
  }

  QueryBuilder<CAdminMessage, String, QQueryOperations>
      extendedMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extendedMessage');
    });
  }

  QueryBuilder<CAdminMessage, bool, QQueryOperations>
      isOperatorMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOperatorMessage');
    });
  }

  QueryBuilder<CAdminMessage, bool, QQueryOperations>
      isReplyToChannelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReplyToChannel');
    });
  }

  QueryBuilder<CAdminMessage, bool, QQueryOperations> isSilentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSilent');
    });
  }

  QueryBuilder<CAdminMessage, MentionType, QQueryOperations>
      mentionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionType');
    });
  }

  QueryBuilder<CAdminMessage, List<String>, QQueryOperations>
      mentionedUsersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionedUsers');
    });
  }

  QueryBuilder<CAdminMessage, String, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<CAdminMessage, int, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<CAdminMessage, int?, QQueryOperations>
      messageSurvivalSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageSurvivalSeconds');
    });
  }

  QueryBuilder<CAdminMessage, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<CAdminMessage, COGMetaData?, QQueryOperations>
      ogMetaDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ogMetaData');
    });
  }

  QueryBuilder<CAdminMessage, int?, QQueryOperations>
      parentMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageId');
    });
  }

  QueryBuilder<CAdminMessage, String?, QQueryOperations>
      parentMessageRootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageRootId');
    });
  }

  QueryBuilder<CAdminMessage, MessageType, QQueryOperations>
      parentMessageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentMessageType');
    });
  }

  QueryBuilder<CAdminMessage, List<CReaction>?, QQueryOperations>
      reactionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reactions');
    });
  }

  QueryBuilder<CAdminMessage, String?, QQueryOperations> requestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requestId');
    });
  }

  QueryBuilder<CAdminMessage, String, QQueryOperations> rootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootId');
    });
  }

  QueryBuilder<CAdminMessage, CScheduledInfo?, QQueryOperations>
      scheduledInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledInfo');
    });
  }

  QueryBuilder<CAdminMessage, CSender?, QQueryOperations> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sender');
    });
  }

  QueryBuilder<CAdminMessage, SendingStatus, QQueryOperations>
      sendingStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sendingStatus');
    });
  }

  QueryBuilder<CAdminMessage, CThreadInfo?, QQueryOperations>
      threadInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'threadInfo');
    });
  }

  QueryBuilder<CAdminMessage, int, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
