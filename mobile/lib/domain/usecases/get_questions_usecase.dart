import 'package:project/domain/models/question.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/network_checker/network_checker.dart';
import 'package:project/utils/result.dart';

class GetQuestionsUsecase {
  final _networkChecker = locator<NetworkChecker>();
  final _localEventsRepository = locator<LocalEventsRepository>();
  final _remoteEventsRepository = locator<RemoteEventsRepository>();

  Future<Result<List<Question>, Exception>> call({
    required int eventId,
  }) async {
    if (await _networkChecker.networkAvailable()) {
      return await _remoteEventsRepository.getQuestions(eventId);
    }

    return await _localEventsRepository.getQuestions(eventId);
  }
}
