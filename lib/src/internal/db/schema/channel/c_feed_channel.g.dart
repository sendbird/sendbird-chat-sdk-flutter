// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_feed_channel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCFeedChannelCollection on Isar {
  IsarCollection<CFeedChannel> get cFeedChannels => this.collection();
}

final CFeedChannelSchema = CollectionSchema(
  name: r'CFeedChannel',
  id: BigInt.parse('8060769429537757837').toInt(),
  properties: {
    r'channelType': PropertySchema(
      id: 0,
      name: r'channelType',
      type: IsarType.byte,
      enumMap: _CFeedChannelchannelTypeEnumValueMap,
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
    r'dirty': PropertySchema(
      id: 6,
      name: r'dirty',
      type: IsarType.bool,
    ),
    r'fromCache': PropertySchema(
      id: 7,
      name: r'fromCache',
      type: IsarType.bool,
    ),
    r'isCategoryFilterEnabled': PropertySchema(
      id: 8,
      name: r'isCategoryFilterEnabled',
      type: IsarType.bool,
    ),
    r'isEphemeral': PropertySchema(
      id: 9,
      name: r'isEphemeral',
      type: IsarType.bool,
    ),
    r'isFrozen': PropertySchema(
      id: 10,
      name: r'isFrozen',
      type: IsarType.bool,
    ),
    r'isTemplateLabelEnabled': PropertySchema(
      id: 11,
      name: r'isTemplateLabelEnabled',
      type: IsarType.bool,
    ),
    r'lastMessageRootId': PropertySchema(
      id: 12,
      name: r'lastMessageRootId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'notificationCategories': PropertySchema(
      id: 14,
      name: r'notificationCategories',
      type: IsarType.objectList,
      target: r'CNotificationCategory',
    )
  },
  estimateSize: _cFeedChannelEstimateSize,
  serialize: _cFeedChannelSerialize,
  deserialize: _cFeedChannelDeserialize,
  deserializeProp: _cFeedChannelDeserializeProp,
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
  embeddedSchemas: {r'CNotificationCategory': CNotificationCategorySchema},
  getId: _cFeedChannelGetId,
  getLinks: _cFeedChannelGetLinks,
  attach: _cFeedChannelAttach,
  version: '3.1.0+1',
);

int _cFeedChannelEstimateSize(
  CFeedChannel object,
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
    final value = object.lastMessageRootId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.notificationCategories.length * 3;
  {
    final offsets = allOffsets[CNotificationCategory]!;
    for (var i = 0; i < object.notificationCategories.length; i++) {
      final value = object.notificationCategories[i];
      bytesCount +=
          CNotificationCategorySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _cFeedChannelSerialize(
  CFeedChannel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.channelType.index);
  writer.writeString(offsets[1], object.channelUrl);
  writer.writeString(offsets[2], object.coverUrl);
  writer.writeLong(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.customType);
  writer.writeString(offsets[5], object.data);
  writer.writeBool(offsets[6], object.dirty);
  writer.writeBool(offsets[7], object.fromCache);
  writer.writeBool(offsets[8], object.isCategoryFilterEnabled);
  writer.writeBool(offsets[9], object.isEphemeral);
  writer.writeBool(offsets[10], object.isFrozen);
  writer.writeBool(offsets[11], object.isTemplateLabelEnabled);
  writer.writeString(offsets[12], object.lastMessageRootId);
  writer.writeString(offsets[13], object.name);
  writer.writeObjectList<CNotificationCategory>(
    offsets[14],
    allOffsets,
    CNotificationCategorySchema.serialize,
    object.notificationCategories,
  );
}

CFeedChannel _cFeedChannelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CFeedChannel();
  object.channelType =
      _CFeedChannelchannelTypeValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          ChannelType.group;
  object.channelUrl = reader.readString(offsets[1]);
  object.coverUrl = reader.readStringOrNull(offsets[2]);
  object.createdAt = reader.readLongOrNull(offsets[3]);
  object.customType = reader.readStringOrNull(offsets[4]);
  object.data = reader.readStringOrNull(offsets[5]);
  object.dirty = reader.readBool(offsets[6]);
  object.fromCache = reader.readBool(offsets[7]);
  object.id = id;
  object.isCategoryFilterEnabled = reader.readBoolOrNull(offsets[8]);
  object.isEphemeral = reader.readBoolOrNull(offsets[9]);
  object.isFrozen = reader.readBoolOrNull(offsets[10]);
  object.isTemplateLabelEnabled = reader.readBoolOrNull(offsets[11]);
  object.lastMessageRootId = reader.readStringOrNull(offsets[12]);
  object.name = reader.readString(offsets[13]);
  object.notificationCategories = reader.readObjectList<CNotificationCategory>(
        offsets[14],
        CNotificationCategorySchema.deserialize,
        allOffsets,
        CNotificationCategory(),
      ) ??
      [];
  return object;
}

P _cFeedChannelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CFeedChannelchannelTypeValueEnumMap[
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
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readObjectList<CNotificationCategory>(
            offset,
            CNotificationCategorySchema.deserialize,
            allOffsets,
            CNotificationCategory(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CFeedChannelchannelTypeEnumValueMap = {
  'group': 0,
  'open': 1,
  'feed': 2,
};
const _CFeedChannelchannelTypeValueEnumMap = {
  0: ChannelType.group,
  1: ChannelType.open,
  2: ChannelType.feed,
};

Id _cFeedChannelGetId(CFeedChannel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cFeedChannelGetLinks(CFeedChannel object) {
  return [];
}

void _cFeedChannelAttach(
    IsarCollection<dynamic> col, Id id, CFeedChannel object) {
  object.id = id;
}

extension CFeedChannelByIndex on IsarCollection<CFeedChannel> {
  Future<CFeedChannel?> getByChannelUrl(String channelUrl) {
    return getByIndex(r'channelUrl', [channelUrl]);
  }

  CFeedChannel? getByChannelUrlSync(String channelUrl) {
    return getByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<bool> deleteByChannelUrl(String channelUrl) {
    return deleteByIndex(r'channelUrl', [channelUrl]);
  }

  bool deleteByChannelUrlSync(String channelUrl) {
    return deleteByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<List<CFeedChannel?>> getAllByChannelUrl(
      List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return getAllByIndex(r'channelUrl', values);
  }

  List<CFeedChannel?> getAllByChannelUrlSync(List<String> channelUrlValues) {
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

  Future<Id> putByChannelUrl(CFeedChannel object) {
    return putByIndex(r'channelUrl', object);
  }

  Id putByChannelUrlSync(CFeedChannel object, {bool saveLinks = true}) {
    return putByIndexSync(r'channelUrl', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByChannelUrl(List<CFeedChannel> objects) {
    return putAllByIndex(r'channelUrl', objects);
  }

  List<Id> putAllByChannelUrlSync(List<CFeedChannel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'channelUrl', objects, saveLinks: saveLinks);
  }
}

extension CFeedChannelQueryWhereSort
    on QueryBuilder<CFeedChannel, CFeedChannel, QWhere> {
  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CFeedChannelQueryWhere
    on QueryBuilder<CFeedChannel, CFeedChannel, QWhereClause> {
  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause> idBetween(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause> channelUrlEqualTo(
      String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
      channelTypeEqualToAnyChannelUrl(ChannelType channelType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType],
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
      channelTypeChannelUrlEqualTo(ChannelType channelType, String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelType_channelUrl',
        value: [channelType, channelUrl],
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterWhereClause>
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

extension CFeedChannelQueryFilter
    on QueryBuilder<CFeedChannel, CFeedChannel, QFilterCondition> {
  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      channelTypeEqualTo(ChannelType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelType',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      coverUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverUrl',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      coverUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverUrl',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      coverUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      coverUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      coverUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      coverUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      createdAtEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      customTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      customTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customType',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      customTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      customTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dataEqualTo(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dataLessThan(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dataBetween(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dataEndsWith(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dataContains(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dataMatches(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> dirtyEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dirty',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      fromCacheEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCache',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isCategoryFilterEnabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCategoryFilterEnabled',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isCategoryFilterEnabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCategoryFilterEnabled',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isCategoryFilterEnabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCategoryFilterEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isEphemeralIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isEphemeral',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isEphemeralIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isEphemeral',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isEphemeralEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEphemeral',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isFrozenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFrozen',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isFrozenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFrozen',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isFrozenEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFrozen',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isTemplateLabelEnabledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isTemplateLabelEnabled',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isTemplateLabelEnabledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isTemplateLabelEnabled',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      isTemplateLabelEnabledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTemplateLabelEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      lastMessageRootIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessageRootId',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      lastMessageRootIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessageRootId',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      lastMessageRootIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessageRootId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      lastMessageRootIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessageRootId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      lastMessageRootIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      lastMessageRootIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessageRootId',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> nameContains(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      notificationCategoriesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationCategories',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      notificationCategoriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationCategories',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      notificationCategoriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationCategories',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      notificationCategoriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationCategories',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      notificationCategoriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationCategories',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      notificationCategoriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationCategories',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CFeedChannelQueryObject
    on QueryBuilder<CFeedChannel, CFeedChannel, QFilterCondition> {
  QueryBuilder<CFeedChannel, CFeedChannel, QAfterFilterCondition>
      notificationCategoriesElement(FilterQuery<CNotificationCategory> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'notificationCategories');
    });
  }
}

extension CFeedChannelQueryLinks
    on QueryBuilder<CFeedChannel, CFeedChannel, QFilterCondition> {}

extension CFeedChannelQuerySortBy
    on QueryBuilder<CFeedChannel, CFeedChannel, QSortBy> {
  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByCoverUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByCoverUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByFromCache() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByFromCacheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByIsCategoryFilterEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCategoryFilterEnabled', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByIsCategoryFilterEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCategoryFilterEnabled', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByIsEphemeral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByIsEphemeralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByIsFrozen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByIsFrozenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByIsTemplateLabelEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTemplateLabelEnabled', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByIsTemplateLabelEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTemplateLabelEnabled', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByLastMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      sortByLastMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension CFeedChannelQuerySortThenBy
    on QueryBuilder<CFeedChannel, CFeedChannel, QSortThenBy> {
  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByChannelTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelType', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByCoverUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByCoverUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByCustomType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByCustomTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customType', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByFromCache() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByFromCacheDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCache', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByIsCategoryFilterEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCategoryFilterEnabled', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByIsCategoryFilterEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCategoryFilterEnabled', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByIsEphemeral() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByIsEphemeralDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEphemeral', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByIsFrozen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByIsFrozenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFrozen', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByIsTemplateLabelEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTemplateLabelEnabled', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByIsTemplateLabelEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTemplateLabelEnabled', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByLastMessageRootId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy>
      thenByLastMessageRootIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageRootId', Sort.desc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension CFeedChannelQueryWhereDistinct
    on QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> {
  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByChannelType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelType');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByChannelUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByCoverUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByCustomType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dirty');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByFromCache() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromCache');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct>
      distinctByIsCategoryFilterEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCategoryFilterEnabled');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByIsEphemeral() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEphemeral');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByIsFrozen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFrozen');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct>
      distinctByIsTemplateLabelEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTemplateLabelEnabled');
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct>
      distinctByLastMessageRootId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageRootId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CFeedChannel, CFeedChannel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension CFeedChannelQueryProperty
    on QueryBuilder<CFeedChannel, CFeedChannel, QQueryProperty> {
  QueryBuilder<CFeedChannel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CFeedChannel, ChannelType, QQueryOperations>
      channelTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelType');
    });
  }

  QueryBuilder<CFeedChannel, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CFeedChannel, String?, QQueryOperations> coverUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverUrl');
    });
  }

  QueryBuilder<CFeedChannel, int?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CFeedChannel, String?, QQueryOperations> customTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customType');
    });
  }

  QueryBuilder<CFeedChannel, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CFeedChannel, bool, QQueryOperations> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dirty');
    });
  }

  QueryBuilder<CFeedChannel, bool, QQueryOperations> fromCacheProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromCache');
    });
  }

  QueryBuilder<CFeedChannel, bool?, QQueryOperations>
      isCategoryFilterEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCategoryFilterEnabled');
    });
  }

  QueryBuilder<CFeedChannel, bool?, QQueryOperations> isEphemeralProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEphemeral');
    });
  }

  QueryBuilder<CFeedChannel, bool?, QQueryOperations> isFrozenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFrozen');
    });
  }

  QueryBuilder<CFeedChannel, bool?, QQueryOperations>
      isTemplateLabelEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTemplateLabelEnabled');
    });
  }

  QueryBuilder<CFeedChannel, String?, QQueryOperations>
      lastMessageRootIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageRootId');
    });
  }

  QueryBuilder<CFeedChannel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CFeedChannel, List<CNotificationCategory>, QQueryOperations>
      notificationCategoriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationCategories');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CNotificationCategorySchema = Schema(
  name: r'CNotificationCategory',
  id: BigInt.parse('-4785915202986038644').toInt(),
  properties: {
    r'customType': PropertySchema(
      id: 0,
      name: r'customType',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.long,
    ),
    r'isDefault': PropertySchema(
      id: 2,
      name: r'isDefault',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _cNotificationCategoryEstimateSize,
  serialize: _cNotificationCategorySerialize,
  deserialize: _cNotificationCategoryDeserialize,
  deserializeProp: _cNotificationCategoryDeserializeProp,
);

int _cNotificationCategoryEstimateSize(
  CNotificationCategory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.customType.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _cNotificationCategorySerialize(
  CNotificationCategory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customType);
  writer.writeLong(offsets[1], object.id);
  writer.writeBool(offsets[2], object.isDefault);
  writer.writeString(offsets[3], object.name);
}

CNotificationCategory _cNotificationCategoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CNotificationCategory();
  object.customType = reader.readString(offsets[0]);
  object.id = reader.readLong(offsets[1]);
  object.isDefault = reader.readBool(offsets[2]);
  object.name = reader.readString(offsets[3]);
  return object;
}

P _cNotificationCategoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CNotificationCategoryQueryFilter on QueryBuilder<
    CNotificationCategory, CNotificationCategory, QFilterCondition> {
  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> customTypeEqualTo(
    String value, {
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> customTypeGreaterThan(
    String value, {
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> customTypeLessThan(
    String value, {
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> customTypeBetween(
    String lower,
    String upper, {
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> customTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> customTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customType',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> isDefaultEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDefault',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameBetween(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<CNotificationCategory, CNotificationCategory,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationCategory, CNotificationCategory,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationCategory, CNotificationCategory,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension CNotificationCategoryQueryObject on QueryBuilder<
    CNotificationCategory, CNotificationCategory, QFilterCondition> {}
