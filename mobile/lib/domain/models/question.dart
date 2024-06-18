import 'package:project/domain/models/question_type.dart';

class Question {
  final int id;
  final String question;
  final List<String> options;
  final QuestionType questionType;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.questionType,
  });
}
