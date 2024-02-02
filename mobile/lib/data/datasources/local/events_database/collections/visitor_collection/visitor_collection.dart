import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/ticket_collection/ticket_collection.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/utils/extensions/fast_hash_x.dart';
import 'package:uuid/uuid.dart';

part 'visitor_collection.g.dart';

@collection
class VisitorCollection {
  Id get isarId => visitorId.fastHash();

  @Index(composite: [CompositeIndex('eventId')], unique: true, replace: true)
  String visitorId;

  @Index()
  int eventId;

  List<Id> answersIds;

  int ticketId;

  DateTime? qrCodeScannedTime;

  VisitorCollection({
    required this.visitorId,
    required this.eventId,
    required this.answersIds,
    required this.ticketId,
    required this.qrCodeScannedTime,
  });

  VisitorCollection.autoId({
    required this.eventId,
    required this.answersIds,
    required this.ticketId,
    required this.qrCodeScannedTime,
  }) : visitorId = const Uuid().v4();

  static Visitor toModel(VisitorCollection visitor, TicketCollection ticket, Map<Question, Answer> answers) {
    return Visitor(
      id: visitor.visitorId,
      questionsMap: answers,
      ticket: TicketCollection.toModel(ticket),
      qrCodeScannedTime: visitor.qrCodeScannedTime,
    );
  }

  factory VisitorCollection.fromModel(Visitor visitor, int eventId) {
    return VisitorCollection(
      visitorId: visitor.id,
      eventId: eventId,
      answersIds: visitor.questionsMap.values.map((a) => a.id).toList(),
      ticketId: visitor.ticket.id,
      qrCodeScannedTime: visitor.qrCodeScannedTime,
    );
  }
}
