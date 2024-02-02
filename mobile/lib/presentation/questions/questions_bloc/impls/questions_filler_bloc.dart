import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/question_type.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/questions/qr_code_modal.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc_base.dart';
import 'package:project/utils/locator.dart';

class QuestionsFillerBloc extends QuestionsBlocBase {
  QuestionsFillerBloc({
    required super.event,
  }) : super(
          needsToLoadData: true,
          questionsMap: {},
          tickets: [],
          selectedTicket: null,
        );

  final _compoundEventsRepository = locator<CompoundEventsRepository>();

  @override
  void onLoadData(LoadData event, Emitter<QuestionsState> emit) async {
    final questions = await _compoundEventsRepository.getQuestions(this.event.id);
    if (questions == null) {
      return emit(state.copyWith(isLoading: false));
    }

    final tickets = await _compoundEventsRepository.getTickets(this.event.id);

    final Map<Question, Answer> questionsMap = {};

    for (final question in questions) {
      final List<String> answers = switch (question.questionType) {
        QuestionType.oneLineText || QuestionType.multiLineText => [''],
        QuestionType.radio || QuestionType.checkbox => [],
      };
      questionsMap[question] = Answer(id: 0, answers: answers, questionId: question.id);
    }

    emit(state.copyWith(
      questionsMap: questionsMap,
      tickets: tickets,
      selectedTicket: tickets!.first,
      isLoading: false,
    ));
  }

  @override
  void onFinishPressed(FinishPressed event, Emitter<QuestionsState> emit) async {
    if (!_validate(state)) {
      emit(state.copyWith(messageToShow: () => L10n.current.pleaseFillTheEntireForm));
      emit(state.copyWith(messageToShow: () => null));
      return;
    }

    final answers = [
      for (final (question, answer) in state.questionsMap.entries.map((e) => (e.key, e.value)))
        FilledAnswer(
          questionId: question.id,
          answers: answer.answers,
        ),
    ];

    final qrCodeData = await _compoundEventsRepository.generateQrCode(
      this.event,
      answers,
      state.selectedTicket!.id,
    );

    emit(state.copyWith(
      modalToShow: QrCodeModal(qrCodeData: qrCodeData.toString()),
      onModalClosed: (context) => Navigator.of(context).pop(),
    ));
  }

  bool _validate(QuestionsState questionsState) {
    if (questionsState.selectedTicket == null) return false;

    for (final entry in questionsState.questionsMap.entries) {
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
}
