// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_channel_access.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCChannelAccessCollection on Isar {
  IsarCollection<CChannelAccess> get cChannelAccess => this.collection();
}

final CChannelAccessSchema = CollectionSchema(
  name: r'CChannelAccess',
  id: BigInt.parse('-6628375663287460931').toInt(),
  properties: {
    r'channelUrl': PropertySchema(
      id: 0,
      name: r'channelUrl',
      type: IsarType.string,
    ),
    r'lastAccessedAt': PropertySchema(
      id: 1,
      name: r'lastAccessedAt',
      type: IsarType.long,
    )
  },
  estimateSize: _cChannelAccessEstimateSize,
  serialize: _cChannelAccessSerialize,
  deserialize: _cChannelAccessDeserialize,
  deserializeProp: _cChannelAccessDeserializeProp,
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
    r'lastAccessedAt': IndexSchema(
      id: BigInt.parse('7637973981624628205').toInt(),
      name: r'lastAccessedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastAccessedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cChannelAccessGetId,
  getLinks: _cChannelAccessGetLinks,
  attach: _cChannelAccessAttach,
  version: '3.1.0+1',
);

int _cChannelAccessEstimateSize(
  CChannelAccess object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.channelUrl.length * 3;
  return bytesCount;
}

void _cChannelAccessSerialize(
  CChannelAccess object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.channelUrl);
  writer.writeLong(offsets[1], object.lastAccessedAt);
}

CChannelAccess _cChannelAccessDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CChannelAccess();
  object.channelUrl = reader.readString(offsets[0]);
  object.id = id;
  object.lastAccessedAt = reader.readLong(offsets[1]);
  return object;
}

P _cChannelAccessDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cChannelAccessGetId(CChannelAccess object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cChannelAccessGetLinks(CChannelAccess object) {
  return [];
}

void _cChannelAccessAttach(
    IsarCollection<dynamic> col, Id id, CChannelAccess object) {
  object.id = id;
}

extension CChannelAccessByIndex on IsarCollection<CChannelAccess> {
  Future<CChannelAccess?> getByChannelUrl(String channelUrl) {
    return getByIndex(r'channelUrl', [channelUrl]);
  }

  CChannelAccess? getByChannelUrlSync(String channelUrl) {
    return getByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<bool> deleteByChannelUrl(String channelUrl) {
    return deleteByIndex(r'channelUrl', [channelUrl]);
  }

  bool deleteByChannelUrlSync(String channelUrl) {
    return deleteByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<List<CChannelAccess?>> getAllByChannelUrl(
      List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return getAllByIndex(r'channelUrl', values);
  }

  List<CChannelAccess?> getAllByChannelUrlSync(List<String> channelUrlValues) {
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

  Future<Id> putByChannelUrl(CChannelAccess object) {
    return putByIndex(r'channelUrl', object);
  }

  Id putByChannelUrlSync(CChannelAccess object, {bool saveLinks = true}) {
    return putByIndexSync(r'channelUrl', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByChannelUrl(List<CChannelAccess> objects) {
    return putAllByIndex(r'channelUrl', objects);
  }

  List<Id> putAllByChannelUrlSync(List<CChannelAccess> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'channelUrl', objects, saveLinks: saveLinks);
  }
}

extension CChannelAccessQueryWhereSort
    on QueryBuilder<CChannelAccess, CChannelAccess, QWhere> {
  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhere>
      anyLastAccessedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lastAccessedAt'),
      );
    });
  }
}

extension CChannelAccessQueryWhere
    on QueryBuilder<CChannelAccess, CChannelAccess, QWhereClause> {
  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause> idBetween(
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause>
      lastAccessedAtEqualTo(int lastAccessedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastAccessedAt',
        value: [lastAccessedAt],
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause>
      lastAccessedAtNotEqualTo(int lastAccessedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastAccessedAt',
              lower: [],
              upper: [lastAccessedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastAccessedAt',
              lower: [lastAccessedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastAccessedAt',
              lower: [lastAccessedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastAccessedAt',
              lower: [],
              upper: [lastAccessedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause>
      lastAccessedAtGreaterThan(
    int lastAccessedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastAccessedAt',
        lower: [lastAccessedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause>
      lastAccessedAtLessThan(
    int lastAccessedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastAccessedAt',
        lower: [],
        upper: [lastAccessedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterWhereClause>
      lastAccessedAtBetween(
    int lowerLastAccessedAt,
    int upperLastAccessedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastAccessedAt',
        lower: [lowerLastAccessedAt],
        includeLower: includeLower,
        upper: [upperLastAccessedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CChannelAccessQueryFilter
    on QueryBuilder<CChannelAccess, CChannelAccess, QFilterCondition> {
  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      channelUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      channelUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      lastAccessedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAccessedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      lastAccessedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAccessedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      lastAccessedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAccessedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterFilterCondition>
      lastAccessedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAccessedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CChannelAccessQueryObject
    on QueryBuilder<CChannelAccess, CChannelAccess, QFilterCondition> {}

extension CChannelAccessQueryLinks
    on QueryBuilder<CChannelAccess, CChannelAccess, QFilterCondition> {}

extension CChannelAccessQuerySortBy
    on QueryBuilder<CChannelAccess, CChannelAccess, QSortBy> {
  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      sortByLastAccessedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessedAt', Sort.asc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      sortByLastAccessedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessedAt', Sort.desc);
    });
  }
}

extension CChannelAccessQuerySortThenBy
    on QueryBuilder<CChannelAccess, CChannelAccess, QSortThenBy> {
  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      thenByLastAccessedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessedAt', Sort.asc);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QAfterSortBy>
      thenByLastAccessedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAccessedAt', Sort.desc);
    });
  }
}

extension CChannelAccessQueryWhereDistinct
    on QueryBuilder<CChannelAccess, CChannelAccess, QDistinct> {
  QueryBuilder<CChannelAccess, CChannelAccess, QDistinct> distinctByChannelUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CChannelAccess, CChannelAccess, QDistinct>
      distinctByLastAccessedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAccessedAt');
    });
  }
}

extension CChannelAccessQueryProperty
    on QueryBuilder<CChannelAccess, CChannelAccess, QQueryProperty> {
  QueryBuilder<CChannelAccess, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CChannelAccess, String, QQueryOperations> channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CChannelAccess, int, QQueryOperations> lastAccessedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAccessedAt');
    });
  }
}
