import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/events_repository.dart';

abstract class LocalEventsRepository implements EventsRepository {
  Future<void> saveEvents(List<Event> events);

  Future<void> saveVisitors(List<Visitor> visitors, int eventId);

  Future<void> saveQuestions(List<Question> questions, int eventId);

  Future<void> deleteEventsByIds(List<int> ids);

  Future<List<int>> getAllEventsIds();

  Future<void> deleteVisitors(int eventId);

  Future<void> deleteQuestions(int eventId);

  Stream<Event> watchEvent(int eventId);

  Future<void> deleteAllData();
}
