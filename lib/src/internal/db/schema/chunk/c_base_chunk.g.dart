// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_base_chunk.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

final CChunkSchema = Schema(
  name: r'CChunk',
  id: BigInt.parse('7782930986990862049').toInt(),
  properties: {
    r'latestTs': PropertySchema(
      id: 0,
      name: r'latestTs',
      type: IsarType.long,
    ),
    r'oldestTs': PropertySchema(
      id: 1,
      name: r'oldestTs',
      type: IsarType.long,
    )
  },
  estimateSize: _cChunkEstimateSize,
  serialize: _cChunkSerialize,
  deserialize: _cChunkDeserialize,
  deserializeProp: _cChunkDeserializeProp,
);

int _cChunkEstimateSize(
  CChunk object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _cChunkSerialize(
  CChunk object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.latestTs);
  writer.writeLong(offsets[1], object.oldestTs);
}

CChunk _cChunkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CChunk();
  object.latestTs = reader.readLong(offsets[0]);
  object.oldestTs = reader.readLong(offsets[1]);
  return object;
}

P _cChunkDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CChunkQueryFilter on QueryBuilder<CChunk, CChunk, QFilterCondition> {
  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> latestTsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latestTs',
        value: value,
      ));
    });
  }

  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> latestTsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latestTs',
        value: value,
      ));
    });
  }

  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> latestTsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latestTs',
        value: value,
      ));
    });
  }

  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> latestTsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latestTs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> oldestTsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'oldestTs',
        value: value,
      ));
    });
  }

  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> oldestTsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'oldestTs',
        value: value,
      ));
    });
  }

  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> oldestTsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'oldestTs',
        value: value,
      ));
    });
  }

  QueryBuilder<CChunk, CChunk, QAfterFilterCondition> oldestTsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'oldestTs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CChunkQueryObject on QueryBuilder<CChunk, CChunk, QFilterCondition> {}
