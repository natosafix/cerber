import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/download_status.dart';
import 'package:project/domain/usecases/download_database_usecase.dart';
import 'package:project/domain/usecases/send_generated_visitors_usecase.dart';
import 'package:project/domain/usecases/watch_event_usecase.dart';
import 'package:project/domain/usecases/watch_generated_visitors_count_usecase.dart';
import 'package:project/utils/locator.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc(this._event)
      : super(EventDetailState(
          downloadStatus: DownloadStatus.unknown,
          lastDownloaded: _event.lastDownloaded,
          generatedVisitorsCount: 0,
        )) {
    on<_DownloadStatusChanged>(_onDownloadStatusChanged);
    on<_EventChanged>(_onEventChanged);
    on<_GeneratedVisitorCountChanged>(_onGeneratedVisitorCountChanged);
    on<DownloadDatabase>(_onDownloadDatabase);
    on<SyncGeneratedVisitors>(_onSyncGeneratedVisitors);

    _downloadStatusSub = _downloadStatusController.stream.listen((status) {
      add(_DownloadStatusChanged(status));
    });

    _eventSub = _watchEventUsecase(eventId: _event.id).listen((event) {
      add(_EventChanged(event));
    });

    _generatedVisitorsCountSub = _watchGeneratedVisitorsUsecase(eventId: _event.id).listen((count) {
      add(_GeneratedVisitorCountChanged(count));
    });
  }

  late final StreamSubscription<DownloadStatus> _downloadStatusSub;
  late final StreamSubscription<Event> _eventSub;
  late final StreamSubscription<int> _generatedVisitorsCountSub;
  final _downloadStatusController = StreamController<DownloadStatus>();

  final _watchEventUsecase = locator<WatchEventUsecase>();
  final _downloadDatabaseUsecase = locator<DownloadDatabaseUsecase>();
  final _sendGeneratedVisitorsUsecase = locator<SendGeneratedVisitorsUsecase>();
  final _watchGeneratedVisitorsUsecase = locator<WatchGeneratedVisitorsCountUsecase>();

  final Event _event;

  void _onDownloadStatusChanged(_DownloadStatusChanged event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(downloadStatus: event.downloadStatus));
  }

  void _onEventChanged(_EventChanged event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(lastDownloaded: event.event.lastDownloaded));
  }

  void _onGeneratedVisitorCountChanged(
      _GeneratedVisitorCountChanged event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(generatedVisitorsCount: event.count));
  }

  void _onDownloadDatabase(DownloadDatabase event, Emitter<EventDetailState> emit) {
    _downloadDatabaseUsecase(eventId: _event.id, statusSink: _downloadStatusController.sink);
  }

  void _onSyncGeneratedVisitors(SyncGeneratedVisitors event, Emitter<EventDetailState> emit) {
    _sendGeneratedVisitorsUsecase(eventId: _event.id);
  }

  @override
  Future<void> close() async {
    await _downloadStatusSub.cancel();
    await _eventSub.cancel();
    await _generatedVisitorsCountSub.cancel();
    return super.close();
  }
}
