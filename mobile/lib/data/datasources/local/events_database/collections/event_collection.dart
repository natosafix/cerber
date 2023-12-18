import 'package:isar/isar.dart';
import 'package:project/domain/models/event.dart';

part 'event_collection.g.dart';

@collection
class EventCollection {
  @Index(replace: true)
  Id id;

  String name;
  String shortDescription;
  String description;
  String city;
  String address;
  DateTime startDate;
  DateTime endDate;
  String category;
  String photoUrl;

  EventCollection({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.city,
    required this.address,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.photoUrl,
  });

  static Event toModel(EventCollection event) {
    return Event(
      id: event.id,
      name: event.name,
      shortDescription: event.shortDescription,
      description: event.description,
      city: event.city,
      address: event.address,
      startDate: event.startDate,
      endDate: event.endDate,
      photoUrl: event.photoUrl,
      category: event.category,
    );
  }

  factory EventCollection.fromModel(Event event) {
    return EventCollection(
      id: event.id,
      name: event.name,
      shortDescription: event.shortDescription,
      description: event.description,
      city: event.city,
      address: event.address,
      startDate: event.startDate,
      endDate: event.endDate,
      category: event.category,
      photoUrl: event.photoUrl,
    );
  }
}
