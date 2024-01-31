// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_member.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CMemberSchema = Schema(
  name: r'CMember',
  id: BigInt.parse('3727521751473440892').toInt(),
  properties: {
    r'isBlockedByMe': PropertySchema(
      id: 0,
      name: r'isBlockedByMe',
      type: IsarType.bool,
    ),
    r'isBlockingMe': PropertySchema(
      id: 1,
      name: r'isBlockingMe',
      type: IsarType.bool,
    ),
    r'isMuted': PropertySchema(
      id: 2,
      name: r'isMuted',
      type: IsarType.bool,
    ),
    r'memberState': PropertySchema(
      id: 3,
      name: r'memberState',
      type: IsarType.byte,
      enumMap: _CMembermemberStateEnumValueMap,
    ),
    r'nickname': PropertySchema(
      id: 4,
      name: r'nickname',
      type: IsarType.string,
    ),
    r'restrictionInfo': PropertySchema(
      id: 5,
      name: r'restrictionInfo',
      type: IsarType.object,
      target: r'CRestrictionInfo',
    ),
    r'role': PropertySchema(
      id: 6,
      name: r'role',
      type: IsarType.byte,
      enumMap: _CMemberroleEnumValueMap,
    ),
    r'userId': PropertySchema(
      id: 7,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _cMemberEstimateSize,
  serialize: _cMemberSerialize,
  deserialize: _cMemberDeserialize,
  deserializeProp: _cMemberDeserializeProp,
);

int _cMemberEstimateSize(
  CMember object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nickname.length * 3;
  {
    final value = object.restrictionInfo;
    if (value != null) {
      bytesCount += 3 +
          CRestrictionInfoSchema.estimateSize(
              value, allOffsets[CRestrictionInfo]!, allOffsets);
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cMemberSerialize(
  CMember object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isBlockedByMe);
  writer.writeBool(offsets[1], object.isBlockingMe);
  writer.writeBool(offsets[2], object.isMuted);
  writer.writeByte(offsets[3], object.memberState.index);
  writer.writeString(offsets[4], object.nickname);
  writer.writeObject<CRestrictionInfo>(
    offsets[5],
    allOffsets,
    CRestrictionInfoSchema.serialize,
    object.restrictionInfo,
  );
  writer.writeByte(offsets[6], object.role.index);
  writer.writeString(offsets[7], object.userId);
}

CMember _cMemberDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CMember();
  object.isBlockedByMe = reader.readBool(offsets[0]);
  object.isBlockingMe = reader.readBool(offsets[1]);
  object.isMuted = reader.readBool(offsets[2]);
  object.memberState =
      _CMembermemberStateValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          MemberState.none;
  object.nickname = reader.readString(offsets[4]);
  object.restrictionInfo = reader.readObjectOrNull<CRestrictionInfo>(
    offsets[5],
    CRestrictionInfoSchema.deserialize,
    allOffsets,
  );
  object.role =
      _CMemberroleValueEnumMap[reader.readByteOrNull(offsets[6])] ?? Role.none;
  object.userId = reader.readString(offsets[7]);
  return object;
}

P _cMemberDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (_CMembermemberStateValueEnumMap[reader.readByteOrNull(offset)] ??
          MemberState.none) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<CRestrictionInfo>(
        offset,
        CRestrictionInfoSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (_CMemberroleValueEnumMap[reader.readByteOrNull(offset)] ??
          Role.none) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CMembermemberStateEnumValueMap = {
  'none': 0,
  'invited': 1,
  'joined': 2,
};
const _CMembermemberStateValueEnumMap = {
  0: MemberState.none,
  1: MemberState.invited,
  2: MemberState.joined,
};
const _CMemberroleEnumValueMap = {
  'none': 0,
  'operator': 1,
};
const _CMemberroleValueEnumMap = {
  0: Role.none,
  1: Role.operator,
};

extension CMemberQueryFilter
    on QueryBuilder<CMember, CMember, QFilterCondition> {
  QueryBuilder<CMember, CMember, QAfterFilterCondition> isBlockedByMeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBlockedByMe',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> isBlockingMeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isBlockingMe',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> isMutedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMuted',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> memberStateEqualTo(
      MemberState value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberState',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> memberStateGreaterThan(
    MemberState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberState',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> memberStateLessThan(
    MemberState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberState',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> memberStateBetween(
    MemberState lower,
    MemberState upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameEqualTo(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameGreaterThan(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameLessThan(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameBetween(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameStartsWith(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameEndsWith(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameContains(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameMatches(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> nicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition>
      restrictionInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'restrictionInfo',
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition>
      restrictionInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'restrictionInfo',
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> roleEqualTo(
      Role value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> roleGreaterThan(
    Role value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'role',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> roleLessThan(
    Role value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'role',
        value: value,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> roleBetween(
    Role lower,
    Role upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'role',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdEqualTo(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdGreaterThan(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdLessThan(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdBetween(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdStartsWith(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdEndsWith(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdContains(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdMatches(
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

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CMember, CMember, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension CMemberQueryObject
    on QueryBuilder<CMember, CMember, QFilterCondition> {
  QueryBuilder<CMember, CMember, QAfterFilterCondition> restrictionInfo(
      FilterQuery<CRestrictionInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'restrictionInfo');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CRestrictionInfoSchema = Schema(
  name: r'CRestrictionInfo',
  id: BigInt.parse('981966653832094849').toInt(),
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'endAt': PropertySchema(
      id: 1,
      name: r'endAt',
      type: IsarType.long,
    ),
    r'restrictionType': PropertySchema(
      id: 2,
      name: r'restrictionType',
      type: IsarType.byte,
      enumMap: _CRestrictionInforestrictionTypeEnumValueMap,
    )
  },
  estimateSize: _cRestrictionInfoEstimateSize,
  serialize: _cRestrictionInfoSerialize,
  deserialize: _cRestrictionInfoDeserialize,
  deserializeProp: _cRestrictionInfoDeserializeProp,
);

int _cRestrictionInfoEstimateSize(
  CRestrictionInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cRestrictionInfoSerialize(
  CRestrictionInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeLong(offsets[1], object.endAt);
  writer.writeByte(offsets[2], object.restrictionType.index);
}

CRestrictionInfo _cRestrictionInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CRestrictionInfo();
  object.description = reader.readStringOrNull(offsets[0]);
  object.endAt = reader.readLongOrNull(offsets[1]);
  object.restrictionType = _CRestrictionInforestrictionTypeValueEnumMap[
          reader.readByteOrNull(offsets[2])] ??
      RestrictionType.muted;
  return object;
}

P _cRestrictionInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (_CRestrictionInforestrictionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          RestrictionType.muted) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CRestrictionInforestrictionTypeEnumValueMap = {
  'muted': 0,
  'banned': 1,
};
const _CRestrictionInforestrictionTypeValueEnumMap = {
  0: RestrictionType.muted,
  1: RestrictionType.banned,
};

extension CRestrictionInfoQueryFilter
    on QueryBuilder<CRestrictionInfo, CRestrictionInfo, QFilterCondition> {
  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      endAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endAt',
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      endAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endAt',
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      endAtEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      endAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      endAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      endAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      restrictionTypeEqualTo(RestrictionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restrictionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      restrictionTypeGreaterThan(
    RestrictionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'restrictionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      restrictionTypeLessThan(
    RestrictionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'restrictionType',
        value: value,
      ));
    });
  }

  QueryBuilder<CRestrictionInfo, CRestrictionInfo, QAfterFilterCondition>
      restrictionTypeBetween(
    RestrictionType lower,
    RestrictionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'restrictionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CRestrictionInfoQueryObject
    on QueryBuilder<CRestrictionInfo, CRestrictionInfo, QFilterCondition> {}
