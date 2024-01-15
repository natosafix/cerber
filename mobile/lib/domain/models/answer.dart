class Answer {
  final int id;
  final List<String> answers;
  final int questionId;

  Answer({
    required this.id,
    required this.answers,
    required this.questionId,
  });

  Answer copyWithAnswers(List<String> answers) {
    return Answer(
      id: id,
      answers: answers,
      questionId: questionId,
    );
  }
}
