import 'package:project/data/datasources/remote/events_service/mappers/ticket_mapper.dart';
import 'package:project/data/datasources/remote/events_service/responses/visitor_api_response.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/visitor.dart';

extension VisitorMapper on VisitorApiResponse {
  Visitor toModel(Map<Question, Answer> questionsMap) {
    return Visitor(
      id: id,
      questionsMap: questionsMap,
      ticket: ticket.toModel(),
      qrCodeScannedTime: null,
    );
  }
}
