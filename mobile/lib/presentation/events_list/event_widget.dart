import 'package:flutter/material.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/events_list/event_image.dart';
import 'package:project/utils/extensions/context_x.dart';

class EventWidget extends StatelessWidget {
  const EventWidget(this.event, {super.key});

  final Event event;

  static const double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isLight() ? Colors.white : const Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: context.isLight()
                ? Colors.grey.withOpacity(0.15)
                : const Color.fromARGB(255, 15, 15, 15).withOpacity(0.3),
            spreadRadius: 2.5,
            blurRadius: 5,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        children: [
          EventImage(borderRadius: borderRadius, event: event),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 25, right: 20, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "${event.city}, ${event.address}",
                  ),
                  const SizedBox(height: 7),
                  Text(
                    event.shortDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    L10n.current.formattedDateTime(event.startDate, event.startDate),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
