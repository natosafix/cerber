import 'package:isar/isar.dart';

import '../../../../../domain/models/event.dart';
import '../fast_hash_mixin.dart';

part 'event_collection.g.dart';

@collection
class EventCollection with FastHashMixin {
  Id get isarId => fastHash(eventId);

  @Index(unique: true, replace: true)
  String eventId;

  String name;

  String location;

  String description;

  DateTime startDate;

  String photoUrl;

  EventCollection({
    required this.eventId,
    required this.name,
    required this.location,
    required this.description,
    required this.startDate,
    required this.photoUrl,
  });

  static Event toModel(EventCollection event) {
    return Event(
      id: event.eventId,
      name: event.name,
      location: event.location,
      description: event.description,
      startDate: event.startDate,
    );
  }
}
