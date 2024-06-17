import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/events_repository.dart';

abstract class LocalEventsRepository implements EventsRepository {
  Future<void> saveEvents(List<Event> events);

  Future<void> saveVisitors(List<Visitor> visitors, int eventId);

  Future<void> saveQuestions(List<Question> questions, int eventId);

  Future<void> saveTickets(List<Ticket> tickets, int eventId);

  Future<void> deleteVisitors(int eventId);

  Future<void> deleteQuestions(int eventId);

  Future<void> deleteTickets(int eventId);

  Future<void> deleteEventsByIds(List<int> ids);

  Future<List<int>> getAllEventsIds();

  Stream<Event> watchEvent(int eventId);

  Future<void> deleteAllData();

  Future<void> setVisitorQrCodeScanned(String visitorId, int eventId);

  Future<List<Visitor>> getGeneratedVisitors(int eventId);

  Stream<int> getGeneratedVisitorsCountStream(int eventId);

  Future<void> setVisitorSynced(String oldId, String newId, int eventId);
}
