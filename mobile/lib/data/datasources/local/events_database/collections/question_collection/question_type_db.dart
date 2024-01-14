import 'package:project/domain/models/question_type.dart';

enum QuestionTypeDb {
  oneLineText,
  multiLineText,
  radio,
  checkbox;

  factory QuestionTypeDb.fromModel(QuestionType questionType) {
    return switch (questionType) {
      QuestionType.oneLineText => QuestionTypeDb.oneLineText,
      QuestionType.multiLineText => QuestionTypeDb.multiLineText,
      QuestionType.radio => QuestionTypeDb.radio,
      QuestionType.checkbox => QuestionTypeDb.checkbox,
    };
  }

  static QuestionType toModel(QuestionTypeDb questionTypeDb) {
    return switch (questionTypeDb) {
      QuestionTypeDb.oneLineText => QuestionType.oneLineText,
      QuestionTypeDb.multiLineText => QuestionType.multiLineText,
      QuestionTypeDb.radio => QuestionType.radio,
      QuestionTypeDb.checkbox => QuestionType.checkbox,
    };
  }
}
