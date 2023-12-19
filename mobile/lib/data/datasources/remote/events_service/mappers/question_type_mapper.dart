import 'package:project/data/datasources/remote/events_service/responses/question_type_response.dart';
import 'package:project/domain/models/question_type.dart';

extension QuestionTypeMapper on QuestionTypeResponse {
  QuestionType toModel() {
    return switch (this) {
      QuestionTypeResponse.text => QuestionType.text,
      QuestionTypeResponse.radio => QuestionType.radio,
      QuestionTypeResponse.checkbox => QuestionType.checkbox,
    };
  }
}
