import 'package:project/data/datasources/remote/events_service/mappers/answer_mapper.dart';
import 'package:project/data/datasources/remote/events_service/mappers/question_getter.dart';
import 'package:project/data/datasources/remote/events_service/mappers/ticket_mapper.dart';
import 'package:project/data/datasources/remote/events_service/responses/visitor_api_response.dart';
import 'package:project/domain/models/visitor.dart';

extension VisitorMapper on VisitorApiResponse {
  Visitor toModel(QuestionGetter questionGetter) {
    return Visitor(
      id: id,
      answers: answers.map((e) => e.toModel(questionGetter)).toList(),
      ticket: ticket.toModel(),
    );
  }
}
