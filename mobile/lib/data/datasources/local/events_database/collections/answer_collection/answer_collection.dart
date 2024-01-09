import 'package:isar/isar.dart';
import 'package:project/domain/models/answer.dart';

part 'answer_collection.g.dart';

@collection
class AnswerCollection {
  @Index(replace: true)
  final Id id;

  final String answer;

  final int questionId;

  AnswerCollection({
    required this.id,
    required this.answer,
    required this.questionId,
  });

  static Answer toModel(AnswerCollection answerCollection) {
    return Answer(
      id: answerCollection.id,
      answer: answerCollection.answer,
      questionId: answerCollection.questionId,
    );
  }

  factory AnswerCollection.fromModel(Answer answer) {
    return AnswerCollection(
      id: answer.id,
      answer: answer.answer,
      questionId: answer.questionId,
    );
  }
}
