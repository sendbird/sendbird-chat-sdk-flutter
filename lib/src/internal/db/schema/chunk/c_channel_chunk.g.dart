// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_channel_chunk.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCChannelChunkCollection on Isar {
  IsarCollection<CChannelChunk> get cChannelChunks => this.collection();
}

final CChannelChunkSchema = CollectionSchema(
  name: r'CChannelChunk',
  id: BigInt.parse('-5197328800100259982').toInt(),
  properties: {
    r'channelChunkType': PropertySchema(
      id: 0,
      name: r'channelChunkType',
      type: IsarType.byte,
      enumMap: _CChannelChunkchannelChunkTypeEnumValueMap,
    ),
    r'chunks': PropertySchema(
      id: 1,
      name: r'chunks',
      type: IsarType.objectList,
      target: r'CChunk',
    )
  },
  estimateSize: _cChannelChunkEstimateSize,
  serialize: _cChannelChunkSerialize,
  deserialize: _cChannelChunkDeserialize,
  deserializeProp: _cChannelChunkDeserializeProp,
  idName: r'id',
  indexes: {
    r'channelChunkType': IndexSchema(
      id: BigInt.parse('4843714266287096217').toInt(),
      name: r'channelChunkType',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'channelChunkType',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'CChunk': CChunkSchema},
  getId: _cChannelChunkGetId,
  getLinks: _cChannelChunkGetLinks,
  attach: _cChannelChunkAttach,
  version: '3.1.0+1',
);

int _cChannelChunkEstimateSize(
  CChannelChunk object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.chunks.length * 3;
  {
    final offsets = allOffsets[CChunk]!;
    for (var i = 0; i < object.chunks.length; i++) {
      final value = object.chunks[i];
      bytesCount += CChunkSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _cChannelChunkSerialize(
  CChannelChunk object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.channelChunkType.index);
  writer.writeObjectList<CChunk>(
    offsets[1],
    allOffsets,
    CChunkSchema.serialize,
    object.chunks,
  );
}

CChannelChunk _cChannelChunkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CChannelChunk();
  object.channelChunkType = _CChannelChunkchannelChunkTypeValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      ChannelChunkType.chronologicalGroupChannelChunk;
  object.chunks = reader.readObjectList<CChunk>(
        offsets[1],
        CChunkSchema.deserialize,
        allOffsets,
        CChunk(),
      ) ??
      [];
  object.id = id;
  return object;
}

P _cChannelChunkDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CChannelChunkchannelChunkTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ChannelChunkType.chronologicalGroupChannelChunk) as P;
    case 1:
      return (reader.readObjectList<CChunk>(
            offset,
            CChunkSchema.deserialize,
            allOffsets,
            CChunk(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CChannelChunkchannelChunkTypeEnumValueMap = {
  'chronologicalGroupChannelChunk': 0,
};
const _CChannelChunkchannelChunkTypeValueEnumMap = {
  0: ChannelChunkType.chronologicalGroupChannelChunk,
};

Id _cChannelChunkGetId(CChannelChunk object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cChannelChunkGetLinks(CChannelChunk object) {
  return [];
}

void _cChannelChunkAttach(
    IsarCollection<dynamic> col, Id id, CChannelChunk object) {
  object.id = id;
}

extension CChannelChunkByIndex on IsarCollection<CChannelChunk> {
  Future<CChannelChunk?> getByChannelChunkType(
      ChannelChunkType channelChunkType) {
    return getByIndex(r'channelChunkType', [channelChunkType]);
  }

  CChannelChunk? getByChannelChunkTypeSync(ChannelChunkType channelChunkType) {
    return getByIndexSync(r'channelChunkType', [channelChunkType]);
  }

  Future<bool> deleteByChannelChunkType(ChannelChunkType channelChunkType) {
    return deleteByIndex(r'channelChunkType', [channelChunkType]);
  }

  bool deleteByChannelChunkTypeSync(ChannelChunkType channelChunkType) {
    return deleteByIndexSync(r'channelChunkType', [channelChunkType]);
  }

  Future<List<CChannelChunk?>> getAllByChannelChunkType(
      List<ChannelChunkType> channelChunkTypeValues) {
    final values = channelChunkTypeValues.map((e) => [e]).toList();
    return getAllByIndex(r'channelChunkType', values);
  }

  List<CChannelChunk?> getAllByChannelChunkTypeSync(
      List<ChannelChunkType> channelChunkTypeValues) {
    final values = channelChunkTypeValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'channelChunkType', values);
  }

  Future<int> deleteAllByChannelChunkType(
      List<ChannelChunkType> channelChunkTypeValues) {
    final values = channelChunkTypeValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'channelChunkType', values);
  }

  int deleteAllByChannelChunkTypeSync(
      List<ChannelChunkType> channelChunkTypeValues) {
    final values = channelChunkTypeValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'channelChunkType', values);
  }

  Future<Id> putByChannelChunkType(CChannelChunk object) {
    return putByIndex(r'channelChunkType', object);
  }

  Id putByChannelChunkTypeSync(CChannelChunk object, {bool saveLinks = true}) {
    return putByIndexSync(r'channelChunkType', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByChannelChunkType(List<CChannelChunk> objects) {
    return putAllByIndex(r'channelChunkType', objects);
  }

  List<Id> putAllByChannelChunkTypeSync(List<CChannelChunk> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'channelChunkType', objects,
        saveLinks: saveLinks);
  }
}

extension CChannelChunkQueryWhereSort
    on QueryBuilder<CChannelChunk, CChannelChunk, QWhere> {
  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhere>
      anyChannelChunkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'channelChunkType'),
      );
    });
  }
}

extension CChannelChunkQueryWhere
    on QueryBuilder<CChannelChunk, CChannelChunk, QWhereClause> {
  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause> idBetween(
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

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause>
      channelChunkTypeEqualTo(ChannelChunkType channelChunkType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelChunkType',
        value: [channelChunkType],
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause>
      channelChunkTypeNotEqualTo(ChannelChunkType channelChunkType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelChunkType',
              lower: [],
              upper: [channelChunkType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelChunkType',
              lower: [channelChunkType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelChunkType',
              lower: [channelChunkType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelChunkType',
              lower: [],
              upper: [channelChunkType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause>
      channelChunkTypeGreaterThan(
    ChannelChunkType channelChunkType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelChunkType',
        lower: [channelChunkType],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause>
      channelChunkTypeLessThan(
    ChannelChunkType channelChunkType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelChunkType',
        lower: [],
        upper: [channelChunkType],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterWhereClause>
      channelChunkTypeBetween(
    ChannelChunkType lowerChannelChunkType,
    ChannelChunkType upperChannelChunkType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelChunkType',
        lower: [lowerChannelChunkType],
        includeLower: includeLower,
        upper: [upperChannelChunkType],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CChannelChunkQueryFilter
    on QueryBuilder<CChannelChunk, CChannelChunk, QFilterCondition> {
  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      channelChunkTypeEqualTo(ChannelChunkType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelChunkType',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      channelChunkTypeGreaterThan(
    ChannelChunkType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'channelChunkType',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      channelChunkTypeLessThan(
    ChannelChunkType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'channelChunkType',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      channelChunkTypeBetween(
    ChannelChunkType lower,
    ChannelChunkType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'channelChunkType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      chunksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chunks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      chunksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chunks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      chunksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chunks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      chunksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chunks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      chunksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chunks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      chunksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chunks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
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

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition> idBetween(
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
}

extension CChannelChunkQueryObject
    on QueryBuilder<CChannelChunk, CChannelChunk, QFilterCondition> {
  QueryBuilder<CChannelChunk, CChannelChunk, QAfterFilterCondition>
      chunksElement(FilterQuery<CChunk> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chunks');
    });
  }
}

extension CChannelChunkQueryLinks
    on QueryBuilder<CChannelChunk, CChannelChunk, QFilterCondition> {}

extension CChannelChunkQuerySortBy
    on QueryBuilder<CChannelChunk, CChannelChunk, QSortBy> {
  QueryBuilder<CChannelChunk, CChannelChunk, QAfterSortBy>
      sortByChannelChunkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelChunkType', Sort.asc);
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterSortBy>
      sortByChannelChunkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelChunkType', Sort.desc);
    });
  }
}

extension CChannelChunkQuerySortThenBy
    on QueryBuilder<CChannelChunk, CChannelChunk, QSortThenBy> {
  QueryBuilder<CChannelChunk, CChannelChunk, QAfterSortBy>
      thenByChannelChunkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelChunkType', Sort.asc);
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterSortBy>
      thenByChannelChunkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelChunkType', Sort.desc);
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CChannelChunk, CChannelChunk, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CChannelChunkQueryWhereDistinct
    on QueryBuilder<CChannelChunk, CChannelChunk, QDistinct> {
  QueryBuilder<CChannelChunk, CChannelChunk, QDistinct>
      distinctByChannelChunkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelChunkType');
    });
  }
}

extension CChannelChunkQueryProperty
    on QueryBuilder<CChannelChunk, CChannelChunk, QQueryProperty> {
  QueryBuilder<CChannelChunk, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CChannelChunk, ChannelChunkType, QQueryOperations>
      channelChunkTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelChunkType');
    });
  }

  QueryBuilder<CChannelChunk, List<CChunk>, QQueryOperations> chunksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chunks');
    });
  }
}
