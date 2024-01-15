import 'package:project/data/datasources/remote/events_service/mappers/question_type_mapper.dart';
import 'package:project/data/datasources/remote/events_service/responses/question_api_response.dart';
import 'package:project/domain/models/question.dart';

extension QuestionMapper on QuestionApiResponse {
  Question toModel() {
    return Question(
      id: id,
      question: title,
      questionType: type.toModel(),
      options: answerChoices,
    );
  }
}
