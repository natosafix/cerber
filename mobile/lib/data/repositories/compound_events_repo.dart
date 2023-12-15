import 'dart:io';

import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/events_repository/events_repository.dart';
import 'package:project/domain/repositories/local_events_repository/local_events_repository.dart';
import 'package:project/utils/result.dart';

class CompoundEventsRepository implements EventsRepository {
  CompoundEventsRepository({
    required EventsRepository remoteEventsRepo,
    required LocalEventsRepository localEventsRepo,
  })  : _remoteEventsRepo = remoteEventsRepo,
        _localEventsRepo = localEventsRepo;

  final EventsRepository _remoteEventsRepo;
  final LocalEventsRepository _localEventsRepo;

  late final bool _networkAvailable;

  Future<void> init() async {
    _networkAvailable = await _checkNetworkAvailability();
  }

  Future<bool> _checkNetworkAvailability() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  final Set<String> _downloadedEventsIds = {};

  void _deleteNonexistentEvents() async {
    final savedEventsIds = (await _localEventsRepo.getAllEventsIds()).toSet();

    final nonExistentEventsIds = savedEventsIds.difference(_downloadedEventsIds);

    _localEventsRepo.deleteEventsByIds(nonExistentEventsIds.toList());

    _downloadedEventsIds.clear();
  }

  @override
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  }) async {
    if (!_networkAvailable) {
      return await _localEventsRepo.getEvents(offset: offset, limit: limit);
    }

    final result = await _remoteEventsRepo.getEvents(
      offset: offset,
      limit: limit,
    );

    if (result.isSuccess) {
      final events = result.success;
      final count = events.length;

      _localEventsRepo.saveEvents(events);
      _downloadedEventsIds.addAll(events.map((e) => e.id));

      if (count < limit) {
        // local db stores all events that have ever been received from the api
        // it also includes events that were deleted on the frontend
        // thus in order to avoid showing them while offline they need to be removed
        // we do this after we have received all existing events from the api
        _deleteNonexistentEvents();
      }
    }

    return result;
  }

  @override
  Future<Result<List<Visitor>, Exception>> getVisitors({
    required String eventId,
    required int limit,
    required int offset,
  }) async {
    if (!_networkAvailable) {
      return await _localEventsRepo.getVisitors(eventId: eventId, limit: limit, offset: offset);
    }
    
    final result = await _remoteEventsRepo.getVisitors(
      eventId: eventId,
      limit: limit,
      offset: offset,
    );

    if (result.isSuccess) {
      _localEventsRepo.saveVisitors(result.success, eventId);
    }

    return result;
  }
}
