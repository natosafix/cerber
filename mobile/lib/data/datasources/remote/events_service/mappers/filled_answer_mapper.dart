import 'package:project/data/datasources/remote/events_service/requests/filled_answer_api_request.dart';
import 'package:project/domain/models/filled_answer.dart';

extension FilledAnswerMapper on FilledAnswer {
  FilledAnswerApiRequest toApi() {
    return FilledAnswerApiRequest(
      questionId: questionId,
      content: answers,
    );
  }
}
