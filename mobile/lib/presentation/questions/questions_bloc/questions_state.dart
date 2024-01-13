part of 'questions_bloc.dart';

final class QuestionsState {
  final Map<Question, Answer?>? questionsMap;
  final String? qrCodeData;

  QuestionsState({
    required this.questionsMap,
    required this.qrCodeData,
  });

  QuestionsState copyWith({
    Map<Question, Answer?>? questionsMap,
    String? qrCodeData,
  }) {
    return QuestionsState(
      questionsMap: questionsMap ?? this.questionsMap,
      qrCodeData: qrCodeData ?? this.qrCodeData,
    );
  }
}
