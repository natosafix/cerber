import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/utils/geocoder/geocoder.dart';
import 'package:project/utils/locator.dart';

part 'event_location_map_state.dart';

class EventLocationMapCubit extends Cubit<EventLocationMapState> with OSMMixinObserver {
  EventLocationMapCubit(this.event)
      : super(Loading(
          mapController: MapController(
            initPosition: GeoPoint(
              // Moscow
              latitude: 55.751244,
              longitude: 37.618423,
            ),
            areaLimit: const BoundingBox.world(),
          ),
        )) {
    state.mapController.addObserver(this);

    _loadCoordinates();
  }

  final Event event;

  bool _isMapReady = false;

  final _geocoder = locator<Geocoder>();

  void _loadCoordinates() async {
    final coords = await _geocoder.getCoordinates(
      city: event.city,
      address: event.address,
    );

    if (coords == null) {
      emit(LoadFailed(mapController: state.mapController));
      return;
    }

    while (!_isMapReady) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    state.mapController.changeLocation(GeoPoint(
      latitude: coords.latitude,
      longitude: coords.longitude,
    ));

    emit(LoadSuccees(mapController: state.mapController));
  }

  void zoomIn() {
    state.mapController.zoomIn();
  }

  void zoomOut() {
    state.mapController.zoomOut();
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    _isMapReady = isReady;
  }

  @override
  Future<void> close() {
    state.mapController.dispose();
    return super.close();
  }
}
