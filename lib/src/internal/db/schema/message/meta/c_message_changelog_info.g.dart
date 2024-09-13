// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_message_changelog_info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCMessageChangeLogInfoCollection on Isar {
  IsarCollection<CMessageChangeLogInfo> get cMessageChangeLogInfos =>
      this.collection();
}

final CMessageChangeLogInfoSchema = CollectionSchema(
  name: r'CMessageChangeLogInfo',
  id: BigInt.parse('-8707217854990464807').toInt(),
  properties: {
    r'channelUrl': PropertySchema(
      id: 0,
      name: r'channelUrl',
      type: IsarType.string,
    ),
    r'lastMessageToken': PropertySchema(
      id: 1,
      name: r'lastMessageToken',
      type: IsarType.string,
    ),
    r'lastPollToken': PropertySchema(
      id: 2,
      name: r'lastPollToken',
      type: IsarType.string,
    )
  },
  estimateSize: _cMessageChangeLogInfoEstimateSize,
  serialize: _cMessageChangeLogInfoSerialize,
  deserialize: _cMessageChangeLogInfoDeserialize,
  deserializeProp: _cMessageChangeLogInfoDeserializeProp,
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
  embeddedSchemas: {},
  getId: _cMessageChangeLogInfoGetId,
  getLinks: _cMessageChangeLogInfoGetLinks,
  attach: _cMessageChangeLogInfoAttach,
  version: '3.1.0+1',
);

int _cMessageChangeLogInfoEstimateSize(
  CMessageChangeLogInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.channelUrl.length * 3;
  {
    final value = object.lastMessageToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastPollToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cMessageChangeLogInfoSerialize(
  CMessageChangeLogInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.channelUrl);
  writer.writeString(offsets[1], object.lastMessageToken);
  writer.writeString(offsets[2], object.lastPollToken);
}

CMessageChangeLogInfo _cMessageChangeLogInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CMessageChangeLogInfo();
  object.channelUrl = reader.readString(offsets[0]);
  object.id = id;
  object.lastMessageToken = reader.readStringOrNull(offsets[1]);
  object.lastPollToken = reader.readStringOrNull(offsets[2]);
  return object;
}

P _cMessageChangeLogInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cMessageChangeLogInfoGetId(CMessageChangeLogInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cMessageChangeLogInfoGetLinks(
    CMessageChangeLogInfo object) {
  return [];
}

void _cMessageChangeLogInfoAttach(
    IsarCollection<dynamic> col, Id id, CMessageChangeLogInfo object) {
  object.id = id;
}

extension CMessageChangeLogInfoByIndex
    on IsarCollection<CMessageChangeLogInfo> {
  Future<CMessageChangeLogInfo?> getByChannelUrl(String channelUrl) {
    return getByIndex(r'channelUrl', [channelUrl]);
  }

  CMessageChangeLogInfo? getByChannelUrlSync(String channelUrl) {
    return getByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<bool> deleteByChannelUrl(String channelUrl) {
    return deleteByIndex(r'channelUrl', [channelUrl]);
  }

  bool deleteByChannelUrlSync(String channelUrl) {
    return deleteByIndexSync(r'channelUrl', [channelUrl]);
  }

  Future<List<CMessageChangeLogInfo?>> getAllByChannelUrl(
      List<String> channelUrlValues) {
    final values = channelUrlValues.map((e) => [e]).toList();
    return getAllByIndex(r'channelUrl', values);
  }

  List<CMessageChangeLogInfo?> getAllByChannelUrlSync(
      List<String> channelUrlValues) {
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

  Future<Id> putByChannelUrl(CMessageChangeLogInfo object) {
    return putByIndex(r'channelUrl', object);
  }

  Id putByChannelUrlSync(CMessageChangeLogInfo object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'channelUrl', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByChannelUrl(List<CMessageChangeLogInfo> objects) {
    return putAllByIndex(r'channelUrl', objects);
  }

  List<Id> putAllByChannelUrlSync(List<CMessageChangeLogInfo> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'channelUrl', objects, saveLinks: saveLinks);
  }
}

extension CMessageChangeLogInfoQueryWhereSort
    on QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QWhere> {
  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CMessageChangeLogInfoQueryWhere on QueryBuilder<CMessageChangeLogInfo,
    CMessageChangeLogInfo, QWhereClause> {
  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhereClause>
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhereClause>
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhereClause>
      channelUrlEqualTo(String channelUrl) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelUrl',
        value: [channelUrl],
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterWhereClause>
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

extension CMessageChangeLogInfoQueryFilter on QueryBuilder<
    CMessageChangeLogInfo, CMessageChangeLogInfo, QFilterCondition> {
  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> channelUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> channelUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
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

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessageToken',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessageToken',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessageToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessageToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
          QAfterFilterCondition>
      lastMessageTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessageToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
          QAfterFilterCondition>
      lastMessageTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessageToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageToken',
        value: '',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastMessageTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessageToken',
        value: '',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPollToken',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPollToken',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPollToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPollToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPollToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPollToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastPollToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastPollToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
          QAfterFilterCondition>
      lastPollTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastPollToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
          QAfterFilterCondition>
      lastPollTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastPollToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPollToken',
        value: '',
      ));
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo,
      QAfterFilterCondition> lastPollTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastPollToken',
        value: '',
      ));
    });
  }
}

extension CMessageChangeLogInfoQueryObject on QueryBuilder<
    CMessageChangeLogInfo, CMessageChangeLogInfo, QFilterCondition> {}

extension CMessageChangeLogInfoQueryLinks on QueryBuilder<CMessageChangeLogInfo,
    CMessageChangeLogInfo, QFilterCondition> {}

extension CMessageChangeLogInfoQuerySortBy
    on QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QSortBy> {
  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      sortByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      sortByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      sortByLastMessageToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageToken', Sort.asc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      sortByLastMessageTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageToken', Sort.desc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      sortByLastPollToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPollToken', Sort.asc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      sortByLastPollTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPollToken', Sort.desc);
    });
  }
}

extension CMessageChangeLogInfoQuerySortThenBy
    on QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QSortThenBy> {
  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenByChannelUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.asc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenByChannelUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelUrl', Sort.desc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenByLastMessageToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageToken', Sort.asc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenByLastMessageTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageToken', Sort.desc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenByLastPollToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPollToken', Sort.asc);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QAfterSortBy>
      thenByLastPollTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPollToken', Sort.desc);
    });
  }
}

extension CMessageChangeLogInfoQueryWhereDistinct
    on QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QDistinct> {
  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QDistinct>
      distinctByChannelUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QDistinct>
      distinctByLastMessageToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageToken',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CMessageChangeLogInfo, CMessageChangeLogInfo, QDistinct>
      distinctByLastPollToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPollToken',
          caseSensitive: caseSensitive);
    });
  }
}

extension CMessageChangeLogInfoQueryProperty on QueryBuilder<
    CMessageChangeLogInfo, CMessageChangeLogInfo, QQueryProperty> {
  QueryBuilder<CMessageChangeLogInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CMessageChangeLogInfo, String, QQueryOperations>
      channelUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelUrl');
    });
  }

  QueryBuilder<CMessageChangeLogInfo, String?, QQueryOperations>
      lastMessageTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageToken');
    });
  }

  QueryBuilder<CMessageChangeLogInfo, String?, QQueryOperations>
      lastPollTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPollToken');
    });
  }
}
