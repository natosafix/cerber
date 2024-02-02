import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc_base.dart';

class QuestionsViewerBloc extends QuestionsBlocBase {
  QuestionsViewerBloc({
    required super.event,
    required super.questionsMap,
    required Ticket selectedTicket,
  }) : super(
          needsToLoadData: false,
          tickets: [selectedTicket],
          selectedTicket: selectedTicket,
        );

  @override
  void onLoadData(LoadData event, Emitter<QuestionsState> emit) {}

  @override
  void onFinishPressed(FinishPressed event, Emitter<QuestionsState> emit) {}
}
