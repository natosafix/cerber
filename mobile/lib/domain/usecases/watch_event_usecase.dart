import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/utils/locator.dart';

class WatchEventUsecase {
  final _localEventsRepository = locator<LocalEventsRepository>();

  Stream<Event> call({required int eventId}) async* {
    yield* _localEventsRepository.watchEvent(eventId);
  }
}
