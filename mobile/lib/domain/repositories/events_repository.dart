import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/utils/result.dart';

typedef NewVisitorId = String;

abstract class EventsRepository {
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  });

  Future<Visitor?> findVisitor(String visitorId, int eventId);

  Future<List<Question>?> getQuestions(int eventId);

  Future<List<Ticket>?> getTickets(int eventId);
  
  Future<NewVisitorId?> addNewVisitorAnswers(
    int ticketId,
    List<FilledAnswer> filledAnswers,
    int eventId,
  );
}
