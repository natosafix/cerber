import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/domain/repositories/compound_events_repository/download_status.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc(
    this._event, {
    required CompoundEventsRepository compoundEventsRepository,
  })  : _compoundEventsRepository = compoundEventsRepository,
        super(EventDetailState(
          downloadStatus: DownloadStatus.unknown,
          lastDownloaded: _event.lastDownloaded,
        )) {
    on<_DownloadStatusChanged>(_onDownloadStatusChanged);
    on<DownloadDatabase>(_onDownloadDatabase);

    _subscription = _controller.stream.listen((status) => add(_DownloadStatusChanged(downloadStatus: status)));
  }

  final CompoundEventsRepository _compoundEventsRepository;

  final Event _event;

  final _controller = StreamController<DownloadStatus>();
  late final StreamSubscription<DownloadStatus> _subscription;

  void _onDownloadDatabase(DownloadDatabase event, Emitter<EventDetailState> emit) {
    _compoundEventsRepository.downloadVisitorsDatabase(_event.id, _controller.sink);
  }

  void _onDownloadStatusChanged(_DownloadStatusChanged event, Emitter<EventDetailState> emit) {
    if (event.downloadStatus == DownloadStatus.success) {
      final now = DateTime.now();
      _event.lastDownloaded = now;
      return emit(state.copyWith(
        downloadStatus: DownloadStatus.success,
        lastDownloaded: now,
      ));
    }

    emit(state.copyWith(downloadStatus: event.downloadStatus));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
