import 'dart:io';

import '../../domain/models/event.dart';
import '../../domain/models/visitor.dart';
import '../../domain/repositories/events_repository/events_repository.dart';
import '../../domain/repositories/events_repository/requests/get_visitors_request.dart';
import '../../domain/repositories/local_events_repository/local_event_repository.dart';
import '../../utils/result.dart';

class CompoundEventsRepository implements EventsRepository {
  CompoundEventsRepository({
    required EventsRepository remoteEventsRepo,
    required LocalEventsRepository localEventsRepo,
  })  : _remoteEventsRepo = remoteEventsRepo,
        _localEventsRepo = localEventsRepo;

  final EventsRepository _remoteEventsRepo;
  final LocalEventsRepository _localEventsRepo;

  late bool networkAvailable;

  Future init() async {
    networkAvailable = await checkNetworkAvailability();
  }

  Future<bool> checkNetworkAvailability() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<Result<List<Event>, Exception>> getEvents(int limit, int offset) async {
    if (networkAvailable) {
      final result = await _remoteEventsRepo.getEvents(limit, offset);
      if (result.isSuccess) _localEventsRepo.saveEvents(result.success);
      return result;
    }

    return await _localEventsRepo.getEvents(limit, offset);
  }

  @override
  Future<Result<List<Visitor>, Exception>> getVisitors(GetVisitorsRequest getVisitorsRequest) async {
    if (networkAvailable) {
      final result = await _remoteEventsRepo.getVisitors(getVisitorsRequest);
      if (result.isSuccess) _localEventsRepo.saveVisitors(result.success, getVisitorsRequest.eventId);
      return result;
    }

    return await _localEventsRepo.getVisitors(getVisitorsRequest);
  }
}
