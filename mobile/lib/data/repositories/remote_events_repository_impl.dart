import 'package:dio/dio.dart';
import 'package:project/data/datasources/remote/events_service/events_service.dart';
import 'package:project/data/datasources/remote/events_service/mappers/answer_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/event_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/filled_answer_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/question_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/ticket_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/visitor_mapper.dart';
import 'package:project/data/datasources/remote/events_service/requests/send_answers_api_request.dart';
import 'package:project/data/datasources/remote/events_service/responses/question_api_response.dart';
import 'package:project/data/datasources/remote/events_service/responses/visitor_api_response.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/result.dart';

class RemoteEventsRepositoryImpl implements RemoteEventsRepository {
  RemoteEventsRepositoryImpl({
    required EventsService eventsService,
  }) : _eventsService = eventsService;

  final EventsService _eventsService;

  @override
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await _eventsService.getEvents(offset, limit);
      final events = response.map((e) => e.toModel()).toList();
      return Success(events);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Visitor?> findVisitor(String visitorId, int eventId) async {
    try {
      final visitorResponse = await _eventsService.getVisitor(visitorId);
      final questionsResponse = await _eventsService.getQuestions(eventId);

      return _matchQuestionsWithVisitors([visitorResponse], questionsResponse).first;
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<Result<List<Visitor>, DioException>> getVisitors(int eventId) async {
    try {
      final questionsResponse = await _eventsService.getQuestions(eventId);
      final visitorsResponse = await _eventsService.getVisitors(eventId);

      return Success(_matchQuestionsWithVisitors(visitorsResponse, questionsResponse));
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  List<Visitor> _matchQuestionsWithVisitors(
    List<VisitorApiResponse> visitorsApi,
    List<QuestionApiResponse> questionsApi,
  ) {
    final questions = questionsApi.map((e) => e.toModel());

    return visitorsApi.map((visitorApi) {
      final answers = visitorApi.answers.map((e) => e.toModel());
      final questionsMap = {
        for (final question in questions) question: answers.firstWhere((a) => a.questionId == question.id)
      };
      return visitorApi.toModel(questionsMap);
    }).toList();
  }

  @override
  Future<List<Question>?> getQuestions(int eventId) async {
    try {
      final questionsApi = await _eventsService.getQuestions(eventId);
      return questionsApi.map((e) => e.toModel()).toList();
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<NewVisitorId?> addNewVisitorAnswers(
    int ticketId,
    List<FilledAnswer> filledAnswers,
    int eventId,
  ) async {
    final request = SendAnswersApiRequest(
      ticketId: ticketId,
      answers: filledAnswers.map((e) => e.toApi()).toList(),
    );
    try {
      final response = await _eventsService.sendAnswers(request);
      return response;
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<List<Ticket>?> getTickets(int eventId) async {
    try {
      final ticketsResponse = await _eventsService.getTickets(eventId);
      return ticketsResponse.map((e) => e.toModel()).toList();
    } on DioException catch (_) {
      return null;
    }
  }
}
