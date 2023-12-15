part of 'events_bloc.dart';

final class EventsState {
  final PagingController<int, Event> pagingController;

  EventsState({
    required this.pagingController,
  });

  factory EventsState.initial() {
    return EventsState(
      pagingController: PagingController(firstPageKey: 0),
    );
  }
}
