import 'package:isar/isar.dart';
import 'package:project/domain/models/ticket.dart';

part 'ticket_embedded.g.dart';

@embedded
class TicketEmbedded {
  late int id;
  late double price;
  late String name;

  TicketEmbedded();

  TicketEmbedded.fromModel(Ticket ticket) {
    id = ticket.id;
    price = ticket.price;
    name = ticket.name;
  }

  static Ticket toModel(TicketEmbedded ticketEmbedded) {
    return Ticket(
      id: ticketEmbedded.id,
      price: ticketEmbedded.price,
      name: ticketEmbedded.name,
    );
  }
}
