import 'package:isar/isar.dart';
import 'package:project/domain/models/answer.dart';

part 'answer_collection.g.dart';

@collection
class AnswerCollection {
  @Index(replace: true)
  final Id id;

  final List<String> answers;

  final int questionId;

  AnswerCollection({
    required this.id,
    required this.answers,
    required this.questionId,
  });

  static Answer toModel(AnswerCollection answerCollection) {
    return Answer(
      id: answerCollection.id,
      answers: answerCollection.answers,
      questionId: answerCollection.questionId,
    );
  }

  factory AnswerCollection.fromModel(Answer answer) {
    return AnswerCollection(
      id: answer.id,
      answers: answer.answers,
      questionId: answer.questionId,
    );
  }
}
