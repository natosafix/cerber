part of 'events_bloc.dart';

final class EventsState {
  final List<Event> events;
  final bool hasReachedMax;

  EventsState({
    required this.events,
    required this.hasReachedMax,
  });

  EventsState copyWith({
    List<Event>? events,
    bool? hasReachedMax,
  }) {
    return EventsState(
      events: events ?? this.events,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
