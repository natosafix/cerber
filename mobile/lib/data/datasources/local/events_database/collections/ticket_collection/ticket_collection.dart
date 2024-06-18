import 'package:isar/isar.dart';
import 'package:project/domain/models/ticket.dart';

part 'ticket_collection.g.dart';

@collection
class TicketCollection {
  @Index(replace: true)
  final Id id;

  @Index()
  final int eventId;

  final int price;
  final String name;

  TicketCollection({
    required this.id,
    required this.eventId,
    required this.price,
    required this.name,
  });

  static Ticket toModel(TicketCollection ticketCollection) {
    return Ticket(
      id: ticketCollection.id,
      price: ticketCollection.price,
      name: ticketCollection.name,
    );
  }

  factory TicketCollection.fromModel(Ticket ticket, int eventId) {
    return TicketCollection(
      id: ticket.id,
      eventId: eventId,
      price: ticket.price,
      name: ticket.name,
    );
  }
}
