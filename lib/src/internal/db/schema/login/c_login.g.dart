// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_login.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCLoginCollection on Isar {
  IsarCollection<CLogin> get cLogins => this.collection();
}

final CLoginSchema = CollectionSchema(
  name: r'CLogin',
  id: BigInt.parse('-487089198461928861').toInt(),
  properties: {
    r'appInfo': PropertySchema(
      id: 0,
      name: r'appInfo',
      type: IsarType.object,
      target: r'CAppInfo',
    ),
    r'lastConnectedAt': PropertySchema(
      id: 1,
      name: r'lastConnectedAt',
      type: IsarType.long,
    ),
    r'maxUnreadCountOnSuperGroup': PropertySchema(
      id: 2,
      name: r'maxUnreadCountOnSuperGroup',
      type: IsarType.long,
    ),
    r'reconnectConfig': PropertySchema(
      id: 3,
      name: r'reconnectConfig',
      type: IsarType.object,
      target: r'CReconnectConfiguration',
    ),
    r'services': PropertySchema(
      id: 4,
      name: r'services',
      type: IsarType.byteList,
      enumMap: _CLoginservicesEnumValueMap,
    ),
    r'uploadSizeLimit': PropertySchema(
      id: 5,
      name: r'uploadSizeLimit',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _cLoginEstimateSize,
  serialize: _cLoginSerialize,
  deserialize: _cLoginDeserialize,
  deserializeProp: _cLoginDeserializeProp,
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
  embeddedSchemas: {
    r'CAppInfo': CAppInfoSchema,
    r'CNotificationInfo': CNotificationInfoSchema,
    r'CReconnectConfiguration': CReconnectConfigurationSchema
  },
  getId: _cLoginGetId,
  getLinks: _cLoginGetLinks,
  attach: _cLoginAttach,
  version: '3.1.0+1',
);

int _cLoginEstimateSize(
  CLogin object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.appInfo;
    if (value != null) {
      bytesCount += 3 +
          CAppInfoSchema.estimateSize(value, allOffsets[CAppInfo]!, allOffsets);
    }
  }
  {
    final value = object.reconnectConfig;
    if (value != null) {
      bytesCount += 3 +
          CReconnectConfigurationSchema.estimateSize(
              value, allOffsets[CReconnectConfiguration]!, allOffsets);
    }
  }
  bytesCount += 3 + object.services.length;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cLoginSerialize(
  CLogin object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<CAppInfo>(
    offsets[0],
    allOffsets,
    CAppInfoSchema.serialize,
    object.appInfo,
  );
  writer.writeLong(offsets[1], object.lastConnectedAt);
  writer.writeLong(offsets[2], object.maxUnreadCountOnSuperGroup);
  writer.writeObject<CReconnectConfiguration>(
    offsets[3],
    allOffsets,
    CReconnectConfigurationSchema.serialize,
    object.reconnectConfig,
  );
  writer.writeByteList(
      offsets[4], object.services.map((e) => e.index).toList());
  writer.writeLong(offsets[5], object.uploadSizeLimit);
  writer.writeString(offsets[6], object.userId);
}

CLogin _cLoginDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CLogin();
  object.appInfo = reader.readObjectOrNull<CAppInfo>(
    offsets[0],
    CAppInfoSchema.deserialize,
    allOffsets,
  );
  object.id = id;
  object.lastConnectedAt = reader.readLongOrNull(offsets[1]);
  object.maxUnreadCountOnSuperGroup = reader.readLongOrNull(offsets[2]);
  object.reconnectConfig = reader.readObjectOrNull<CReconnectConfiguration>(
    offsets[3],
    CReconnectConfigurationSchema.deserialize,
    allOffsets,
  );
  object.services = reader
          .readByteList(offsets[4])
          ?.map((e) => _CLoginservicesValueEnumMap[e] ?? Service.chat)
          .toList() ??
      [];
  object.uploadSizeLimit = reader.readLongOrNull(offsets[5]);
  object.userId = reader.readString(offsets[6]);
  return object;
}

P _cLoginDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<CAppInfo>(
        offset,
        CAppInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<CReconnectConfiguration>(
        offset,
        CReconnectConfigurationSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader
              .readByteList(offset)
              ?.map((e) => _CLoginservicesValueEnumMap[e] ?? Service.chat)
              .toList() ??
          []) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CLoginservicesEnumValueMap = {
  'chat': 0,
  'feed': 1,
};
const _CLoginservicesValueEnumMap = {
  0: Service.chat,
  1: Service.feed,
};

Id _cLoginGetId(CLogin object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cLoginGetLinks(CLogin object) {
  return [];
}

void _cLoginAttach(IsarCollection<dynamic> col, Id id, CLogin object) {
  object.id = id;
}

extension CLoginByIndex on IsarCollection<CLogin> {
  Future<CLogin?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  CLogin? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<CLogin?>> getAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<CLogin?> getAllByUserIdSync(List<String> userIdValues) {
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

  Future<Id> putByUserId(CLogin object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(CLogin object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<CLogin> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<CLogin> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension CLoginQueryWhereSort on QueryBuilder<CLogin, CLogin, QWhere> {
  QueryBuilder<CLogin, CLogin, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CLoginQueryWhere on QueryBuilder<CLogin, CLogin, QWhereClause> {
  QueryBuilder<CLogin, CLogin, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CLogin, CLogin, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterWhereClause> idBetween(
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

  QueryBuilder<CLogin, CLogin, QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterWhereClause> userIdNotEqualTo(
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

extension CLoginQueryFilter on QueryBuilder<CLogin, CLogin, QFilterCondition> {
  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> appInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appInfo',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> appInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appInfo',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> lastConnectedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastConnectedAt',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      lastConnectedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastConnectedAt',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> lastConnectedAtEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastConnectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      lastConnectedAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastConnectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> lastConnectedAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastConnectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> lastConnectedAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastConnectedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      maxUnreadCountOnSuperGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxUnreadCountOnSuperGroup',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      maxUnreadCountOnSuperGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxUnreadCountOnSuperGroup',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      maxUnreadCountOnSuperGroupEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxUnreadCountOnSuperGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      maxUnreadCountOnSuperGroupGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxUnreadCountOnSuperGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      maxUnreadCountOnSuperGroupLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxUnreadCountOnSuperGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      maxUnreadCountOnSuperGroupBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxUnreadCountOnSuperGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> reconnectConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reconnectConfig',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      reconnectConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reconnectConfig',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesElementEqualTo(
      Service value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'services',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      servicesElementGreaterThan(
    Service value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'services',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesElementLessThan(
    Service value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'services',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesElementBetween(
    Service lower,
    Service upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'services',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'services',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'services',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'services',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'services',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'services',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> servicesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'services',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> uploadSizeLimitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uploadSizeLimit',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      uploadSizeLimitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uploadSizeLimit',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> uploadSizeLimitEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uploadSizeLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition>
      uploadSizeLimitGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uploadSizeLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> uploadSizeLimitLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uploadSizeLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> uploadSizeLimitBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uploadSizeLimit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdEqualTo(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdGreaterThan(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdLessThan(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdBetween(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdStartsWith(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdEndsWith(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdMatches(
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

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension CLoginQueryObject on QueryBuilder<CLogin, CLogin, QFilterCondition> {
  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> appInfo(
      FilterQuery<CAppInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'appInfo');
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterFilterCondition> reconnectConfig(
      FilterQuery<CReconnectConfiguration> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reconnectConfig');
    });
  }
}

extension CLoginQueryLinks on QueryBuilder<CLogin, CLogin, QFilterCondition> {}

extension CLoginQuerySortBy on QueryBuilder<CLogin, CLogin, QSortBy> {
  QueryBuilder<CLogin, CLogin, QAfterSortBy> sortByLastConnectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnectedAt', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> sortByLastConnectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnectedAt', Sort.desc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy>
      sortByMaxUnreadCountOnSuperGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnreadCountOnSuperGroup', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy>
      sortByMaxUnreadCountOnSuperGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnreadCountOnSuperGroup', Sort.desc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> sortByUploadSizeLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadSizeLimit', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> sortByUploadSizeLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadSizeLimit', Sort.desc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CLoginQuerySortThenBy on QueryBuilder<CLogin, CLogin, QSortThenBy> {
  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenByLastConnectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnectedAt', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenByLastConnectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastConnectedAt', Sort.desc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy>
      thenByMaxUnreadCountOnSuperGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnreadCountOnSuperGroup', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy>
      thenByMaxUnreadCountOnSuperGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxUnreadCountOnSuperGroup', Sort.desc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenByUploadSizeLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadSizeLimit', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenByUploadSizeLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadSizeLimit', Sort.desc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CLogin, CLogin, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CLoginQueryWhereDistinct on QueryBuilder<CLogin, CLogin, QDistinct> {
  QueryBuilder<CLogin, CLogin, QDistinct> distinctByLastConnectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastConnectedAt');
    });
  }

  QueryBuilder<CLogin, CLogin, QDistinct>
      distinctByMaxUnreadCountOnSuperGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxUnreadCountOnSuperGroup');
    });
  }

  QueryBuilder<CLogin, CLogin, QDistinct> distinctByServices() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'services');
    });
  }

  QueryBuilder<CLogin, CLogin, QDistinct> distinctByUploadSizeLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uploadSizeLimit');
    });
  }

  QueryBuilder<CLogin, CLogin, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CLoginQueryProperty on QueryBuilder<CLogin, CLogin, QQueryProperty> {
  QueryBuilder<CLogin, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CLogin, CAppInfo?, QQueryOperations> appInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appInfo');
    });
  }

  QueryBuilder<CLogin, int?, QQueryOperations> lastConnectedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastConnectedAt');
    });
  }

  QueryBuilder<CLogin, int?, QQueryOperations>
      maxUnreadCountOnSuperGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxUnreadCountOnSuperGroup');
    });
  }

  QueryBuilder<CLogin, CReconnectConfiguration?, QQueryOperations>
      reconnectConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reconnectConfig');
    });
  }

  QueryBuilder<CLogin, List<Service>, QQueryOperations> servicesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'services');
    });
  }

  QueryBuilder<CLogin, int?, QQueryOperations> uploadSizeLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uploadSizeLimit');
    });
  }

  QueryBuilder<CLogin, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CAppInfoSchema = Schema(
  name: r'CAppInfo',
  id: BigInt.parse('-4428982506234657140').toInt(),
  properties: {
    r'allowSdkStatsUpload': PropertySchema(
      id: 0,
      name: r'allowSdkStatsUpload',
      type: IsarType.bool,
    ),
    r'attributesInUse': PropertySchema(
      id: 1,
      name: r'attributesInUse',
      type: IsarType.stringList,
    ),
    r'emojiHash': PropertySchema(
      id: 2,
      name: r'emojiHash',
      type: IsarType.string,
    ),
    r'notificationInfo': PropertySchema(
      id: 3,
      name: r'notificationInfo',
      type: IsarType.object,
      target: r'CNotificationInfo',
    ),
    r'premiumFeatureList': PropertySchema(
      id: 4,
      name: r'premiumFeatureList',
      type: IsarType.stringList,
    ),
    r'uploadSizeLimit': PropertySchema(
      id: 5,
      name: r'uploadSizeLimit',
      type: IsarType.long,
    ),
    r'useReaction': PropertySchema(
      id: 6,
      name: r'useReaction',
      type: IsarType.bool,
    )
  },
  estimateSize: _cAppInfoEstimateSize,
  serialize: _cAppInfoSerialize,
  deserialize: _cAppInfoDeserialize,
  deserializeProp: _cAppInfoDeserializeProp,
);

int _cAppInfoEstimateSize(
  CAppInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.attributesInUse.length * 3;
  {
    for (var i = 0; i < object.attributesInUse.length; i++) {
      final value = object.attributesInUse[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.emojiHash.length * 3;
  {
    final value = object.notificationInfo;
    if (value != null) {
      bytesCount += 3 +
          CNotificationInfoSchema.estimateSize(
              value, allOffsets[CNotificationInfo]!, allOffsets);
    }
  }
  bytesCount += 3 + object.premiumFeatureList.length * 3;
  {
    for (var i = 0; i < object.premiumFeatureList.length; i++) {
      final value = object.premiumFeatureList[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _cAppInfoSerialize(
  CAppInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.allowSdkStatsUpload);
  writer.writeStringList(offsets[1], object.attributesInUse);
  writer.writeString(offsets[2], object.emojiHash);
  writer.writeObject<CNotificationInfo>(
    offsets[3],
    allOffsets,
    CNotificationInfoSchema.serialize,
    object.notificationInfo,
  );
  writer.writeStringList(offsets[4], object.premiumFeatureList);
  writer.writeLong(offsets[5], object.uploadSizeLimit);
  writer.writeBool(offsets[6], object.useReaction);
}

CAppInfo _cAppInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CAppInfo();
  object.allowSdkStatsUpload = reader.readBool(offsets[0]);
  object.attributesInUse = reader.readStringList(offsets[1]) ?? [];
  object.emojiHash = reader.readString(offsets[2]);
  object.notificationInfo = reader.readObjectOrNull<CNotificationInfo>(
    offsets[3],
    CNotificationInfoSchema.deserialize,
    allOffsets,
  );
  object.premiumFeatureList = reader.readStringList(offsets[4]) ?? [];
  object.uploadSizeLimit = reader.readLong(offsets[5]);
  object.useReaction = reader.readBool(offsets[6]);
  return object;
}

P _cAppInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<CNotificationInfo>(
        offset,
        CNotificationInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CAppInfoQueryFilter
    on QueryBuilder<CAppInfo, CAppInfo, QFilterCondition> {
  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      allowSdkStatsUploadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowSdkStatsUpload',
        value: value,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attributesInUse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attributesInUse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attributesInUse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attributesInUse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'attributesInUse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'attributesInUse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'attributesInUse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'attributesInUse',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attributesInUse',
        value: '',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'attributesInUse',
        value: '',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attributesInUse',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attributesInUse',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attributesInUse',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attributesInUse',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attributesInUse',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      attributesInUseLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attributesInUse',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emojiHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emojiHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emojiHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emojiHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emojiHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emojiHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emojiHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> emojiHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emojiHash',
        value: '',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      emojiHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emojiHash',
        value: '',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      notificationInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationInfo',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      notificationInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationInfo',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumFeatureList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'premiumFeatureList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'premiumFeatureList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'premiumFeatureList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'premiumFeatureList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'premiumFeatureList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'premiumFeatureList',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'premiumFeatureList',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumFeatureList',
        value: '',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'premiumFeatureList',
        value: '',
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'premiumFeatureList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'premiumFeatureList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'premiumFeatureList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'premiumFeatureList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'premiumFeatureList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      premiumFeatureListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'premiumFeatureList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      uploadSizeLimitEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uploadSizeLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      uploadSizeLimitGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uploadSizeLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      uploadSizeLimitLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uploadSizeLimit',
        value: value,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition>
      uploadSizeLimitBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uploadSizeLimit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> useReactionEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'useReaction',
        value: value,
      ));
    });
  }
}

extension CAppInfoQueryObject
    on QueryBuilder<CAppInfo, CAppInfo, QFilterCondition> {
  QueryBuilder<CAppInfo, CAppInfo, QAfterFilterCondition> notificationInfo(
      FilterQuery<CNotificationInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'notificationInfo');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CNotificationInfoSchema = Schema(
  name: r'CNotificationInfo',
  id: BigInt.parse('2013809996163728336').toInt(),
  properties: {
    r'feedChannels': PropertySchema(
      id: 0,
      name: r'feedChannels',
      type: IsarType.string,
    ),
    r'isEnabled': PropertySchema(
      id: 1,
      name: r'isEnabled',
      type: IsarType.bool,
    ),
    r'settingsUpdatedAt': PropertySchema(
      id: 2,
      name: r'settingsUpdatedAt',
      type: IsarType.long,
    ),
    r'templateListToken': PropertySchema(
      id: 3,
      name: r'templateListToken',
      type: IsarType.string,
    )
  },
  estimateSize: _cNotificationInfoEstimateSize,
  serialize: _cNotificationInfoSerialize,
  deserialize: _cNotificationInfoDeserialize,
  deserializeProp: _cNotificationInfoDeserializeProp,
);

int _cNotificationInfoEstimateSize(
  CNotificationInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.feedChannels.length * 3;
  {
    final value = object.templateListToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cNotificationInfoSerialize(
  CNotificationInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.feedChannels);
  writer.writeBool(offsets[1], object.isEnabled);
  writer.writeLong(offsets[2], object.settingsUpdatedAt);
  writer.writeString(offsets[3], object.templateListToken);
}

CNotificationInfo _cNotificationInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CNotificationInfo();
  object.feedChannels = reader.readString(offsets[0]);
  object.isEnabled = reader.readBool(offsets[1]);
  object.settingsUpdatedAt = reader.readLong(offsets[2]);
  object.templateListToken = reader.readStringOrNull(offsets[3]);
  return object;
}

P _cNotificationInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CNotificationInfoQueryFilter
    on QueryBuilder<CNotificationInfo, CNotificationInfo, QFilterCondition> {
  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedChannels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'feedChannels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'feedChannels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'feedChannels',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'feedChannels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'feedChannels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'feedChannels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'feedChannels',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedChannels',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      feedChannelsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'feedChannels',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      isEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      settingsUpdatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'settingsUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      settingsUpdatedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'settingsUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      settingsUpdatedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'settingsUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      settingsUpdatedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'settingsUpdatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'templateListToken',
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'templateListToken',
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateListToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'templateListToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'templateListToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'templateListToken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'templateListToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'templateListToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'templateListToken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'templateListToken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateListToken',
        value: '',
      ));
    });
  }

  QueryBuilder<CNotificationInfo, CNotificationInfo, QAfterFilterCondition>
      templateListTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'templateListToken',
        value: '',
      ));
    });
  }
}

extension CNotificationInfoQueryObject
    on QueryBuilder<CNotificationInfo, CNotificationInfo, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CReconnectConfigurationSchema = Schema(
  name: r'CReconnectConfiguration',
  id: BigInt.parse('4193108221451927222').toInt(),
  properties: {
    r'interval': PropertySchema(
      id: 0,
      name: r'interval',
      type: IsarType.double,
    ),
    r'maxInterval': PropertySchema(
      id: 1,
      name: r'maxInterval',
      type: IsarType.double,
    ),
    r'maximumRetryCount': PropertySchema(
      id: 2,
      name: r'maximumRetryCount',
      type: IsarType.long,
    ),
    r'multiplier': PropertySchema(
      id: 3,
      name: r'multiplier',
      type: IsarType.long,
    )
  },
  estimateSize: _cReconnectConfigurationEstimateSize,
  serialize: _cReconnectConfigurationSerialize,
  deserialize: _cReconnectConfigurationDeserialize,
  deserializeProp: _cReconnectConfigurationDeserializeProp,
);

int _cReconnectConfigurationEstimateSize(
  CReconnectConfiguration object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _cReconnectConfigurationSerialize(
  CReconnectConfiguration object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.interval);
  writer.writeDouble(offsets[1], object.maxInterval);
  writer.writeLong(offsets[2], object.maximumRetryCount);
  writer.writeLong(offsets[3], object.multiplier);
}

CReconnectConfiguration _cReconnectConfigurationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CReconnectConfiguration();
  object.interval = reader.readDouble(offsets[0]);
  object.maxInterval = reader.readDouble(offsets[1]);
  object.maximumRetryCount = reader.readLong(offsets[2]);
  object.multiplier = reader.readLong(offsets[3]);
  return object;
}

P _cReconnectConfigurationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CReconnectConfigurationQueryFilter on QueryBuilder<
    CReconnectConfiguration, CReconnectConfiguration, QFilterCondition> {
  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> intervalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interval',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> intervalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interval',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> intervalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interval',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> intervalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maxIntervalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxInterval',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maxIntervalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxInterval',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maxIntervalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxInterval',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maxIntervalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxInterval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maximumRetryCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maximumRetryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maximumRetryCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maximumRetryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maximumRetryCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maximumRetryCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> maximumRetryCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maximumRetryCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> multiplierEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'multiplier',
        value: value,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> multiplierGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'multiplier',
        value: value,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> multiplierLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'multiplier',
        value: value,
      ));
    });
  }

  QueryBuilder<CReconnectConfiguration, CReconnectConfiguration,
      QAfterFilterCondition> multiplierBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'multiplier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CReconnectConfigurationQueryObject on QueryBuilder<
    CReconnectConfiguration, CReconnectConfiguration, QFilterCondition> {}
