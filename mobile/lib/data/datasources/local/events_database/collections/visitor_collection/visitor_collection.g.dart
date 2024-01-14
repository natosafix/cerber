// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVisitorCollectionCollection on Isar {
  IsarCollection<VisitorCollection> get visitorCollections => this.collection();
}

const VisitorCollectionSchema = CollectionSchema(
  name: r'VisitorCollection',
  id: 7580165231345664196,
  properties: {
    r'answersIds': PropertySchema(
      id: 0,
      name: r'answersIds',
      type: IsarType.longList,
    ),
    r'eventId': PropertySchema(
      id: 1,
      name: r'eventId',
      type: IsarType.long,
    ),
    r'qrCodeScannedTime': PropertySchema(
      id: 2,
      name: r'qrCodeScannedTime',
      type: IsarType.dateTime,
    ),
    r'ticket': PropertySchema(
      id: 3,
      name: r'ticket',
      type: IsarType.object,
      target: r'TicketEmbedded',
    ),
    r'visitorId': PropertySchema(
      id: 4,
      name: r'visitorId',
      type: IsarType.string,
    )
  },
  estimateSize: _visitorCollectionEstimateSize,
  serialize: _visitorCollectionSerialize,
  deserialize: _visitorCollectionDeserialize,
  deserializeProp: _visitorCollectionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'visitorId_eventId': IndexSchema(
      id: -1333239492455269434,
      name: r'visitorId_eventId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'visitorId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'eventId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
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
  embeddedSchemas: {r'TicketEmbedded': TicketEmbeddedSchema},
  getId: _visitorCollectionGetId,
  getLinks: _visitorCollectionGetLinks,
  attach: _visitorCollectionAttach,
  version: '3.1.0+1',
);

int _visitorCollectionEstimateSize(
  VisitorCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.answersIds.length * 8;
  bytesCount += 3 +
      TicketEmbeddedSchema.estimateSize(
          object.ticket, allOffsets[TicketEmbedded]!, allOffsets);
  bytesCount += 3 + object.visitorId.length * 3;
  return bytesCount;
}

void _visitorCollectionSerialize(
  VisitorCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.answersIds);
  writer.writeLong(offsets[1], object.eventId);
  writer.writeDateTime(offsets[2], object.qrCodeScannedTime);
  writer.writeObject<TicketEmbedded>(
    offsets[3],
    allOffsets,
    TicketEmbeddedSchema.serialize,
    object.ticket,
  );
  writer.writeString(offsets[4], object.visitorId);
}

VisitorCollection _visitorCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VisitorCollection(
    answersIds: reader.readLongList(offsets[0]) ?? [],
    eventId: reader.readLong(offsets[1]),
    qrCodeScannedTime: reader.readDateTimeOrNull(offsets[2]),
    ticket: reader.readObjectOrNull<TicketEmbedded>(
          offsets[3],
          TicketEmbeddedSchema.deserialize,
          allOffsets,
        ) ??
        TicketEmbedded(),
    visitorId: reader.readString(offsets[4]),
  );
  return object;
}

P _visitorCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<TicketEmbedded>(
            offset,
            TicketEmbeddedSchema.deserialize,
            allOffsets,
          ) ??
          TicketEmbedded()) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _visitorCollectionGetId(VisitorCollection object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _visitorCollectionGetLinks(
    VisitorCollection object) {
  return [];
}

void _visitorCollectionAttach(
    IsarCollection<dynamic> col, Id id, VisitorCollection object) {}

extension VisitorCollectionByIndex on IsarCollection<VisitorCollection> {
  Future<VisitorCollection?> getByVisitorIdEventId(
      String visitorId, int eventId) {
    return getByIndex(r'visitorId_eventId', [visitorId, eventId]);
  }

  VisitorCollection? getByVisitorIdEventIdSync(String visitorId, int eventId) {
    return getByIndexSync(r'visitorId_eventId', [visitorId, eventId]);
  }

  Future<bool> deleteByVisitorIdEventId(String visitorId, int eventId) {
    return deleteByIndex(r'visitorId_eventId', [visitorId, eventId]);
  }

  bool deleteByVisitorIdEventIdSync(String visitorId, int eventId) {
    return deleteByIndexSync(r'visitorId_eventId', [visitorId, eventId]);
  }

  Future<List<VisitorCollection?>> getAllByVisitorIdEventId(
      List<String> visitorIdValues, List<int> eventIdValues) {
    final len = visitorIdValues.length;
    assert(eventIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([visitorIdValues[i], eventIdValues[i]]);
    }

    return getAllByIndex(r'visitorId_eventId', values);
  }

  List<VisitorCollection?> getAllByVisitorIdEventIdSync(
      List<String> visitorIdValues, List<int> eventIdValues) {
    final len = visitorIdValues.length;
    assert(eventIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([visitorIdValues[i], eventIdValues[i]]);
    }

    return getAllByIndexSync(r'visitorId_eventId', values);
  }

  Future<int> deleteAllByVisitorIdEventId(
      List<String> visitorIdValues, List<int> eventIdValues) {
    final len = visitorIdValues.length;
    assert(eventIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([visitorIdValues[i], eventIdValues[i]]);
    }

    return deleteAllByIndex(r'visitorId_eventId', values);
  }

  int deleteAllByVisitorIdEventIdSync(
      List<String> visitorIdValues, List<int> eventIdValues) {
    final len = visitorIdValues.length;
    assert(eventIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([visitorIdValues[i], eventIdValues[i]]);
    }

    return deleteAllByIndexSync(r'visitorId_eventId', values);
  }

  Future<Id> putByVisitorIdEventId(VisitorCollection object) {
    return putByIndex(r'visitorId_eventId', object);
  }

  Id putByVisitorIdEventIdSync(VisitorCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'visitorId_eventId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByVisitorIdEventId(List<VisitorCollection> objects) {
    return putAllByIndex(r'visitorId_eventId', objects);
  }

  List<Id> putAllByVisitorIdEventIdSync(List<VisitorCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'visitorId_eventId', objects,
        saveLinks: saveLinks);
  }
}

extension VisitorCollectionQueryWhereSort
    on QueryBuilder<VisitorCollection, VisitorCollection, QWhere> {
  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhere> anyEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'eventId'),
      );
    });
  }
}

extension VisitorCollectionQueryWhere
    on QueryBuilder<VisitorCollection, VisitorCollection, QWhereClause> {
  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      visitorIdEqualToAnyEventId(String visitorId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'visitorId_eventId',
        value: [visitorId],
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      visitorIdNotEqualToAnyEventId(String visitorId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [],
              upper: [visitorId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [visitorId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [visitorId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [],
              upper: [visitorId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      visitorIdEventIdEqualTo(String visitorId, int eventId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'visitorId_eventId',
        value: [visitorId, eventId],
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      visitorIdEqualToEventIdNotEqualTo(String visitorId, int eventId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [visitorId],
              upper: [visitorId, eventId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [visitorId, eventId],
              includeLower: false,
              upper: [visitorId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [visitorId, eventId],
              includeLower: false,
              upper: [visitorId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'visitorId_eventId',
              lower: [visitorId],
              upper: [visitorId, eventId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      visitorIdEqualToEventIdGreaterThan(
    String visitorId,
    int eventId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'visitorId_eventId',
        lower: [visitorId, eventId],
        includeLower: include,
        upper: [visitorId],
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      visitorIdEqualToEventIdLessThan(
    String visitorId,
    int eventId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'visitorId_eventId',
        lower: [visitorId],
        upper: [visitorId, eventId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      visitorIdEqualToEventIdBetween(
    String visitorId,
    int lowerEventId,
    int upperEventId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'visitorId_eventId',
        lower: [visitorId, lowerEventId],
        includeLower: includeLower,
        upper: [visitorId, upperEventId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
      eventIdEqualTo(int eventId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'eventId',
        value: [eventId],
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
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

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
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

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
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

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterWhereClause>
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

extension VisitorCollectionQueryFilter
    on QueryBuilder<VisitorCollection, VisitorCollection, QFilterCondition> {
  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answersIds',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answersIds',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answersIds',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answersIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answersIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answersIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answersIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answersIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answersIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      answersIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answersIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      eventIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
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

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
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

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
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

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      qrCodeScannedTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'qrCodeScannedTime',
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      qrCodeScannedTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'qrCodeScannedTime',
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      qrCodeScannedTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrCodeScannedTime',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      qrCodeScannedTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrCodeScannedTime',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      qrCodeScannedTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrCodeScannedTime',
        value: value,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      qrCodeScannedTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrCodeScannedTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visitorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'visitorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'visitorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'visitorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'visitorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'visitorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'visitorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'visitorId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visitorId',
        value: '',
      ));
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      visitorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'visitorId',
        value: '',
      ));
    });
  }
}

extension VisitorCollectionQueryObject
    on QueryBuilder<VisitorCollection, VisitorCollection, QFilterCondition> {
  QueryBuilder<VisitorCollection, VisitorCollection, QAfterFilterCondition>
      ticket(FilterQuery<TicketEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ticket');
    });
  }
}

extension VisitorCollectionQueryLinks
    on QueryBuilder<VisitorCollection, VisitorCollection, QFilterCondition> {}

extension VisitorCollectionQuerySortBy
    on QueryBuilder<VisitorCollection, VisitorCollection, QSortBy> {
  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      sortByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      sortByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      sortByQrCodeScannedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeScannedTime', Sort.asc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      sortByQrCodeScannedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeScannedTime', Sort.desc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      sortByVisitorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitorId', Sort.asc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      sortByVisitorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitorId', Sort.desc);
    });
  }
}

extension VisitorCollectionQuerySortThenBy
    on QueryBuilder<VisitorCollection, VisitorCollection, QSortThenBy> {
  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByQrCodeScannedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeScannedTime', Sort.asc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByQrCodeScannedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeScannedTime', Sort.desc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByVisitorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitorId', Sort.asc);
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QAfterSortBy>
      thenByVisitorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitorId', Sort.desc);
    });
  }
}

extension VisitorCollectionQueryWhereDistinct
    on QueryBuilder<VisitorCollection, VisitorCollection, QDistinct> {
  QueryBuilder<VisitorCollection, VisitorCollection, QDistinct>
      distinctByAnswersIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answersIds');
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QDistinct>
      distinctByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventId');
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QDistinct>
      distinctByQrCodeScannedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrCodeScannedTime');
    });
  }

  QueryBuilder<VisitorCollection, VisitorCollection, QDistinct>
      distinctByVisitorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visitorId', caseSensitive: caseSensitive);
    });
  }
}

extension VisitorCollectionQueryProperty
    on QueryBuilder<VisitorCollection, VisitorCollection, QQueryProperty> {
  QueryBuilder<VisitorCollection, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<VisitorCollection, List<int>, QQueryOperations>
      answersIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answersIds');
    });
  }

  QueryBuilder<VisitorCollection, int, QQueryOperations> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventId');
    });
  }

  QueryBuilder<VisitorCollection, DateTime?, QQueryOperations>
      qrCodeScannedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodeScannedTime');
    });
  }

  QueryBuilder<VisitorCollection, TicketEmbedded, QQueryOperations>
      ticketProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ticket');
    });
  }

  QueryBuilder<VisitorCollection, String, QQueryOperations>
      visitorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visitorId');
    });
  }
}
