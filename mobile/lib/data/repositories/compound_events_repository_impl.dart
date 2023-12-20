import 'dart:async';

import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/domain/repositories/compound_events_repository/download_status.dart';
import 'package:project/domain/repositories/local_events_repository/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/network_checker/network_checker.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/result.dart';

class CompoundEventsRepositoryImpl implements CompoundEventsRepository {
  CompoundEventsRepositoryImpl({
    required this.remoteEventsRepository,
    required this.localEventsRepository,
  });

  @override
  final RemoteEventsRepository remoteEventsRepository;

  @override
  final LocalEventsRepository localEventsRepository;

  final _connectionChecker = locator<NetworkChecker>();

  late final bool _networkAvailable;

  Future<void> init() async {
    _networkAvailable = await _connectionChecker.networkAvailable();
  }

  final Set<int> _downloadedEventsIds = {};

  void _deleteNonexistentEvents() async {
    final savedEventsIds = (await localEventsRepository.getAllEventsIds()).toSet();

    final nonExistentEventsIds = savedEventsIds.difference(_downloadedEventsIds);

    localEventsRepository.deleteEventsByIds(nonExistentEventsIds.toList());

    _downloadedEventsIds.clear();
  }

  @override
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  }) async {
    if (!_networkAvailable) {
      return await localEventsRepository.getEvents(offset: offset, limit: limit);
    }

    final result = await remoteEventsRepository.getEvents(
      offset: offset,
      limit: limit,
    );

    if (result.isSuccess) {
      final events = result.success;

      localEventsRepository.saveEvents(events);
      _downloadedEventsIds.addAll(events.map((e) => e.id));

      if (events.length < limit) {
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
  Future<Visitor?> findVisitor(String visitorId, int eventId) async {
    if (!_networkAvailable) {
      return await remoteEventsRepository.findVisitor(visitorId, eventId);
    }

    return await localEventsRepository.findVisitor(visitorId, eventId);
  }

  @override
  Future<void> downloadVisitorsDatabase(int eventId, StreamSink<DownloadStatus> status) async {
    status.add(DownloadStatus.inProcess);

    final downloadResult = await remoteEventsRepository.downloadVisitors(eventId);

    if (downloadResult.isFailure) {
      return status.add(DownloadStatus.failure);
    }

    final visitors = downloadResult.success;

    await localEventsRepository.saveVisitors(visitors, eventId);

    status.add(DownloadStatus.success);
  }
}
