// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_user.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCUserCollection on Isar {
  IsarCollection<CUser> get cUsers => this.collection();
}

final CUserSchema = CollectionSchema(
  name: r'CUser',
  id: BigInt.parse('892440936217059961').toInt(),
  properties: {
    r'connectionStatus': PropertySchema(
      id: 0,
      name: r'connectionStatus',
      type: IsarType.byte,
      enumMap: _CUserconnectionStatusEnumValueMap,
    ),
    r'friendDiscoveryKey': PropertySchema(
      id: 1,
      name: r'friendDiscoveryKey',
      type: IsarType.string,
    ),
    r'friendName': PropertySchema(
      id: 2,
      name: r'friendName',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 3,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'lastSeenAt': PropertySchema(
      id: 4,
      name: r'lastSeenAt',
      type: IsarType.long,
    ),
    r'metaData': PropertySchema(
      id: 5,
      name: r'metaData',
      type: IsarType.string,
    ),
    r'nickname': PropertySchema(
      id: 6,
      name: r'nickname',
      type: IsarType.string,
    ),
    r'preferredLanguages': PropertySchema(
      id: 7,
      name: r'preferredLanguages',
      type: IsarType.stringList,
    ),
    r'profileUrl': PropertySchema(
      id: 8,
      name: r'profileUrl',
      type: IsarType.string,
    ),
    r'requireAuth': PropertySchema(
      id: 9,
      name: r'requireAuth',
      type: IsarType.bool,
    ),
    r'userId': PropertySchema(
      id: 10,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _cUserEstimateSize,
  serialize: _cUserSerialize,
  deserialize: _cUserDeserialize,
  deserializeProp: _cUserDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: BigInt.parse('-2005826577402374815').toInt(),
      name: r'userId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cUserGetId,
  getLinks: _cUserGetLinks,
  attach: _cUserAttach,
  version: '3.1.0+1',
);

int _cUserEstimateSize(
  CUser object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.friendDiscoveryKey.length * 3;
  bytesCount += 3 + object.friendName.length * 3;
  bytesCount += 3 + object.metaData.length * 3;
  bytesCount += 3 + object.nickname.length * 3;
  {
    final list = object.preferredLanguages;
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
  bytesCount += 3 + object.profileUrl.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cUserSerialize(
  CUser object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.connectionStatus.index);
  writer.writeString(offsets[1], object.friendDiscoveryKey);
  writer.writeString(offsets[2], object.friendName);
  writer.writeBool(offsets[3], object.isActive);
  writer.writeLong(offsets[4], object.lastSeenAt);
  writer.writeString(offsets[5], object.metaData);
  writer.writeString(offsets[6], object.nickname);
  writer.writeStringList(offsets[7], object.preferredLanguages);
  writer.writeString(offsets[8], object.profileUrl);
  writer.writeBool(offsets[9], object.requireAuth);
  writer.writeString(offsets[10], object.userId);
}

CUser _cUserDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CUser();
  object.connectionStatus =
      _CUserconnectionStatusValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          UserConnectionStatus.online;
  object.friendDiscoveryKey = reader.readString(offsets[1]);
  object.friendName = reader.readString(offsets[2]);
  object.id = id;
  object.isActive = reader.readBoolOrNull(offsets[3]);
  object.lastSeenAt = reader.readLongOrNull(offsets[4]);
  object.metaData = reader.readString(offsets[5]);
  object.nickname = reader.readString(offsets[6]);
  object.preferredLanguages = reader.readStringList(offsets[7]);
  object.profileUrl = reader.readString(offsets[8]);
  object.requireAuth = reader.readBool(offsets[9]);
  object.userId = reader.readString(offsets[10]);
  return object;
}

P _cUserDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CUserconnectionStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          UserConnectionStatus.online) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringList(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CUserconnectionStatusEnumValueMap = {
  'online': 0,
  'offline': 1,
  'notAvailable': 2,
};
const _CUserconnectionStatusValueEnumMap = {
  0: UserConnectionStatus.online,
  1: UserConnectionStatus.offline,
  2: UserConnectionStatus.notAvailable,
};

Id _cUserGetId(CUser object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cUserGetLinks(CUser object) {
  return [];
}

void _cUserAttach(IsarCollection<dynamic> col, Id id, CUser object) {
  object.id = id;
}

extension CUserByIndex on IsarCollection<CUser> {
  Future<CUser?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  CUser? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<CUser?>> getAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<CUser?> getAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(CUser object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(CUser object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<CUser> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<CUser> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension CUserQueryWhereSort on QueryBuilder<CUser, CUser, QWhere> {
  QueryBuilder<CUser, CUser, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CUserQueryWhere on QueryBuilder<CUser, CUser, QWhereClause> {
  QueryBuilder<CUser, CUser, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CUser, CUser, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> idBetween(
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

  QueryBuilder<CUser, CUser, QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterWhereClause> userIdNotEqualTo(
      String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CUserQueryFilter on QueryBuilder<CUser, CUser, QFilterCondition> {
  QueryBuilder<CUser, CUser, QAfterFilterCondition> connectionStatusEqualTo(
      UserConnectionStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectionStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> connectionStatusGreaterThan(
    UserConnectionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'connectionStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> connectionStatusLessThan(
    UserConnectionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'connectionStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> connectionStatusBetween(
    UserConnectionStatus lower,
    UserConnectionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'connectionStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendDiscoveryKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendDiscoveryKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      friendDiscoveryKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendDiscoveryKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendDiscoveryKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendDiscoveryKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendDiscoveryKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendDiscoveryKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      friendDiscoveryKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'friendDiscoveryKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendDiscoveryKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'friendDiscoveryKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendDiscoveryKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'friendDiscoveryKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendDiscoveryKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'friendDiscoveryKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      friendDiscoveryKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendDiscoveryKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      friendDiscoveryKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'friendDiscoveryKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'friendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'friendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'friendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'friendName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendName',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> friendNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'friendName',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CUser, CUser, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> isActiveEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> lastSeenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSeenAt',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> lastSeenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSeenAt',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> lastSeenAtEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> lastSeenAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> lastSeenAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSeenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> lastSeenAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSeenAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metaData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metaData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metaData',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> metaDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metaData',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> nicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> preferredLanguagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'preferredLanguages',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'preferredLanguages',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preferredLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preferredLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preferredLanguages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preferredLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preferredLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preferredLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preferredLanguages',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredLanguages',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preferredLanguages',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preferredLanguages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preferredLanguages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preferredLanguages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preferredLanguages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preferredLanguages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition>
      preferredLanguagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preferredLanguages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> profileUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> requireAuthEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireAuth',
        value: value,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CUser, CUser, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension CUserQueryObject on QueryBuilder<CUser, CUser, QFilterCondition> {}

extension CUserQueryLinks on QueryBuilder<CUser, CUser, QFilterCondition> {}

extension CUserQuerySortBy on QueryBuilder<CUser, CUser, QSortBy> {
  QueryBuilder<CUser, CUser, QAfterSortBy> sortByConnectionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByConnectionStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByFriendDiscoveryKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendDiscoveryKey', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByFriendDiscoveryKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendDiscoveryKey', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByFriendName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendName', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByFriendNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendName', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByLastSeenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByMetaData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaData', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByMetaDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaData', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByProfileUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUrl', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByProfileUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUrl', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByRequireAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CUserQuerySortThenBy on QueryBuilder<CUser, CUser, QSortThenBy> {
  QueryBuilder<CUser, CUser, QAfterSortBy> thenByConnectionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByConnectionStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByFriendDiscoveryKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendDiscoveryKey', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByFriendDiscoveryKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendDiscoveryKey', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByFriendName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendName', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByFriendNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendName', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByLastSeenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeenAt', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByMetaData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaData', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByMetaDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metaData', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByProfileUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUrl', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByProfileUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileUrl', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByRequireAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAuth', Sort.desc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CUser, CUser, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CUserQueryWhereDistinct on QueryBuilder<CUser, CUser, QDistinct> {
  QueryBuilder<CUser, CUser, QDistinct> distinctByConnectionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'connectionStatus');
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByFriendDiscoveryKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendDiscoveryKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByFriendName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByLastSeenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSeenAt');
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByMetaData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metaData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByNickname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nickname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByPreferredLanguages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preferredLanguages');
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByProfileUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByRequireAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requireAuth');
    });
  }

  QueryBuilder<CUser, CUser, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CUserQueryProperty on QueryBuilder<CUser, CUser, QQueryProperty> {
  QueryBuilder<CUser, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CUser, UserConnectionStatus, QQueryOperations>
      connectionStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connectionStatus');
    });
  }

  QueryBuilder<CUser, String, QQueryOperations> friendDiscoveryKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendDiscoveryKey');
    });
  }

  QueryBuilder<CUser, String, QQueryOperations> friendNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendName');
    });
  }

  QueryBuilder<CUser, bool?, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<CUser, int?, QQueryOperations> lastSeenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSeenAt');
    });
  }

  QueryBuilder<CUser, String, QQueryOperations> metaDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metaData');
    });
  }

  QueryBuilder<CUser, String, QQueryOperations> nicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nickname');
    });
  }

  QueryBuilder<CUser, List<String>?, QQueryOperations>
      preferredLanguagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferredLanguages');
    });
  }

  QueryBuilder<CUser, String, QQueryOperations> profileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileUrl');
    });
  }

  QueryBuilder<CUser, bool, QQueryOperations> requireAuthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requireAuth');
    });
  }

  QueryBuilder<CUser, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
