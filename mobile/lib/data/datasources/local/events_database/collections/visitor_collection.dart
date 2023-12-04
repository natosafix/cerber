import 'package:isar/isar.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/utils/fast_hash_x.dart';

part 'visitor_collection.g.dart';

@collection
class VisitorCollection {
  Id get isarId => visitorId.fastHash();

  @Index(composite: [CompositeIndex("eventId")], unique: true, replace: true)
  String visitorId;

  @Index()
  String eventId;

  String name;

  VisitorCollection({
    required this.visitorId,
    required this.eventId,
    required this.name,
  });

  static Visitor toModel(VisitorCollection visitor) {
    return Visitor(
      id: visitor.visitorId,
      name: visitor.name,
    );
  }

  factory VisitorCollection.fromModel(Visitor visitor, String eventId) {
    return VisitorCollection(
      visitorId: visitor.id,
      eventId: eventId,
      name: visitor.name,
    );
  }
}
