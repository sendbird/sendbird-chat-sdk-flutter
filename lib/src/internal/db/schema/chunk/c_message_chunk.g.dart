// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_message_chunk.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCMessageChunkCollection on Isar {
  IsarCollection<CMessageChunk> get cMessageChunks => this.collection();
}

final CMessageChunkSchema = CollectionSchema(
  name: r'CMessageChunk',
  id: BigInt.parse('-912749770485576556').toInt(),
  properties: {
    r'channelUrl': PropertySchema(
      id: 0,
      name: r'channelUrl',
      type: IsarType.string,
    ),
    r'chunks': PropertySchema(
      id: 1,
      name: r'chunks',
      type: IsarType.objectList,
      target: r'CChunk',
    )
  },
  estimateSize: _cMessageChunkEstimateSize,
  serialize: _cMessageChunkSerialize,
  deserialize: _cMessageChunkDeserialize,
  deserializeProp: _cMessageChunkDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {r'CChunk': CChunkSchema},
  getId: _cMessageChunkGetId,
  getLinks: _cMessageChunkGetLinks,
  attach: _cMessageChunkAttach,
  version: '3.1.0+1',
);

int _cMessageChunkEstimateSize(
  CMessageChunk object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.channelUrl.length * 3;
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

void _cMessageChunkSerialize(
  CMessageChunk object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.channelUrl);
  writer.writeObjectList<CChunk>(
    offsets[1],
    allOffsets,
    CChunkSchema.serialize,
    object.chunks,
  );
}

CMessageChunk _cMessageChunkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CMessageChunk();
  object.channelUrl = reader.readString(offsets[0]);
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

P _cMessageChunkDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
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

Id _cMessageChunkGetId(CMessageChunk object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cMessageChunkGetLinks(CMessageChunk object) {
  return [];
}

void _cMessageChunkAttach(
    IsarCollection<dynamic> col, Id id, CMessageChunk object) {
  object.id = id;
}

extension CMessageChunkByIndex on IsarCollection<CMessageChunk> {
  Future<CMessageChunk?> getByChannelUrl(String channelUrl) {
    return getByIndex(r'channelUrl', [channelUrl]);
  }

  CMessageChunk? getByChannelUrlSync(String channelUrl) {
    return getByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<bool> deleteByChannelUrl(String channelUrl) {
    return deleteByIndex(r'channelUrl', [channelUrl]);
  }

  bool deleteByChannelUrlSync(String channelUrl) {
    return deleteByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<List<CMessageChunk?>> getAllByChannelUrl(
      List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return getAllByIndex(r'channelUrl', values);
  }

  List<CMessageChunk?> getAllByChannelUrlSync(List<String> channelUrlValues) {
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

  Future<Id> putByChannelUrl(CMessageChunk object) {
    return putByIndex(r'channelUrl', object);
  }

  Id putByChannelUrlSync(CMessageChunk object, {bool saveLinks = true}) {
    return putByIndexSync(r'channelUrl', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByChannelUrl(List<CMessageChunk> objects) {
    return putAllByIndex(r'channelUrl', objects);
  }

  List<Id> putAllByChannelUrlSync(List<CMessageChunk> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'channelUrl', objects, saveLinks: saveLinks);
  }
}

extension CMessageChunkQueryWhereSort
    on QueryBuilder<CMessageChunk, CMessageChunk, QWhere> {
  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CMessageChunkQueryWhere
    on QueryBuilder<CMessageChunk, CMessageChunk, QWhereClause> {
  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhereClause> idBetween(
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterWhereClause>
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
}

extension CMessageChunkQueryFilter
    on QueryBuilder<CMessageChunk, CMessageChunk, QFilterCondition> {
  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition> idBetween(
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

extension CMessageChunkQueryObject
    on QueryBuilder<CMessageChunk, CMessageChunk, QFilterCondition> {
  QueryBuilder<CMessageChunk, CMessageChunk, QAfterFilterCondition>
      chunksElement(FilterQuery<CChunk> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chunks');
    });
  }
}

extension CMessageChunkQueryLinks
    on QueryBuilder<CMessageChunk, CMessageChunk, QFilterCondition> {}

extension CMessageChunkQuerySortBy
    on QueryBuilder<CMessageChunk, CMessageChunk, QSortBy> {
  QueryBuilder<CMessageChunk, CMessageChunk, QAfterSortBy> sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }
}

extension CMessageChunkQuerySortThenBy
    on QueryBuilder<CMessageChunk, CMessageChunk, QSortThenBy> {
  QueryBuilder<CMessageChunk, CMessageChunk, QAfterSortBy> thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CMessageChunk, CMessageChunk, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CMessageChunkQueryWhereDistinct
    on QueryBuilder<CMessageChunk, CMessageChunk, QDistinct> {
  QueryBuilder<CMessageChunk, CMessageChunk, QDistinct> distinctByChannelUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }
}

extension CMessageChunkQueryProperty
    on QueryBuilder<CMessageChunk, CMessageChunk, QQueryProperty> {
  QueryBuilder<CMessageChunk, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CMessageChunk, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CMessageChunk, List<CChunk>, QQueryOperations> chunksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chunks');
    });
  }
}
