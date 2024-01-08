// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionCollectionCollection on Isar {
  IsarCollection<QuestionCollection> get questionCollections =>
      this.collection();
}

const QuestionCollectionSchema = CollectionSchema(
  name: r'QuestionCollection',
  id: -6570938562249556041,
  properties: {
    r'eventId': PropertySchema(
      id: 0,
      name: r'eventId',
      type: IsarType.long,
    ),
    r'question': PropertySchema(
      id: 1,
      name: r'question',
      type: IsarType.string,
    ),
    r'questionTypeDb': PropertySchema(
      id: 2,
      name: r'questionTypeDb',
      type: IsarType.string,
      enumMap: _QuestionCollectionquestionTypeDbEnumValueMap,
    )
  },
  estimateSize: _questionCollectionEstimateSize,
  serialize: _questionCollectionSerialize,
  deserialize: _questionCollectionDeserialize,
  deserializeProp: _questionCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'eventId': IndexSchema(
      id: -2707901133518603130,
      name: r'eventId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'eventId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _questionCollectionGetId,
  getLinks: _questionCollectionGetLinks,
  attach: _questionCollectionAttach,
  version: '3.1.0+1',
);

int _questionCollectionEstimateSize(
  QuestionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.question.length * 3;
  bytesCount += 3 + object.questionTypeDb.name.length * 3;
  return bytesCount;
}

void _questionCollectionSerialize(
  QuestionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.eventId);
  writer.writeString(offsets[1], object.question);
  writer.writeString(offsets[2], object.questionTypeDb.name);
}

QuestionCollection _questionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionCollection(
    eventId: reader.readLong(offsets[0]),
    id: id,
    question: reader.readString(offsets[1]),
    questionTypeDb: _QuestionCollectionquestionTypeDbValueEnumMap[
            reader.readStringOrNull(offsets[2])] ??
        QuestionTypeDb.text,
  );
  return object;
}

P _questionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (_QuestionCollectionquestionTypeDbValueEnumMap[
              reader.readStringOrNull(offset)] ??
          QuestionTypeDb.text) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _QuestionCollectionquestionTypeDbEnumValueMap = {
  r'text': r'text',
  r'radio': r'radio',
  r'checkbox': r'checkbox',
};
const _QuestionCollectionquestionTypeDbValueEnumMap = {
  r'text': QuestionTypeDb.text,
  r'radio': QuestionTypeDb.radio,
  r'checkbox': QuestionTypeDb.checkbox,
};

Id _questionCollectionGetId(QuestionCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionCollectionGetLinks(
    QuestionCollection object) {
  return [];
}

void _questionCollectionAttach(
    IsarCollection<dynamic> col, Id id, QuestionCollection object) {
  object.id = id;
}

extension QuestionCollectionQueryWhereSort
    on QueryBuilder<QuestionCollection, QuestionCollection, QWhere> {
  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhere>
      anyEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'eventId'),
      );
    });
  }
}

extension QuestionCollectionQueryWhere
    on QueryBuilder<QuestionCollection, QuestionCollection, QWhereClause> {
  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
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

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
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

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      eventIdEqualTo(int eventId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'eventId',
        value: [eventId],
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      eventIdNotEqualTo(int eventId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [],
              upper: [eventId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [eventId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [eventId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'eventId',
              lower: [],
              upper: [eventId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      eventIdGreaterThan(
    int eventId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'eventId',
        lower: [eventId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      eventIdLessThan(
    int eventId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'eventId',
        lower: [],
        upper: [eventId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterWhereClause>
      eventIdBetween(
    int lowerEventId,
    int upperEventId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'eventId',
        lower: [lowerEventId],
        includeLower: includeLower,
        upper: [upperEventId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuestionCollectionQueryFilter
    on QueryBuilder<QuestionCollection, QuestionCollection, QFilterCondition> {
  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      eventIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      eventIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      eventIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      eventIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
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

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
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

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
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

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbEqualTo(
    QuestionTypeDb value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionTypeDb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbGreaterThan(
    QuestionTypeDb value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionTypeDb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbLessThan(
    QuestionTypeDb value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionTypeDb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbBetween(
    QuestionTypeDb lower,
    QuestionTypeDb upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionTypeDb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionTypeDb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionTypeDb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionTypeDb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionTypeDb',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionTypeDb',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterFilterCondition>
      questionTypeDbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionTypeDb',
        value: '',
      ));
    });
  }
}

extension QuestionCollectionQueryObject
    on QueryBuilder<QuestionCollection, QuestionCollection, QFilterCondition> {}

extension QuestionCollectionQueryLinks
    on QueryBuilder<QuestionCollection, QuestionCollection, QFilterCondition> {}

extension QuestionCollectionQuerySortBy
    on QueryBuilder<QuestionCollection, QuestionCollection, QSortBy> {
  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      sortByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      sortByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      sortByQuestionTypeDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionTypeDb', Sort.asc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      sortByQuestionTypeDbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionTypeDb', Sort.desc);
    });
  }
}

extension QuestionCollectionQuerySortThenBy
    on QueryBuilder<QuestionCollection, QuestionCollection, QSortThenBy> {
  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenByQuestionTypeDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionTypeDb', Sort.asc);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QAfterSortBy>
      thenByQuestionTypeDbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionTypeDb', Sort.desc);
    });
  }
}

extension QuestionCollectionQueryWhereDistinct
    on QueryBuilder<QuestionCollection, QuestionCollection, QDistinct> {
  QueryBuilder<QuestionCollection, QuestionCollection, QDistinct>
      distinctByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventId');
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QDistinct>
      distinctByQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuestionCollection, QuestionCollection, QDistinct>
      distinctByQuestionTypeDb({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionTypeDb',
          caseSensitive: caseSensitive);
    });
  }
}

extension QuestionCollectionQueryProperty
    on QueryBuilder<QuestionCollection, QuestionCollection, QQueryProperty> {
  QueryBuilder<QuestionCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuestionCollection, int, QQueryOperations> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventId');
    });
  }

  QueryBuilder<QuestionCollection, String, QQueryOperations>
      questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }

  QueryBuilder<QuestionCollection, QuestionTypeDb, QQueryOperations>
      questionTypeDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionTypeDb');
    });
  }
}
