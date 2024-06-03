import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/event_location_map/event_location_map_cubit/event_location_map_cubit.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';
import 'package:project/utils/extensions/context_x.dart';

class EventLocationMapScreen extends StatefulWidget {
  const EventLocationMapScreen({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<EventLocationMapScreen> createState() => _EventLocationMapScreenState();
}

class _EventLocationMapScreenState extends State<EventLocationMapScreen> {
  // Moscow
  static final _initialPoint = GeoPoint(
    latitude: 55.751244,
    longitude: 37.618423,
  );

  final controller = MapController(
    initPosition: _initialPoint,
    areaLimit: const BoundingBox.world(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventLocationMapCubit(widget.event),
      child: BlocListener<EventLocationMapCubit, EventLocationMapState>(
        listener: _stateChanged,
        child: Scaffold(
          appBar: FlatAppBar(
            title: Text(widget.event.city),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton.filled(
                onPressed: () {
                  controller.zoomIn();
                },
                icon: const Icon(Icons.add),
              ),
              IconButton.filled(
                onPressed: () {
                  controller.zoomOut();
                },
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
          body: OSMFlutter(
            controller: controller,
            osmOption: OSMOption(
              showZoomController: true,
              zoomOption: const ZoomOption(
                initZoom: 13,
              ),
              markerOption: MarkerOption(
                defaultMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 55,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _stateChanged(BuildContext context, EventLocationMapState state) {
    switch (state) {
      case Loading():
        break;
      case LoadSuccees(coords: final coords):
        controller.changeLocation(GeoPoint(
          latitude: coords.latitude,
          longitude: coords.longitude,
        ));
      case LoadFailed():
        context.showSnackbar(L10n.current.somethingWentWrong);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
