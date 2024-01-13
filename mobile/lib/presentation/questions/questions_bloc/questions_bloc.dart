import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/question.dart';
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
        super(QuestionsState(questionsMap: visitor?.questionsMap ?? {}, qrCodeData: null)) {
    on<AddQuestions>(_onAddQuestions);
    on<SaveNewVisitor>(_onSaveNewVisitor);

    if (visitor == null) {
      add(AddQuestions());
    }
  }

  final Event _event;

  final _compoundEventsRepository = locator<CompoundEventsRepository>();

  void _onAddQuestions(AddQuestions event, Emitter<QuestionsState> emit) async {
    final questions = await _compoundEventsRepository.getQuestions(_event.id);
    if (questions == null) {
      return emit(state.copyWith(questionsMap: null));
    }

    final map = {for (final question in questions) question: null};
    emit(state.copyWith(questionsMap: map));
  }

  void _onSaveNewVisitor(SaveNewVisitor event, Emitter<QuestionsState> emit) async {
    final qrCodeData = await _compoundEventsRepository.generateQrCode(_event);
    emit(state.copyWith(qrCodeData: qrCodeData.toString()));
  }
}
