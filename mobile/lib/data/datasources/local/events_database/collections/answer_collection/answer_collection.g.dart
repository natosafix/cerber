// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnswerCollectionCollection on Isar {
  IsarCollection<AnswerCollection> get answerCollections => this.collection();
}

const AnswerCollectionSchema = CollectionSchema(
  name: r'AnswerCollection',
  id: -7844939883382642991,
  properties: {
    r'answer': PropertySchema(
      id: 0,
      name: r'answer',
      type: IsarType.string,
    )
  },
  estimateSize: _answerCollectionEstimateSize,
  serialize: _answerCollectionSerialize,
  deserialize: _answerCollectionDeserialize,
  deserializeProp: _answerCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'question': LinkSchema(
      id: -7310773584643426034,
      name: r'question',
      target: r'QuestionCollection',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _answerCollectionGetId,
  getLinks: _answerCollectionGetLinks,
  attach: _answerCollectionAttach,
  version: '3.1.0+1',
);

int _answerCollectionEstimateSize(
  AnswerCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.answer.length * 3;
  return bytesCount;
}

void _answerCollectionSerialize(
  AnswerCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.answer);
}

AnswerCollection _answerCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnswerCollection();
  object.answer = reader.readString(offsets[0]);
  object.id = id;
  return object;
}

P _answerCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _answerCollectionGetId(AnswerCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _answerCollectionGetLinks(AnswerCollection object) {
  return [object.question];
}

void _answerCollectionAttach(
    IsarCollection<dynamic> col, Id id, AnswerCollection object) {
  object.id = id;
  object.question
      .attach(col, col.isar.collection<QuestionCollection>(), r'question', id);
}

extension AnswerCollectionQueryWhereSort
    on QueryBuilder<AnswerCollection, AnswerCollection, QWhere> {
  QueryBuilder<AnswerCollection, AnswerCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnswerCollectionQueryWhere
    on QueryBuilder<AnswerCollection, AnswerCollection, QWhereClause> {
  QueryBuilder<AnswerCollection, AnswerCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterWhereClause>
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

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterWhereClause> idBetween(
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

extension AnswerCollectionQueryFilter
    on QueryBuilder<AnswerCollection, AnswerCollection, QFilterCondition> {
  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'answer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answer',
        value: '',
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      answerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'answer',
        value: '',
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
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

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
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

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      idBetween(
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

extension AnswerCollectionQueryObject
    on QueryBuilder<AnswerCollection, AnswerCollection, QFilterCondition> {}

extension AnswerCollectionQueryLinks
    on QueryBuilder<AnswerCollection, AnswerCollection, QFilterCondition> {
  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      question(FilterQuery<QuestionCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'question');
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterFilterCondition>
      questionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'question', 0, true, 0, true);
    });
  }
}

extension AnswerCollectionQuerySortBy
    on QueryBuilder<AnswerCollection, AnswerCollection, QSortBy> {
  QueryBuilder<AnswerCollection, AnswerCollection, QAfterSortBy>
      sortByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterSortBy>
      sortByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }
}

extension AnswerCollectionQuerySortThenBy
    on QueryBuilder<AnswerCollection, AnswerCollection, QSortThenBy> {
  QueryBuilder<AnswerCollection, AnswerCollection, QAfterSortBy>
      thenByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterSortBy>
      thenByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnswerCollection, AnswerCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension AnswerCollectionQueryWhereDistinct
    on QueryBuilder<AnswerCollection, AnswerCollection, QDistinct> {
  QueryBuilder<AnswerCollection, AnswerCollection, QDistinct> distinctByAnswer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answer', caseSensitive: caseSensitive);
    });
  }
}

extension AnswerCollectionQueryProperty
    on QueryBuilder<AnswerCollection, AnswerCollection, QQueryProperty> {
  QueryBuilder<AnswerCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnswerCollection, String, QQueryOperations> answerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answer');
    });
  }
}
