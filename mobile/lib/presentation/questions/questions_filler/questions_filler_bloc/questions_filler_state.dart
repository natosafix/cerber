part of 'questions_filler_bloc.dart';

final class QuestionsFillerState {
  final Map<Question, Answer> questionsMap;
  final List<Ticket> tickets;
  Ticket? selectedTicket;
  final QuestionsLoadingStatus questionsLoadingStatus;
  final String? messageToShow;
  final QrCodeData? generatedQrCodeData;

  QuestionsFillerState({
    required this.questionsMap,
    required this.tickets,
    required this.selectedTicket,
    required this.questionsLoadingStatus,
    required this.messageToShow,
    required this.generatedQrCodeData,
  });

  QuestionsFillerState copyWith({
    Map<Question, Answer>? questionsMap,
    List<Ticket>? tickets,
    Ticket? selectedTicket,
    QuestionsLoadingStatus? questionsLoadingStatus,
    ValueGetter<String?>? messageToShow,
    QrCodeData? generatedQrCodeData,
  }) {
    return QuestionsFillerState(
      questionsMap: questionsMap ?? this.questionsMap,
      tickets: tickets ?? this.tickets,
      selectedTicket: selectedTicket ?? this.selectedTicket,
      questionsLoadingStatus: questionsLoadingStatus ?? this.questionsLoadingStatus,
      messageToShow: messageToShow != null ? messageToShow() : this.messageToShow,
      generatedQrCodeData: generatedQrCodeData ?? this.generatedQrCodeData,
    );
  }
}
