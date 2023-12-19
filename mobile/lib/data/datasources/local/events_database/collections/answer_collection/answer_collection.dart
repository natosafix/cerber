import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_collection.dart';
import 'package:project/domain/models/answer.dart';

part 'answer_collection.g.dart';

@collection
class AnswerCollection {
  @Index(replace: true)
  late Id id;

  late String answer;

  final question = IsarLink<QuestionCollection>();

  AnswerCollection();

  static Answer toModel(AnswerCollection answerCollection) {
    answerCollection.question.loadSync();
    return Answer(
      id: answerCollection.id,
      answer: answerCollection.answer,
      question: QuestionCollection.toModel(answerCollection.question.value!),
    );
  }

  AnswerCollection.fromModel(Answer answer) {
    id = answer.id;
    this.answer = answer.answer;
    question.value = QuestionCollection.fromModel(answer.question);
  }
}
