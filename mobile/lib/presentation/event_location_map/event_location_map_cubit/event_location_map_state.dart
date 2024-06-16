part of 'event_location_map_cubit.dart';

sealed class EventLocationMapState {
  EventLocationMapState({
    required this.mapController,
  });

  final MapController mapController;
}

final class Loading extends EventLocationMapState {
  Loading({required super.mapController});
}

final class LoadFailed extends EventLocationMapState {
  LoadFailed({required super.mapController});
}

final class LoadSuccees extends EventLocationMapState {
  LoadSuccees({required super.mapController});
}
