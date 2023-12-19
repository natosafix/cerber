import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/ticket.dart';

class Visitor {
  final String id;
  final List<Answer> answers;
  final Ticket ticket;

  Visitor({
    required this.id,
    required this.answers,
    required this.ticket,
  });
}
