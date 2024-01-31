import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc_base.dart';

class QuestionsViewerBloc extends QuestionsBlocBase {
  QuestionsViewerBloc({
    required super.event,
    required super.questionsMap,
    required super.tickets,
    required super.selectedTicket,
  }) : super(loadsLater: false);

  @override
  void onFillData(FillData event, Emitter<QuestionsState> emit) {}

  @override
  void onFinishPressed(FinishPressed event, Emitter<QuestionsState> emit) {}
}
