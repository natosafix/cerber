import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_collection.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';

part 'answer_collection.g.dart';

@collection
class AnswerCollection {
  @Index(replace: true)
  late Id id;

  late String answer;

  final question = IsarLink<QuestionCollection>();

  AnswerCollection();

  static Answer toModel(AnswerCollection answerCollection) {
    return Answer(
      id: answerCollection.id,
      answer: answerCollection.answer,
      questionId: answerCollection.getQuestion().id,
    );
  }

  AnswerCollection.fromModel(Answer answer, Question question, int eventId) {
    id = answer.id;
    this.answer = answer.answer;
    this.question.value = QuestionCollection.fromModel(question, eventId);
  }

  QuestionCollection getQuestion() {
    question.loadSync();
    return question.value!;
  }
}
