import 'package:project/domain/models/question.dart';

class Answer {
  final int id;
  final String answer;
  final Question question;

  Answer({
    required this.id,
    required this.answer,
    required this.question,
  });
}
