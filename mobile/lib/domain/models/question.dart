import 'package:project/domain/models/question_type.dart';

class Question {
  final int id;
  final String question;
  final QuestionType questionType;

  Question({
    required this.id,
    required this.question,
    required this.questionType,
  });
}
