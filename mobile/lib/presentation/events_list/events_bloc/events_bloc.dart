import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/events_repository/events_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc(this._eventsRepository) : super(EventsState.initial()) {
    on<GetEvents>(_onGetEvents);

    state.pagingController.addPageRequestListener((pageKey) {
      add(GetEvents(pageKey: pageKey));
    });
  }

  final EventsRepository _eventsRepository;

  static const _limit = 5;

  void _onGetEvents(GetEvents event, Emitter<EventsState> emit) async {
    final result = await _eventsRepository.getEvents(
      offset: event.pageKey,
      limit: _limit,
    );

    final controller = state.pagingController;

    if (result.isFailure) {
      controller.error = result.failure;
      return;
    }

    final newEvents = result.success;

    final isLastPage = newEvents.length < _limit;

    if (isLastPage) {
      controller.appendLastPage(newEvents);
    } else {
      final nextPageKey = event.pageKey + newEvents.length;
      controller.appendPage(newEvents, nextPageKey);
    }
  }
}
