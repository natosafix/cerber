import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/utils/geocoder/coords.dart';
import 'package:project/utils/geocoder/geocoder.dart';
import 'package:project/utils/locator.dart';

part 'event_location_map_state.dart';

class EventLocationMapCubit extends Cubit<EventLocationMapState> {
  EventLocationMapCubit(this.event) : super(Loading()) {
    _loadCoordinates();
  }

  final Event event;

  final _geocoder = locator<Geocoder>();

  void _loadCoordinates() async {
    final coords = await _geocoder.getCoordinates(
      city: event.city,
      address: event.address,
    );

    if (coords == null) {
      emit(LoadFailed());
      return;
    }

    emit(LoadSuccees(coords: coords));
  }
}
