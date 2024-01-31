part of 'questions_bloc_base.dart';

class QuestionsState {
  final Map<Question, Answer> questionsMap;
  final List<Ticket> tickets;
  final Ticket? selectedTicket;
  final bool isLoading;
  final String? messageToShow;
  final Widget? modalToShow;
  final void Function(BuildContext)? onModalClosed;

  QuestionsState({
    required this.questionsMap,
    required this.tickets,
    required this.selectedTicket,
    required this.isLoading,
    required this.messageToShow,
    required this.modalToShow,
    required this.onModalClosed,
  });

  QuestionsState copyWith({
    Map<Question, Answer>? questionsMap,
    List<Ticket>? tickets,
    Ticket? selectedTicket,
    bool? isLoading,
    ValueGetter<String?>? messageToShow,
    Widget? modalToShow,
    void Function(BuildContext)? onModalClosed,
  }) {
    return QuestionsState(
      questionsMap: questionsMap ?? this.questionsMap,
      tickets: tickets ?? this.tickets,
      selectedTicket: selectedTicket ?? this.selectedTicket,
      isLoading: isLoading ?? this.isLoading,
      messageToShow: messageToShow != null ? messageToShow() : this.messageToShow,
      modalToShow: modalToShow ?? this.modalToShow,
      onModalClosed: onModalClosed ?? this.onModalClosed,
    );
  }
}
