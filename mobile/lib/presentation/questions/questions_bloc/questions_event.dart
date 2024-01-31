part of 'questions_bloc_base.dart';

sealed class QuestionsEvent {}

final class FillData extends QuestionsEvent {}

final class FinishPressed extends QuestionsEvent {}

final class TicketChanged extends QuestionsEvent {
  final Ticket ticket;

  TicketChanged({required this.ticket});
}

sealed class InputChanged extends QuestionsEvent {
  final Question question;

  InputChanged({required this.question});
}

final class TextChanged extends InputChanged {
  final String newValue;

  TextChanged({
    required super.question,
    required this.newValue,
  });
}

final class RadioChanged extends InputChanged {
  final String selectedValue;

  RadioChanged({
    required super.question,
    required this.selectedValue,
  });
}

final class CheckboxChanged extends InputChanged {
  final String value;
  final bool selected;

  CheckboxChanged({
    required super.question,
    required this.value,
    required this.selected,
  });
}
