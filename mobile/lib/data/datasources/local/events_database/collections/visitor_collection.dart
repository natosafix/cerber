import 'package:isar/isar.dart';

import '../../../../../domain/models/visitor.dart';
import '../fast_hash_mixin.dart';

part 'visitor_collection.g.dart';

@collection
class VisitorCollection with FastHashMixin {
  Id get isarId => fastHash(visitorId);

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
}
