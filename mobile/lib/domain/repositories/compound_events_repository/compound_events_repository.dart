import 'dart:async';

import 'package:meta/meta.dart';
import 'package:project/domain/repositories/compound_events_repository/download_status.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';

abstract class CompoundEventsRepository implements EventsRepository {
  // downloads from remote repo and saves to local
  Future<void> downloadVisitorsDatabase(int eventId, StreamSink<DownloadStatus> status);

  @protected
  abstract final LocalEventsRepository localEventsRepository;

  @protected
  abstract final RemoteEventsRepository remoteEventsRepository;
}
