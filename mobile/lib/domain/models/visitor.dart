import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/ticket.dart';

class Visitor {
  final String id;
  final Map<Question, Answer> questionsMap;
  final Ticket ticket;
  final DateTime? qrCodeScannedTime;

  Visitor({
    required this.id,
    required this.questionsMap,
    required this.ticket,
    required this.qrCodeScannedTime,
  });
}
