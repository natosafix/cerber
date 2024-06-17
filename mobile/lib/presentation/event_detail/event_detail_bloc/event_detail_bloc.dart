import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/domain/repositories/compound_events_repository/download_status.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
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

    _downloadStatusSubscription = _downloadStatusController.stream.listen((status) {
      add(_DownloadStatusChanged(status));
    });

    _eventSubscription = _localEventsRepository.watchEvent(_event.id).listen((event) {
      add(_EventChanged(event));
    });

    _generatedVisitorsCountSubscription =
        _localEventsRepository.getGeneratedVisitorsCountStream(_event.id).listen((count) {
      add(_GeneratedVisitorCountChanged(count));
    });
  }

  late final StreamSubscription<DownloadStatus> _downloadStatusSubscription;
  late final StreamSubscription<Event> _eventSubscription;
  late final StreamSubscription<int> _generatedVisitorsCountSubscription;
  final _downloadStatusController = StreamController<DownloadStatus>();

  final _compoundEventsRepository = locator<CompoundEventsRepository>();
  final _localEventsRepository = locator<LocalEventsRepository>();

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
    _compoundEventsRepository.downloadDatabase(_event.id, _downloadStatusController.sink);
  }

  void _onSyncGeneratedVisitors(SyncGeneratedVisitors event, Emitter<EventDetailState> emit) async {
    await _compoundEventsRepository.sendGeneratedVisitors(_event.id);
  }

  @override
  Future<void> close() async {
    await _downloadStatusSubscription.cancel();
    await _eventSubscription.cancel();
    await _generatedVisitorsCountSubscription.cancel();
    return super.close();
  }
}
