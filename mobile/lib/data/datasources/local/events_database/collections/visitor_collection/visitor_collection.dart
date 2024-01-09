import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/visitor_collection/ticket_embedded.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/utils/extensions/fast_hash_x.dart';

part 'visitor_collection.g.dart';

@collection
class VisitorCollection {
  Id get isarId => visitorId.fastHash();

  @Index(composite: [CompositeIndex('eventId')], unique: true, replace: true)
  String visitorId;

  @Index()
  int eventId;

  List<Id> answersIds;

  TicketEmbedded ticket;

  VisitorCollection({
    required this.visitorId,
    required this.eventId,
    required this.answersIds,
    required this.ticket,
  });

  static Visitor toModel(VisitorCollection visitor, Map<Question, Answer> answers) {
    return Visitor(
      id: visitor.visitorId,
      questionsMap: answers,
      ticket: TicketEmbedded.toModel(visitor.ticket),
    );
  }

  factory VisitorCollection.fromModel(Visitor visitor, int eventId) {
    return VisitorCollection(
      visitorId: visitor.id,
      eventId: eventId,
      answersIds: visitor.questionsMap.values.map((a) => a.id).toList(),
      ticket: TicketEmbedded.fromModel(visitor.ticket),
    );
  }
}
