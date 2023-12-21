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
  EventDetailBloc(
    this._event, {
    required CompoundEventsRepository compoundEventsRepository,
  })  : _compoundEventsRepository = compoundEventsRepository,
        super(EventDetailState(
          downloadStatus: DownloadStatus.unknown,
          lastDownloaded: _event.lastDownloaded,
        )) {
    on<_DownloadStatusChanged>(_onDownloadStatusChanged);
    on<_EventChanged>(_onEventChanged);
    on<DownloadDatabase>(_onDownloadDatabase);

    _downloadStatusSubscription = _controller.stream.listen((status) {
      add(_DownloadStatusChanged(status));
    });
    _eventSubscription = _localEventsRepository.watchEvent(_event.id).listen((event) {
      add(_EventChanged(event));
    });
  }

  final CompoundEventsRepository _compoundEventsRepository;
  final _localEventsRepository = locator<LocalEventsRepository>();

  final Event _event;

  final _controller = StreamController<DownloadStatus>();

  late final StreamSubscription<DownloadStatus> _downloadStatusSubscription;
  late final StreamSubscription<Event> _eventSubscription;

  void _onDownloadDatabase(DownloadDatabase event, Emitter<EventDetailState> emit) {
    _compoundEventsRepository.downloadVisitorsDatabase(_event.id, _controller.sink);
  }

  void _onDownloadStatusChanged(_DownloadStatusChanged event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(downloadStatus: event.downloadStatus));
  }

  void _onEventChanged(_EventChanged event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(lastDownloaded: event.event.lastDownloaded));
  }

  @override
  Future<void> close() async {
    await _downloadStatusSubscription.cancel();
    await _eventSubscription.cancel();
    return super.close();
  }
}
