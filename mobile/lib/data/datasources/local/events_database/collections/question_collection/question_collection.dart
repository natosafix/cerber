import 'package:isar/isar.dart';
import 'package:project/data/datasources/local/events_database/collections/question_collection/question_type_db.dart';
import 'package:project/domain/models/question.dart';

part 'question_collection.g.dart';

@collection
class QuestionCollection {
  @Index(replace: true)
  Id id;

  @Enumerated(EnumType.name)
  QuestionTypeDb questionTypeDb;

  String question;

  QuestionCollection({
    required this.id,
    required this.questionTypeDb,
    required this.question,
  });

  static Question toModel(QuestionCollection questionCollection) {
    return Question(
      id: questionCollection.id,
      question: questionCollection.question,
      questionType: QuestionTypeDb.toModel(questionCollection.questionTypeDb),
    );
  }

  factory QuestionCollection.fromModel(Question question) {
    return QuestionCollection(
      id: question.id,
      questionTypeDb: QuestionTypeDb.fromModel(question.questionType),
      question: question.question,
    );
  }
}
