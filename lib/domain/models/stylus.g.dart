// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylus.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStylusCollection on Isar {
  IsarCollection<Stylus> get stylus => this.collection();
}

const StylusSchema = CollectionSchema(
  name: r'Stylus',
  id: 8140183465306714225,
  properties: {
    r'isRetired': PropertySchema(
      id: 0,
      name: r'isRetired',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'playtime': PropertySchema(
      id: 2,
      name: r'playtime',
      type: IsarType.long,
    ),
    r'stylusId': PropertySchema(
      id: 3,
      name: r'stylusId',
      type: IsarType.long,
    )
  },
  estimateSize: _stylusEstimateSize,
  serialize: _stylusSerialize,
  deserialize: _stylusDeserialize,
  deserializeProp: _stylusDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _stylusGetId,
  getLinks: _stylusGetLinks,
  attach: _stylusAttach,
  version: '3.1.0+1',
);

int _stylusEstimateSize(
  Stylus object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _stylusSerialize(
  Stylus object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isRetired);
  writer.writeString(offsets[1], object.name);
  writer.writeLong(offsets[2], object.playtime);
  writer.writeLong(offsets[3], object.stylusId);
}

Stylus _stylusDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stylus(
    isRetired: reader.readBool(offsets[0]),
    name: reader.readString(offsets[1]),
    playtime: reader.readLong(offsets[2]),
    stylusId: reader.readLong(offsets[3]),
  );
  object.id = id;
  return object;
}

P _stylusDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stylusGetId(Stylus object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stylusGetLinks(Stylus object) {
  return [];
}

void _stylusAttach(IsarCollection<dynamic> col, Id id, Stylus object) {
  object.id = id;
}

extension StylusQueryWhereSort on QueryBuilder<Stylus, Stylus, QWhere> {
  QueryBuilder<Stylus, Stylus, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StylusQueryWhere on QueryBuilder<Stylus, Stylus, QWhereClause> {
  QueryBuilder<Stylus, Stylus, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Stylus, Stylus, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterWhereClause> idBetween(
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

extension StylusQueryFilter on QueryBuilder<Stylus, Stylus, QFilterCondition> {
  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> isRetiredEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRetired',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> playtimeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playtime',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> playtimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playtime',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> playtimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playtime',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> playtimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playtime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> stylusIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stylusId',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> stylusIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stylusId',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> stylusIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stylusId',
        value: value,
      ));
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterFilterCondition> stylusIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stylusId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StylusQueryObject on QueryBuilder<Stylus, Stylus, QFilterCondition> {}

extension StylusQueryLinks on QueryBuilder<Stylus, Stylus, QFilterCondition> {}

extension StylusQuerySortBy on QueryBuilder<Stylus, Stylus, QSortBy> {
  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByIsRetired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByIsRetiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.desc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByPlaytime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByPlaytimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.desc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByStylusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stylusId', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> sortByStylusIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stylusId', Sort.desc);
    });
  }
}

extension StylusQuerySortThenBy on QueryBuilder<Stylus, Stylus, QSortThenBy> {
  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByIsRetired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByIsRetiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRetired', Sort.desc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByPlaytime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByPlaytimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playtime', Sort.desc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByStylusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stylusId', Sort.asc);
    });
  }

  QueryBuilder<Stylus, Stylus, QAfterSortBy> thenByStylusIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stylusId', Sort.desc);
    });
  }
}

extension StylusQueryWhereDistinct on QueryBuilder<Stylus, Stylus, QDistinct> {
  QueryBuilder<Stylus, Stylus, QDistinct> distinctByIsRetired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRetired');
    });
  }

  QueryBuilder<Stylus, Stylus, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Stylus, Stylus, QDistinct> distinctByPlaytime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playtime');
    });
  }

  QueryBuilder<Stylus, Stylus, QDistinct> distinctByStylusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stylusId');
    });
  }
}

extension StylusQueryProperty on QueryBuilder<Stylus, Stylus, QQueryProperty> {
  QueryBuilder<Stylus, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Stylus, bool, QQueryOperations> isRetiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRetired');
    });
  }

  QueryBuilder<Stylus, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Stylus, int, QQueryOperations> playtimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playtime');
    });
  }

  QueryBuilder<Stylus, int, QQueryOperations> stylusIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stylusId');
    });
  }
}
