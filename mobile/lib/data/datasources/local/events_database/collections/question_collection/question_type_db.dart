import 'package:project/domain/models/question_type.dart';

enum QuestionTypeDb {
  text,
  radio,
  checkbox;

  factory QuestionTypeDb.fromModel(QuestionType questionType) {
    return switch (questionType) {
      QuestionType.text => QuestionTypeDb.text,
      QuestionType.radio => QuestionTypeDb.radio,
      QuestionType.checkbox => QuestionTypeDb.checkbox,
    };
  }

  static QuestionType toModel(QuestionTypeDb questionTypeDb) {
    return switch (questionTypeDb) {
      QuestionTypeDb.text => QuestionType.text,
      QuestionTypeDb.radio => QuestionType.radio,
      QuestionTypeDb.checkbox => QuestionType.checkbox,
    }; 
  }
}
