import 'package:isar/isar.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/utils/fast_hash_x.dart';

part 'event_collection.g.dart';

@collection
class EventCollection {
  Id get isarId => eventId.fastHash();

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
      photoUrl: event.photoUrl,
    );
  }

  factory EventCollection.fromModel(Event event) {
    return EventCollection(
      eventId: event.id,
      name: event.name,
      location: event.location,
      description: event.description,
      startDate: event.startDate,
      photoUrl: event.photoUrl,
    );
  }
}
