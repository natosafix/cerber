import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/qr_code_data.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/question_type.dart';
import 'package:project/domain/models/new_visitor_id.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/domain/usecases/add_new_visitor_usecase.dart';
import 'package:project/domain/usecases/generate_new_qr_code_usecase.dart';
import 'package:project/domain/usecases/get_questions_usecase.dart';
import 'package:project/domain/usecases/get_tickets_usecase.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/utils/locator.dart';

import 'questions_loading_status.dart';

part 'questions_filler_event.dart';
part 'questions_filler_state.dart';

class QuestionsFillerBloc extends Bloc<QuestionsFillerEvent, QuestionsFillerState> {
  QuestionsFillerBloc({
    required Event event,
  })  : _event = event,
        super(QuestionsFillerState(
          questionsMap: {},
          tickets: [],
          selectedTicket: null,
          questionsLoadingStatus: QuestionsLoadingStatus.loading,
          messageToShow: null,
          generatedQrCodeData: null,
        )) {
    on<LoadData>(_onLoadData);
    on<FinishPressed>(_onFinishPressed);
    on<TicketChanged>(_onTicketChanged);
    on<InputChanged>(_onInputChanged);

    add(LoadData());
  }

  final Event _event;

  final _getQuestionsUsecase = locator<GetQuestionsUsecase>();
  final _getTicketsUsecase = locator<GetTicketsUsecase>();
  final _addNewVisitorUsecase = locator<AddNewVisitorUsecase>();
  final _generateNewQrCodeUsecase = locator<GenerateNewQrCodeUsecase>();

  void _onLoadData(LoadData event, Emitter<QuestionsFillerState> emit) async {
    final getQuestionsResult = await _getQuestionsUsecase(eventId: _event.id);

    if (getQuestionsResult.isFailure) {
      emit(state.copyWith(questionsLoadingStatus: QuestionsLoadingStatus.failure));
      return;
    }

    final Map<Question, Answer> questionsMap = {};

    for (final question in getQuestionsResult.success) {
      final List<String> answers = switch (question.questionType) {
        QuestionType.oneLineText || QuestionType.multiLineText => [''],
        QuestionType.radio || QuestionType.checkbox => [],
      };
      questionsMap[question] = Answer(id: 0, answers: answers, questionId: question.id);
    }

    final tickets = await _getTicketsUsecase(eventId: _event.id);

    emit(state.copyWith(
      questionsMap: questionsMap,
      tickets: tickets,
      selectedTicket: tickets!.first,
      questionsLoadingStatus: QuestionsLoadingStatus.success,
    ));
  }

  void _onFinishPressed(FinishPressed event, Emitter<QuestionsFillerState> emit) async {
    if (!_isStateValid) {
      emit(state.copyWith(messageToShow: () => L10n.current.pleaseFillTheEntireForm));
      emit(state.copyWith(messageToShow: () => null));
      return;
    }

    final List<FilledAnswer> answers = [
      for (final (question, answer) in state.questionsMap.entries.map((e) => (e.key, e.value)))
        FilledAnswer(
          questionId: question.id,
          answers: answer.answers,
        ),
    ];

    final NewVisitorId newVisitorId = await _addNewVisitorUsecase(
      eventId: _event.id,
      ticketId: state.selectedTicket!.id,
      filledAnswers: answers,
    );

    final QrCodeData qrCodeData = _generateNewQrCodeUsecase(
      newVisitorId: newVisitorId,
      event: _event,
    );

    emit(state.copyWith(generatedQrCodeData: qrCodeData));
  }

  void _onTicketChanged(TicketChanged event, Emitter<QuestionsFillerState> emit) {
    state.selectedTicket = event.ticket;
    // emit(state.copyWith(selectedTicket: event.ticket));
  }

  void _onInputChanged(InputChanged event, Emitter<QuestionsFillerState> emit) {
    final question = event.question;
    final map = state.questionsMap;
    final oldAnswer = map[question]!;

    switch (event) {
      case TextChanged(newValue: final newValue):
        map[question] = oldAnswer.copyWithAnswers([newValue]);
      case RadioChanged(selectedValue: final selectedValue):
        map[question] = oldAnswer.copyWithAnswers([selectedValue]);
      case CheckboxChanged(value: final value, isSelected: final isSelected):
        if (isSelected) {
          oldAnswer.answers.add(value);
        } else {
          oldAnswer.answers.remove(value);
        }
    }

    // emit(state.copyWith(questionsMap: state.questionsMap));
  }

  bool get _isStateValid {
    if (state.selectedTicket == null) return false;

    for (final MapEntry<Question, Answer> entry in state.questionsMap.entries) {
      final answers = entry.value.answers;
      if (answers.isEmpty) return false;

      switch (entry.key.questionType) {
        case QuestionType.oneLineText:
        case QuestionType.multiLineText:
          if (answers.first.trim().isEmpty) return false;
        case QuestionType.radio:
          if (answers.length != 1) return false;
        case QuestionType.checkbox:
          break;
      }
    }

    return true;
  }
}
