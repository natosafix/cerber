import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/new_visitor_id.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/network_checker/network_checker.dart';

class AddNewVisitorUsecase {
  final _networkChecker = locator<NetworkChecker>();
  final _localEventsRepository = locator<LocalEventsRepository>();
  final _remoteEventsRepository = locator<RemoteEventsRepository>();

  Future<NewVisitorId> call({
    required int ticketId,
    required int eventId,
    required List<FilledAnswer> filledAnswers,
  }) async {
    if (await _networkChecker.networkAvailable()) {
      final NewVisitorId? id = await _remoteEventsRepository.addNewVisitorAnswers(
        ticketId,
        filledAnswers,
        eventId,
      );

      if (id != null) {
        return id;
      }
    }

    final NewVisitorId? id = await _localEventsRepository.addNewVisitorAnswers(
      ticketId,
      filledAnswers,
      eventId,
    );

    return id!;
  }
}
