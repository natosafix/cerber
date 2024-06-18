import 'package:flutter/material.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/presentation/event_location_map/event_location_map_screen.dart';

class EventDetailLocation extends StatelessWidget {
  const EventDetailLocation({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${event.city}, ${event.address}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton.filled(
            onPressed: () => iconPressed(context),
            icon: const Icon(Icons.location_on),
          ),
        ],
      ),
    );
  }

  void iconPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EventLocationMapScreen(event: event)),
    );
  }
}
