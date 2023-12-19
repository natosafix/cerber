import 'package:project/data/datasources/remote/events_service/mappers/question_getter.dart';
import 'package:project/data/datasources/remote/events_service/responses/answer_api_response.dart';
import 'package:project/domain/models/answer.dart';

extension AnswerMapper on AnswerApiResponse {
  Answer toModel(QuestionGetter questionGetter) {
    return Answer(
      id: id,
      answer: content,
      question: questionGetter(questionId),
    );
  }
}
