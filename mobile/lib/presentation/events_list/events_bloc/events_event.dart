part of 'events_bloc.dart';

sealed class EventsEvent {}

final class GetEvents extends EventsEvent {
  GetEvents({required this.pageKey});

  final int pageKey;
}

final class Refresh extends EventsEvent {}
