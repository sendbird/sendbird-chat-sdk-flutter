// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_notification_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCNotificationMessageCollection on Isar {
  IsarCollection<CNotificationMessage> get cNotificationMessages =>
      this.collection();
}

final CNotificationMessageSchema = CollectionSchema(
  name: r'CNotificationMessage',
  id: BigInt.parse('916250674792986472').toInt(),
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
      enumMap: _CNotificationMessagechannelTypeEnumValueMap,
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
    r'extendedMessage': PropertySchema(
      id: 6,
      name: r'extendedMessage',
      type: IsarType.string,
    ),
    r'mentionType': PropertySchema(
      id: 7,
      name: r'mentionType',
      type: IsarType.byte,
      enumMap: _CNotificationMessagementionTypeEnumValueMap,
    ),
    r'mentionedUserIds': PropertySchema(
      id: 8,
      name: r'mentionedUserIds',
      type: IsarType.stringList,
    ),
    r'mentionedUsers': PropertySchema(
      id: 9,
      name: r'mentionedUsers',
      type: IsarType.stringList,
    ),
    r'messageStatus': PropertySchema(
      id: 10,
      name: r'messageStatus',
      type: IsarType.byte,
      enumMap: _CNotificationMessagemessageStatusEnumValueMap,
    ),
    r'messageType': PropertySchema(
      id: 11,
      name: r'messageType',
      type: IsarType.byte,
      enumMap: _CNotificationMessagemessageTypeEnumValueMap,
    ),
    r'notificationData': PropertySchema(
      id: 12,
      name: r'notificationData',
      type: IsarType.object,
      target: r'CNotificationData',
    ),
    r'notificationId': PropertySchema(
      id: 13,
      name: r'notificationId',
      type: IsarType.string,
    ),
    r'rootId': PropertySchema(
      id: 14,
      name: r'rootId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 15,
      name: r'updatedAt',
      type: IsarType.long,
    )
  },
  estimateSize: _cNotificationMessageEstimateSize,
  serialize: _cNotificationMessageSerialize,
  deserialize: _cNotificationMessageDeserialize,
  deserializeProp: _cNotificationMessageDeserializeProp,
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
    r'CNotificationData': CNotificationDataSchema,
    r'CMessageMetaArray': CMessageMetaArraySchema
  },
  getId: _cNotificationMessageGetId,
  getLinks: _cNotificationMessageGetLinks,
  attach: _cNotificationMessageAttach,
  version: '3.1.0+1',
);

int _cNotificationMessageEstimateSize(
  CNotificationMessage object,
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
  {
    final value = object.notificationData;
    if (value != null) {
      bytesCount += 3 +
          CNotificationDataSchema.estimateSize(
              value, allOffsets[CNotificationData]!, allOffsets);
    }
  }
  bytesCount += 3 + object.notificationId.length * 3;
  bytesCount += 3 + object.rootId.length * 3;
  return bytesCount;
}

void _cNotificationMessageSerialize(
  CNotificationMessage object,
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
  writer.writeString(offsets[6], object.extendedMessage);
  writer.writeByte(offsets[7], object.mentionType.index);
  writer.writeStringList(offsets[8], object.mentionedUserIds);
  writer.writeStringList(offsets[9], object.mentionedUsers);
  writer.writeByte(offsets[10], object.messageStatus.index);
  writer.writeByte(offsets[11], object.messageType.index);
  writer.writeObject<CNotificationData>(
    offsets[12],
    allOffsets,
    CNotificationDataSchema.serialize,
    object.notificationData,
  );
  writer.writeString(offsets[13], object.notificationId);
  writer.writeString(offsets[14], object.rootId);
  writer.writeLong(offsets[15], object.updatedAt);
}

CNotificationMessage _cNotificationMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CNotificationMessage();
  object.allMetaArrays = reader.readObjectList<CMessageMetaArray>(
    offsets[0],
    CMessageMetaArraySchema.deserialize,
    allOffsets,
    CMessageMetaArray(),
  );
  object.channelType = _CNotificationMessagechannelTypeValueEnumMap[
          reader.readByteOrNull(offsets[1])] ??
      ChannelType.group;
  object.channelUrl = reader.readString(offsets[2]);
  object.createdAt = reader.readLong(offsets[3]);
  object.customType = reader.readStringOrNull(offsets[4]);
  object.data = reader.readStringOrNull(offsets[5]);
  object.extendedMessage = reader.readString(offsets[6]);
  object.id = id;
  object.mentionType = _CNotificationMessagementionTypeValueEnumMap[
          reader.readByteOrNull(offsets[7])] ??
      MentionType.users;
  object.mentionedUserIds = reader.readStringList(offsets[8]) ?? [];
  object.mentionedUsers = reader.readStringList(offsets[9]) ?? [];
  object.messageStatus = _CNotificationMessagemessageStatusValueEnumMap[
          reader.readByteOrNull(offsets[10])] ??
      NotificationMessageStatus.sent;
  object.messageType = _CNotificationMessagemessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[11])] ??
      MessageType.user;
  object.notificationData = reader.readObjectOrNull<CNotificationData>(
    offsets[12],
    CNotificationDataSchema.deserialize,
    allOffsets,
  );
  object.notificationId = reader.readString(offsets[13]);
  object.rootId = reader.readString(offsets[14]);
  object.updatedAt = reader.readLong(offsets[15]);
  return object;
}

P _cNotificationMessageDeserializeProp<P>(
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
      return (_CNotificationMessagechannelTypeValueEnumMap[
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
      return (reader.readString(offset)) as P;
    case 7:
      return (_CNotificationMessagementionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MentionType.users) as P;
    case 8:
      return (reader.readStringList(offset) ?? []) as P;
    case 9:
      return (reader.readStringList(offset) ?? []) as P;
    case 10:
      return (_CNotificationMessagemessageStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          NotificationMessageStatus.sent) as P;
    case 11:
      return (_CNotificationMessagemessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 12:
      return (reader.readObjectOrNull<CNotificationData>(
        offset,
        CNotificationDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CNotificationMessagechannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CNotificationMessagechannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};
const _CNotificationMessagementionTypeEnumValueMap = {
  'users': 0,
  'channel': 1,
};
const _CNotificationMessagementionTypeValueEnumMap = {
  0: MentionType.users,
  1: MentionType.channel,
};
const _CNotificationMessagemessageStatusEnumValueMap = {
  'sent': 0,
  'read': 1,
};
const _CNotificationMessagemessageStatusValueEnumMap = {
  0: NotificationMessageStatus.sent,
  1: NotificationMessageStatus.read,
};
const _CNotificationMessagemessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CNotificationMessagemessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};

Id _cNotificationMessageGetId(CNotificationMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cNotificationMessageGetLinks(
    CNotificationMessage object) {
  return [];
}

void _cNotificationMessageAttach(
    IsarCollection<dynamic> col, Id id, CNotificationMessage object) {
  object.id = id;
}

extension CNotificationMessageByIndex on IsarCollection<CNotificationMessage> {
  Future<CNotificationMessage?> getByRootId(String rootId) {
    return getByIndex(r'rootId', [rootId]);
  }

  CNotificationMessage? getByRootIdSync(String rootId) {
    return getByIndexSync(r'rootId', [rootId]);
  }

  Future<bool> deleteByRootId(String rootId) {
    return deleteByIndex(r'rootId', [rootId]);
  }

  bool deleteByRootIdSync(String rootId) {
    return deleteByIndexSync(r'rootId', [rootId]);
  }

  Future<List<CNotificationMessage?>> getAllByRootId(
      List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'rootId', values);
  }

  List<CNotificationMessage?> getAllByRootIdSync(List<String> rootIdValues) {
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

  Future<Id> putByRootId(CNotificationMessage object) {
    return putByIndex(r'rootId', object);
  }

  Id putByRootIdSync(CNotificationMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'rootId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRootId(List<CNotificationMessage> objects) {
    return putAllByIndex(r'rootId', objects);
  }

  List<Id> putAllByRootIdSync(List<CNotificationMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rootId', objects, saveLinks: saveLinks);
  }
}

extension CNotificationMessageQueryWhereSort
    on QueryBuilder<CNotificationMessage, CNotificationMessage, QWhere> {
  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CNotificationMessageQueryWhere
    on QueryBuilder<CNotificationMessage, CNotificationMessage, QWhereClause> {
  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      rootIdEqualTo(String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootId',
        value: [rootId],
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      messageTypeEqualToAnyRootId(MessageType messageType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType],
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      messageTypeRootIdEqualTo(MessageType messageType, String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType, rootId],
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterWhereClause>
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

extension CNotificationMessageQueryFilter on QueryBuilder<CNotificationMessage,
    CNotificationMessage, QFilterCondition> {
  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> allMetaArraysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> allMetaArraysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allMetaArrays',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> extendedMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> extendedMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extendedMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> mentionTypeEqualTo(MentionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> mentionedUserIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> mentionedUserIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUserIds',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> mentionedUsersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> mentionedUsersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mentionedUsers',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
          QAfterFilterCondition>
      messageStatusEqualTo(NotificationMessageStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> messageStatusGreaterThan(
    NotificationMessageStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> messageStatusLessThan(
    NotificationMessageStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> messageStatusBetween(
    NotificationMessageStatus lower,
    NotificationMessageStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationData',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationData',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
          QAfterFilterCondition>
      notificationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
          QAfterFilterCondition>
      notificationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> notificationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> rootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> rootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
      QAfterFilterCondition> updatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

  QueryBuilder<CNotificationMessage, CNotificationMessage,
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

extension CNotificationMessageQueryObject on QueryBuilder<CNotificationMessage,
    CNotificationMessage, QFilterCondition> {
  QueryBuilder<CNotificationMessage, CNotificationMessage,
          QAfterFilterCondition>
      allMetaArraysElement(FilterQuery<CMessageMetaArray> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'allMetaArrays');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage,
          QAfterFilterCondition>
      notificationData(FilterQuery<CNotificationData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'notificationData');
    });
  }
}

extension CNotificationMessageQueryLinks on QueryBuilder<CNotificationMessage,
    CNotificationMessage, QFilterCondition> {}

extension CNotificationMessageQuerySortBy
    on QueryBuilder<CNotificationMessage, CNotificationMessage, QSortBy> {
  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByMessageStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageStatus', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByMessageStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageStatus', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CNotificationMessageQuerySortThenBy
    on QueryBuilder<CNotificationMessage, CNotificationMessage, QSortThenBy> {
  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByExtendedMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByExtendedMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extendedMessage', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByMentionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mentionType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByMessageStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageStatus', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByMessageStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageStatus', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CNotificationMessageQueryWhereDistinct
    on QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct> {
  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByChannelUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByCustomType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByExtendedMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extendedMessage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByMentionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionType');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByMentionedUserIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionedUserIds');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByMentionedUsers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mentionedUsers');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByMessageStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageStatus');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByNotificationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationMessage, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CNotificationMessageQueryProperty on QueryBuilder<
    CNotificationMessage, CNotificationMessage, QQueryProperty> {
  QueryBuilder<CNotificationMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CNotificationMessage, List<CMessageMetaArray>?, QQueryOperations>
      allMetaArraysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allMetaArrays');
    });
  }

  QueryBuilder<CNotificationMessage, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CNotificationMessage, String, QQueryOperations>
      channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CNotificationMessage, int, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CNotificationMessage, String?, QQueryOperations>
      customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CNotificationMessage, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CNotificationMessage, String, QQueryOperations>
      extendedMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extendedMessage');
    });
  }

  QueryBuilder<CNotificationMessage, MentionType, QQueryOperations>
      mentionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionType');
    });
  }

  QueryBuilder<CNotificationMessage, List<String>, QQueryOperations>
      mentionedUserIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionedUserIds');
    });
  }

  QueryBuilder<CNotificationMessage, List<String>, QQueryOperations>
      mentionedUsersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mentionedUsers');
    });
  }

  QueryBuilder<CNotificationMessage, NotificationMessageStatus,
      QQueryOperations> messageStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageStatus');
    });
  }

  QueryBuilder<CNotificationMessage, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<CNotificationMessage, CNotificationData?, QQueryOperations>
      notificationDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationData');
    });
  }

  QueryBuilder<CNotificationMessage, String, QQueryOperations>
      notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationId');
    });
  }

  QueryBuilder<CNotificationMessage, String, QQueryOperations>
      rootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootId');
    });
  }

  QueryBuilder<CNotificationMessage, int, QQueryOperations>
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

final CNotificationDataSchema = Schema(
  name: r'CNotificationData',
  id: BigInt.parse('6301434927396286571').toInt(),
  properties: {
    r'label': PropertySchema(
      id: 0,
      name: r'label',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 1,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'templateKey': PropertySchema(
      id: 2,
      name: r'templateKey',
      type: IsarType.string,
    ),
    r'templateVariables': PropertySchema(
      id: 3,
      name: r'templateVariables',
      type: IsarType.string,
    )
  },
  estimateSize: _cNotificationDataEstimateSize,
  serialize: _cNotificationDataSerialize,
  deserialize: _cNotificationDataDeserialize,
  deserializeProp: _cNotificationDataDeserializeProp,
);

int _cNotificationDataEstimateSize(
  CNotificationData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.label;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.tags;
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
  bytesCount += 3 + object.templateKey.length * 3;
  bytesCount += 3 + object.templateVariables.length * 3;
  return bytesCount;
}

void _cNotificationDataSerialize(
  CNotificationData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.label);
  writer.writeStringList(offsets[1], object.tags);
  writer.writeString(offsets[2], object.templateKey);
  writer.writeString(offsets[3], object.templateVariables);
}

CNotificationData _cNotificationDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CNotificationData();
  object.label = reader.readStringOrNull(offsets[0]);
  object.tags = reader.readStringList(offsets[1]);
  object.templateKey = reader.readString(offsets[2]);
  object.templateVariables = reader.readString(offsets[3]);
  return object;
}

P _cNotificationDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CNotificationDataQueryFilter
    on QueryBuilder<CNotificationData, CNotificationData, QFilterCondition> {
  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'templateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'templateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'templateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'templateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'templateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'templateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'templateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'templateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateVariables',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'templateVariables',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'templateVariables',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'templateVariables',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'templateVariables',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'templateVariables',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'templateVariables',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'templateVariables',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateVariables',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationData, CNotificationData, QAfterFilterCondition>
      templateVariablesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'templateVariables',
        value: '',
      ));
    });
  }
}

extension CNotificationDataQueryObject
    on QueryBuilder<CNotificationData, CNotificationData, QFilterCondition> {}
