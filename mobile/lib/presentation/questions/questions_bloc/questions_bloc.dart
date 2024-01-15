import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/question_type.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/utils/locator.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc({
    required Visitor? visitor,
    required Event event,
  })  : _event = event,
        super(QuestionsState(
          questionsMap: visitor?.questionsMap ?? {},
          qrCodeData: null,
          tickets: visitor == null ? [] : [visitor.ticket],
          selectedTicket: visitor?.ticket,
          validationFailed: false,
        )) {
    on<FillData>(_onFillData);
    on<SaveNewVisitor>(_onSaveNewVisitor);
    on<TicketChanged>(_onTicketChanged);
    on<InputChanged>(_onInputChanged);

    if (visitor == null) {
      add(FillData());
    }
  }

  final Event _event;

  final _compoundEventsRepository = locator<CompoundEventsRepository>();

  void _onFillData(FillData event, Emitter<QuestionsState> emit) async {
    final questions = await _compoundEventsRepository.getQuestions(_event.id);
    if (questions == null) {
      return emit(state.copyWith(questionsMap: null));
    }

    final tickets = await _compoundEventsRepository.getTickets(_event.id);

    final Map<Question, Answer> map = {};

    for (final question in questions) {
      final List<String> answers = switch (question.questionType) {
        QuestionType.oneLineText => [''],
        QuestionType.multiLineText => [''],
        QuestionType.radio => [],
        QuestionType.checkbox => [],
      };
      map[question] = Answer(id: 0, answers: answers, questionId: question.id);
    }

    emit(state.copyWith(questionsMap: map, tickets: tickets, selectedTicket: tickets!.first));
  }

  void _onSaveNewVisitor(SaveNewVisitor event, Emitter<QuestionsState> emit) async {
    if (!_validateAnswers(state)) {
      emit(state.copyWith(validationFailed: true));
      emit(state.copyWith(validationFailed: false));
      return;
    }

    final answers = <FilledAnswer>[];

    for (final entry in state.questionsMap!.entries) {
      answers.add(FilledAnswer(
        questionId: entry.key.id,
        answers: entry.value.answers,
      ));
    }

    final qrCodeData = await _compoundEventsRepository.generateQrCode(_event, answers, state.selectedTicket!.id);
    emit(state.copyWith(qrCodeData: qrCodeData.toString()));
  }

  bool _validateAnswers(QuestionsState questionsState) {
    for (final entry in questionsState.questionsMap!.entries) {
      final answers = entry.value.answers;
      if (answers.isEmpty) return false;

      switch (entry.key.questionType) {
        case QuestionType.oneLineText:
        case QuestionType.multiLineText:
          if (answers.first.trim().isEmpty) return false;
        case QuestionType.radio:
          if (answers.length != 1) return false;
        case QuestionType.checkbox:
      }
    }
    return true;
  }

  void _onTicketChanged(TicketChanged event, Emitter<QuestionsState> emit) {
    emit(state.copyWith(selectedTicket: event.ticket));
  }

  void _onInputChanged(InputChanged event, Emitter<QuestionsState> emit) {
    final question = event.question;
    final map = state.questionsMap!;
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
