import 'package:project/data/datasources/remote/events_service/responses/answer_api_response.dart';
import 'package:project/domain/models/answer.dart';

extension AnswerMapper on AnswerApiResponse {
  Answer toModel() {
    return Answer(
      id: id,
      answers: [content], //TODO
      questionId: questionId,
    );
  }
}
