import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';

import '../../../domain/models/event.dart';
import '../../../domain/repositories/events_remote_repository/events_remote_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc(this._remoteRepository) : super(EventsState(events: [], hasReachedMax: false)) {
    on<GetEvents>(
      _onGetEvents,
      transformer: (events, mapper) => events.throttleTime(const Duration(milliseconds: 100)).switchMap(mapper),
    );
  }

  final EventsRemoteRepository _remoteRepository;

  static const _limit = 4;

  void _onGetEvents(GetEvents events, Emitter<EventsState> emit) async {
    if (state.hasReachedMax) return;

    // return emit(EventsState(events: [], hasReachedMax: true));

    final result = await _remoteRepository.getEvents(_limit, state.events.length);

    final events = result.success;

    emit(state.copyWith(events: state.events + events, hasReachedMax: events.isEmpty));
  }
}
