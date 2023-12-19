import 'package:project/data/datasources/remote/events_service/responses/ticket_api_response.dart';
import 'package:project/domain/models/ticket.dart';

extension TicketMapper on TicketApiResponse {
  Ticket toModel() {
    return Ticket(
      id: id,
      price: price,
      name: name,
    );
  }
}
