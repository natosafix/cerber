import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/event_location_map/event_location_map_cubit/event_location_map_cubit.dart';
import 'package:project/presentation/widgets/flat_app_bar.dart';
import 'package:project/utils/extensions/context_x.dart';

class EventLocationMapScreen extends StatelessWidget {
  const EventLocationMapScreen({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventLocationMapCubit(event),
      child: SafeArea(
        child: BlocConsumer<EventLocationMapCubit, EventLocationMapState>(
          listener: (context, state) {
            if (state is LoadFailed) {
              context.showSnackbar(L10n.current.somethingWentWrong);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: FlatAppBar(
                title: Text(event.city),
              ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.filled(
                    onPressed: () {
                      context.read<EventLocationMapCubit>().zoomIn();
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      context.read<EventLocationMapCubit>().zoomOut();
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
              body: OSMFlutter(
                controller: state.mapController,
                osmOption: OSMOption(
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
            );
          },
        ),
      ),
    );
  }
}
