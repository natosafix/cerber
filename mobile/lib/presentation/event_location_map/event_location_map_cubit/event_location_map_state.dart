part of 'event_location_map_cubit.dart';

sealed class EventLocationMapState {}

final class Loading extends EventLocationMapState {}

final class LoadFailed extends EventLocationMapState {}

final class LoadSuccees extends EventLocationMapState {
  LoadSuccees({required this.coords});
  
  final Coords coords;
}
