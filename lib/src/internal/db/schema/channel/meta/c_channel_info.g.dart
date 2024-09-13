// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_channel_info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCChannelInfoCollection on Isar {
  IsarCollection<CChannelInfo> get cChannelInfos => this.collection();
}

final CChannelInfoSchema = CollectionSchema(
  name: r'CChannelInfo',
  id: BigInt.parse('1788819051338150060').toInt(),
  properties: {
    r'isChannelBackSyncCompleted': PropertySchema(
      id: 0,
      name: r'isChannelBackSyncCompleted',
      type: IsarType.bool,
    ),
    r'lastChannelToken': PropertySchema(
      id: 1,
      name: r'lastChannelToken',
      type: IsarType.string,
    )
  },
  estimateSize: _cChannelInfoEstimateSize,
  serialize: _cChannelInfoSerialize,
  deserialize: _cChannelInfoDeserialize,
  deserializeProp: _cChannelInfoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cChannelInfoGetId,
  getLinks: _cChannelInfoGetLinks,
  attach: _cChannelInfoAttach,
  version: '3.1.0+1',
);

int _cChannelInfoEstimateSize(
  CChannelInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lastChannelToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cChannelInfoSerialize(
  CChannelInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isChannelBackSyncCompleted);
  writer.writeString(offsets[1], object.lastChannelToken);
}

CChannelInfo _cChannelInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CChannelInfo();
  object.id = id;
  object.isChannelBackSyncCompleted = reader.readBool(offsets[0]);
  object.lastChannelToken = reader.readStringOrNull(offsets[1]);
  return object;
}

P _cChannelInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cChannelInfoGetId(CChannelInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cChannelInfoGetLinks(CChannelInfo object) {
  return [];
}

void _cChannelInfoAttach(
    IsarCollection<dynamic> col, Id id, CChannelInfo object) {
  object.id = id;
}

extension CChannelInfoQueryWhereSort
    on QueryBuilder<CChannelInfo, CChannelInfo, QWhere> {
  QueryBuilder<CChannelInfo, CChannelInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CChannelInfoQueryWhere
    on QueryBuilder<CChannelInfo, CChannelInfo, QWhereClause> {
  QueryBuilder<CChannelInfo, CChannelInfo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterWhereClause> idBetween(
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
}

extension CChannelInfoQueryFilter
    on QueryBuilder<CChannelInfo, CChannelInfo, QFilterCondition> {
  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      isChannelBackSyncCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isChannelBackSyncCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastChannelToken',
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastChannelToken',
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastChannelToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastChannelToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastChannelToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastChannelToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastChannelToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastChannelToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastChannelToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastChannelToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastChannelToken',
        value: '',
      ));
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterFilterCondition>
      lastChannelTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastChannelToken',
        value: '',
      ));
    });
  }
}

extension CChannelInfoQueryObject
    on QueryBuilder<CChannelInfo, CChannelInfo, QFilterCondition> {}

extension CChannelInfoQueryLinks
    on QueryBuilder<CChannelInfo, CChannelInfo, QFilterCondition> {}

extension CChannelInfoQuerySortBy
    on QueryBuilder<CChannelInfo, CChannelInfo, QSortBy> {
  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      sortByIsChannelBackSyncCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChannelBackSyncCompleted', Sort.asc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      sortByIsChannelBackSyncCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChannelBackSyncCompleted', Sort.desc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      sortByLastChannelToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChannelToken', Sort.asc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      sortByLastChannelTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChannelToken', Sort.desc);
    });
  }
}

extension CChannelInfoQuerySortThenBy
    on QueryBuilder<CChannelInfo, CChannelInfo, QSortThenBy> {
  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      thenByIsChannelBackSyncCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChannelBackSyncCompleted', Sort.asc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      thenByIsChannelBackSyncCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChannelBackSyncCompleted', Sort.desc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      thenByLastChannelToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChannelToken', Sort.asc);
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QAfterSortBy>
      thenByLastChannelTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChannelToken', Sort.desc);
    });
  }
}

extension CChannelInfoQueryWhereDistinct
    on QueryBuilder<CChannelInfo, CChannelInfo, QDistinct> {
  QueryBuilder<CChannelInfo, CChannelInfo, QDistinct>
      distinctByIsChannelBackSyncCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isChannelBackSyncCompleted');
    });
  }

  QueryBuilder<CChannelInfo, CChannelInfo, QDistinct>
      distinctByLastChannelToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastChannelToken',
          caseSensitive: caseSensitive);
    });
  }
}

extension CChannelInfoQueryProperty
    on QueryBuilder<CChannelInfo, CChannelInfo, QQueryProperty> {
  QueryBuilder<CChannelInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CChannelInfo, bool, QQueryOperations>
      isChannelBackSyncCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isChannelBackSyncCompleted');
    });
  }

  QueryBuilder<CChannelInfo, String?, QQueryOperations>
      lastChannelTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastChannelToken');
    });
  }
}
