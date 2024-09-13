// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_channel_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCChannelMessageCollection on Isar {
  IsarCollection<CChannelMessage> get cChannelMessages => this.collection();
}

final CChannelMessageSchema = CollectionSchema(
  name: r'CChannelMessage',
  id: BigInt.parse('-5850314032481753759').toInt(),
  properties: {
    r'channelType': PropertySchema(
      id: 0,
      name: r'channelType',
      type: IsarType.byte,
      enumMap: _CChannelMessagechannelTypeEnumValueMap,
    ),
    r'channelUrl': PropertySchema(
      id: 1,
      name: r'channelUrl',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.long,
    ),
    r'customType': PropertySchema(
      id: 3,
      name: r'customType',
      type: IsarType.string,
    ),
    r'messageType': PropertySchema(
      id: 4,
      name: r'messageType',
      type: IsarType.byte,
      enumMap: _CChannelMessagemessageTypeEnumValueMap,
    ),
    r'rootId': PropertySchema(
      id: 5,
      name: r'rootId',
      type: IsarType.string,
    ),
    r'senderId': PropertySchema(
      id: 6,
      name: r'senderId',
      type: IsarType.string,
    ),
    r'sendingStatus': PropertySchema(
      id: 7,
      name: r'sendingStatus',
      type: IsarType.byte,
      enumMap: _CChannelMessagesendingStatusEnumValueMap,
    )
  },
  estimateSize: _cChannelMessageEstimateSize,
  serialize: _cChannelMessageSerialize,
  deserialize: _cChannelMessageDeserialize,
  deserializeProp: _cChannelMessageDeserializeProp,
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
    ),
    r'createdAt': IndexSchema(
      id: BigInt.parse('-3433535483987302584').toInt(),
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'sendingStatus': IndexSchema(
      id: BigInt.parse('208667966773972562').toInt(),
      name: r'sendingStatus',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sendingStatus',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cChannelMessageGetId,
  getLinks: _cChannelMessageGetLinks,
  attach: _cChannelMessageAttach,
  version: '3.1.0+1',
);

int _cChannelMessageEstimateSize(
  CChannelMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.channelUrl.length * 3;
  {
    final value = object.customType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.rootId.length * 3;
  {
    final value = object.senderId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cChannelMessageSerialize(
  CChannelMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.channelType.index);
  writer.writeString(offsets[1], object.channelUrl);
  writer.writeLong(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.customType);
  writer.writeByte(offsets[4], object.messageType.index);
  writer.writeString(offsets[5], object.rootId);
  writer.writeString(offsets[6], object.senderId);
  writer.writeByte(offsets[7], object.sendingStatus.index);
}

CChannelMessage _cChannelMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CChannelMessage();
  object.channelType = _CChannelMessagechannelTypeValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      ChannelType.group;
  object.channelUrl = reader.readString(offsets[1]);
  object.createdAt = reader.readLong(offsets[2]);
  object.customType = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.messageType = _CChannelMessagemessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[4])] ??
      MessageType.user;
  object.rootId = reader.readString(offsets[5]);
  object.senderId = reader.readStringOrNull(offsets[6]);
  object.sendingStatus = _CChannelMessagesendingStatusValueEnumMap[
          reader.readByteOrNull(offsets[7])] ??
      SendingStatus.none;
  return object;
}

P _cChannelMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CChannelMessagechannelTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ChannelType.group) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (_CChannelMessagemessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.user) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_CChannelMessagesendingStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SendingStatus.none) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CChannelMessagechannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CChannelMessagechannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};
const _CChannelMessagemessageTypeEnumValueMap = {
  'user': 0,
  'file': 1,
  'admin': 2,
  'notification': 3,
};
const _CChannelMessagemessageTypeValueEnumMap = {
  0: MessageType.user,
  1: MessageType.file,
  2: MessageType.admin,
  3: MessageType.notification,
};
const _CChannelMessagesendingStatusEnumValueMap = {
  'none': 0,
  'pending': 1,
  'failed': 2,
  'succeeded': 3,
  'canceled': 4,
};
const _CChannelMessagesendingStatusValueEnumMap = {
  0: SendingStatus.none,
  1: SendingStatus.pending,
  2: SendingStatus.failed,
  3: SendingStatus.succeeded,
  4: SendingStatus.canceled,
};

Id _cChannelMessageGetId(CChannelMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cChannelMessageGetLinks(CChannelMessage object) {
  return [];
}

void _cChannelMessageAttach(
    IsarCollection<dynamic> col, Id id, CChannelMessage object) {
  object.id = id;
}

extension CChannelMessageByIndex on IsarCollection<CChannelMessage> {
  Future<CChannelMessage?> getByRootId(String rootId) {
    return getByIndex(r'rootId', [rootId]);
  }

  CChannelMessage? getByRootIdSync(String rootId) {
    return getByIndexSync(r'rootId', [rootId]);
  }

  Future<bool> deleteByRootId(String rootId) {
    return deleteByIndex(r'rootId', [rootId]);
  }

  bool deleteByRootIdSync(String rootId) {
    return deleteByIndexSync(r'rootId', [rootId]);
  }

  Future<List<CChannelMessage?>> getAllByRootId(List<String> rootIdValues) {
    final values = rootIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'rootId', values);
  }

  List<CChannelMessage?> getAllByRootIdSync(List<String> rootIdValues) {
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

  Future<Id> putByRootId(CChannelMessage object) {
    return putByIndex(r'rootId', object);
  }

  Id putByRootIdSync(CChannelMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'rootId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRootId(List<CChannelMessage> objects) {
    return putAllByIndex(r'rootId', objects);
  }

  List<Id> putAllByRootIdSync(List<CChannelMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rootId', objects, saveLinks: saveLinks);
  }
}

extension CChannelMessageQueryWhereSort
    on QueryBuilder<CChannelMessage, CChannelMessage, QWhere> {
  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhere>
      anySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sendingStatus'),
      );
    });
  }
}

extension CChannelMessageQueryWhere
    on QueryBuilder<CChannelMessage, CChannelMessage, QWhereClause> {
  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause> idBetween(
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      rootIdEqualTo(String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootId',
        value: [rootId],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      messageTypeEqualToAnyRootId(MessageType messageType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      messageTypeRootIdEqualTo(MessageType messageType, String rootId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageType_rootId',
        value: [messageType, rootId],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      createdAtEqualTo(int createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      createdAtNotEqualTo(int createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      createdAtGreaterThan(
    int createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      createdAtLessThan(
    int createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      createdAtBetween(
    int lowerCreatedAt,
    int upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      sendingStatusEqualTo(SendingStatus sendingStatus) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sendingStatus',
        value: [sendingStatus],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      sendingStatusNotEqualTo(SendingStatus sendingStatus) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sendingStatus',
              lower: [],
              upper: [sendingStatus],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sendingStatus',
              lower: [sendingStatus],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sendingStatus',
              lower: [sendingStatus],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sendingStatus',
              lower: [],
              upper: [sendingStatus],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      sendingStatusGreaterThan(
    SendingStatus sendingStatus, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sendingStatus',
        lower: [sendingStatus],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      sendingStatusLessThan(
    SendingStatus sendingStatus, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sendingStatus',
        lower: [],
        upper: [sendingStatus],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterWhereClause>
      sendingStatusBetween(
    SendingStatus lowerSendingStatus,
    SendingStatus upperSendingStatus, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'sendingStatus',
        lower: [lowerSendingStatus],
        includeLower: includeLower,
        upper: [upperSendingStatus],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CChannelMessageQueryFilter
    on QueryBuilder<CChannelMessage, CChannelMessage, QFilterCondition> {
  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      rootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      rootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      rootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      rootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senderId',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senderId',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      senderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
      sendingStatusEqualTo(SendingStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sendingStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterFilterCondition>
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
}

extension CChannelMessageQueryObject
    on QueryBuilder<CChannelMessage, CChannelMessage, QFilterCondition> {}

extension CChannelMessageQueryLinks
    on QueryBuilder<CChannelMessage, CChannelMessage, QFilterCondition> {}

extension CChannelMessageQuerySortBy
    on QueryBuilder<CChannelMessage, CChannelMessage, QSortBy> {
  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy> sortByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      sortBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }
}

extension CChannelMessageQuerySortThenBy
    on QueryBuilder<CChannelMessage, CChannelMessage, QSortThenBy> {
  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy> thenByRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenByRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootId', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.asc);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QAfterSortBy>
      thenBySendingStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sendingStatus', Sort.desc);
    });
  }
}

extension CChannelMessageQueryWhereDistinct
    on QueryBuilder<CChannelMessage, CChannelMessage, QDistinct> {
  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct>
      distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct>
      distinctByChannelUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct>
      distinctByCustomType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct>
      distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct> distinctByRootId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct> distinctBySenderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CChannelMessage, CChannelMessage, QDistinct>
      distinctBySendingStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sendingStatus');
    });
  }
}

extension CChannelMessageQueryProperty
    on QueryBuilder<CChannelMessage, CChannelMessage, QQueryProperty> {
  QueryBuilder<CChannelMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CChannelMessage, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CChannelMessage, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CChannelMessage, int, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CChannelMessage, String?, QQueryOperations>
      customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CChannelMessage, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<CChannelMessage, String, QQueryOperations> rootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootId');
    });
  }

  QueryBuilder<CChannelMessage, String?, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }

  QueryBuilder<CChannelMessage, SendingStatus, QQueryOperations>
      sendingStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sendingStatus');
    });
  }
}
