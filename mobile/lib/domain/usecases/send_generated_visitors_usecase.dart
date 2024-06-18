import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/new_visitor_id.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/locator.dart';

class SendGeneratedVisitorsUsecase {
  final _localEventsRepository = locator<LocalEventsRepository>();
  final _remoteEventsRepository = locator<RemoteEventsRepository>();

  Future<void> call({required int eventId}) async {
    final generatedVisitors = await _localEventsRepository.getGeneratedVisitors(eventId);

    for (final Visitor generatedVisitor in generatedVisitors) {
      final filledAnswers = [
        for (final MapEntry<Question, Answer> entry in generatedVisitor.questionsMap.entries)
          FilledAnswer(
            questionId: entry.key.id,
            answers: entry.value.answers,
          ),
      ];

      final NewVisitorId? newId = await _remoteEventsRepository.addNewVisitorAnswers(
        generatedVisitor.ticket.id,
        filledAnswers,
        eventId,
      );

      if (newId == null) {
        break;
      }

      _localEventsRepository.setVisitorSynced(
        generatedVisitor.id,
        newId.id,
        eventId,
      );
    }
  }
}
