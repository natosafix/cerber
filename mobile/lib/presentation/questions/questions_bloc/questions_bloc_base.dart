import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/ticket.dart';

part 'questions_event.dart';
part 'questions_state.dart';

abstract class QuestionsBlocBase extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBlocBase({
    required this.event,
    required Map<Question, Answer> questionsMap,
    required List<Ticket> tickets,
    required Ticket? selectedTicket,
    required bool needsToLoadData,
  }) : super(QuestionsState(
          questionsMap: questionsMap,
          tickets: tickets,
          selectedTicket: selectedTicket,
          isLoading: needsToLoadData,
          messageToShow: null,
          modalToShow: null,
          onModalClosed: null,
        )) {
    on<LoadData>(onLoadData);
    on<FinishPressed>(onFinishPressed);
    on<TicketChanged>(_onTicketChanged);
    on<InputChanged>(_onInputChanged);

    if (needsToLoadData) {
      add(LoadData());
    }
  }

  @protected
  final Event event;

  @protected
  void onLoadData(LoadData event, Emitter<QuestionsState> emit);

  @protected
  void onFinishPressed(FinishPressed event, Emitter<QuestionsState> emit);

  void _onTicketChanged(TicketChanged event, Emitter<QuestionsState> emit) {
    emit(state.copyWith(selectedTicket: event.ticket));
  }

  void _onInputChanged(InputChanged event, Emitter<QuestionsState> emit) {
    final question = event.question;
    final map = state.questionsMap;
    final oldAnswer = map[question]!;

    switch (event) {
      case TextChanged(newValue: final newValue):
        map[question] = oldAnswer.copyWithAnswers([newValue]);
      case RadioChanged(selectedValue: final selectedValue):
        map[question] = oldAnswer.copyWithAnswers([selectedValue]);
      case CheckboxChanged(value: final value, selected: final selected):
        if (selected) {
          oldAnswer.answers.add(value);
        } else {
          oldAnswer.answers.remove(value);
        }
    }

    emit(state.copyWith(questionsMap: state.questionsMap));
  }
}
