import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/answer.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/utils/locator.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc({
    required Visitor? visitor,
    required this.eventId,
  }) : super(QuestionsState(questionsMap: visitor?.questionsMap ?? {})) {
    on<AddQuestions>(_onAddQuestions);

    if (visitor == null) {
      add(AddQuestions());
    }
  }

  final int eventId;

  final _compoundEventsRepository = locator<CompoundEventsRepository>();

  void _onAddQuestions(AddQuestions event, Emitter<QuestionsState> emit) async {
    final questions = await _compoundEventsRepository.getQuestions(eventId);
    if (questions == null) {
      return emit(QuestionsState(questionsMap: null));
    }

    final map = {for (final question in questions) question: null};
    emit(QuestionsState(questionsMap: map));
  }
}
