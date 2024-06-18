import 'dart:async';

import 'package:project/domain/models/download_status.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/locator.dart';

class DownloadDatabaseUsecase {
  final _localEventsRepository = locator<LocalEventsRepository>();
  final _remoteEventsRepository = locator<RemoteEventsRepository>();

  Future<void> call({
    required int eventId,
    required StreamSink<DownloadStatus> statusSink,
  }) async {
    statusSink.add(DownloadStatus.inProcess);

    final visitorsResult = await _remoteEventsRepository.getVisitors(eventId);

    if (visitorsResult.isFailure) {
      return statusSink.add(DownloadStatus.failure);
    }

    final visitors = visitorsResult.success;

    await _localEventsRepository.deleteVisitors(eventId);
    await _localEventsRepository.saveVisitors(visitors, eventId);

    final getQuestionsResult = await _remoteEventsRepository.getQuestions(eventId);

    if (getQuestionsResult.isFailure) {
      return statusSink.add(DownloadStatus.failure);
    }

    await _localEventsRepository.deleteQuestions(eventId);
    await _localEventsRepository.saveQuestions(getQuestionsResult.success, eventId);

    final tickets = await _remoteEventsRepository.getTickets(eventId);

    if (tickets == null) {
      return statusSink.add(DownloadStatus.failure);
    }

    await _localEventsRepository.deleteTickets(eventId);
    await _localEventsRepository.saveTickets(tickets, eventId);

    statusSink.add(DownloadStatus.success);
  }
}
