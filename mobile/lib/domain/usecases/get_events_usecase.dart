import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/network_checker/network_checker.dart';
import 'package:project/utils/result.dart';

class GetEventsUsecase {
  final _networkChecker = locator<NetworkChecker>();
  final _localEventsRepository = locator<LocalEventsRepository>();
  final _remoteEventsRepository = locator<RemoteEventsRepository>();

  final Set<int> _remoteEventsIds = {};

  Future<Result<List<Event>, Exception>> call({
    required int offset,
    required int limit,
  }) async {
    final networkUnavailable = !(await _networkChecker.networkAvailable());

    if (networkUnavailable) {
      return await _localEventsRepository.getEvents(offset: offset, limit: limit);
    }

    final Result<List<Event>, Exception> result = await _remoteEventsRepository.getEvents(
      offset: offset,
      limit: limit,
    );

    if (result.isSuccess) {
      _saveEvents(result.success, limit);
    }

    return result;
  }

  Future<void> _saveEvents(List<Event> events, int limit) async {
    await _localEventsRepository.saveEvents(events);

    _remoteEventsIds.addAll(events.map((e) => e.id));

    if (events.length < limit) {
      // local db stores all events that have ever been received from the api
      // it also includes events that were deleted on the frontend
      // thus in order to avoid showing them while offline they need to be removed
      // we do this after we have received all existing events from the api
      _deleteNonexistentEvents();
    }
  }

  void _deleteNonexistentEvents() async {
    final savedEventsIds = (await _localEventsRepository.getAllEventsIds()).toSet();

    final nonExistentEventsIds = savedEventsIds.difference(_remoteEventsIds).toList();

    await _localEventsRepository.deleteEventsByIds(nonExistentEventsIds);

    _remoteEventsIds.clear();
  }
}
