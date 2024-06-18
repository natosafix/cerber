import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/utils/locator.dart';

class WatchGeneratedVisitorsCountUsecase {
  final _localEventsRepository = locator<LocalEventsRepository>();

  Stream<int> call({required int eventId}) async* {
    yield* _localEventsRepository.watchGeneratedVisitorsCount(eventId);
  }
}
