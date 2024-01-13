import 'dart:async';

import 'package:meta/meta.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/qr_code_data.dart';
import 'package:project/domain/repositories/compound_events_repository/download_status.dart';
import 'package:project/domain/repositories/compound_events_repository/qr_code_process_result.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';

abstract class CompoundEventsRepository implements EventsRepository {
  // downloads from remote repo and saves to local
  Future<void> downloadDatabase(int eventId, StreamSink<DownloadStatus> status);

  Future<QrCodeProcessResult> processQrCode(QrCodeData qrCodeData, Event event);

  Future<QrCodeData> generateQrCode(Event event);

  @protected
  abstract final LocalEventsRepository localEventsRepository;

  @protected
  abstract final RemoteEventsRepository remoteEventsRepository;
}
