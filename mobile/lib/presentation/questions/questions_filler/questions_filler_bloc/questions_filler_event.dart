part of 'questions_filler_bloc.dart';

sealed class QuestionsFillerEvent {}

final class LoadData extends QuestionsFillerEvent {}

final class FinishPressed extends QuestionsFillerEvent {}

final class TicketChanged extends QuestionsFillerEvent {
  final Ticket ticket;

  TicketChanged(this.ticket);
}

sealed class InputChanged extends QuestionsFillerEvent {
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
  final bool isSelected;

  CheckboxChanged({
    required super.question,
    required this.value,
    required this.isSelected,
  });
}
