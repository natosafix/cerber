part of 'questions_bloc.dart';

final class QuestionsState {
  final Map<Question, Answer>? questionsMap;
  final String? qrCodeData;
  final List<Ticket> tickets;
  final Ticket? selectedTicket;
  final bool validationFailed;

  QuestionsState({
    required this.questionsMap,
    required this.qrCodeData,
    required this.tickets,
    required this.selectedTicket,
    required this.validationFailed,
  });

  QuestionsState copyWith({
    Map<Question, Answer>? questionsMap,
    String? qrCodeData,
    List<Ticket>? tickets,
    Ticket? selectedTicket,
    bool? validationFailed,
  }) {
    return QuestionsState(
      questionsMap: questionsMap ?? this.questionsMap,
      qrCodeData: qrCodeData ?? this.qrCodeData,
      tickets: tickets ?? this.tickets,
      selectedTicket: selectedTicket ?? this.selectedTicket,
      validationFailed: validationFailed ?? this.validationFailed,
    );
  }
}
