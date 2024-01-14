import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/question_type.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/questions/qr_code_screen.dart';
import 'package:project/presentation/questions/questions_bloc/questions_bloc.dart';
import 'package:project/presentation/questions/questions_screen/inputs/checkbox_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/multi_text_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/radio_input.dart';
import 'package:project/presentation/questions/questions_screen/inputs/text_input.dart';
import 'package:project/utils/extensions/context_x.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({
    required this.visitor,
    required this.event,
    super.key,
  });

  static Route route(Visitor? visitor, Event event) {
    return MaterialPageRoute(builder: (context) => QuestionsScreen(visitor: visitor, event: event));
  }

  final Visitor? visitor;
  final Event event;

  static const double midInputsPadding = 8;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _postFrameCallback(context));
    return BlocProvider(
      create: (context) => QuestionsBloc(visitor: visitor, event: event),
      child: Scaffold(
        appBar: AppBar(
          title: Text(L10n.current.visitorsQuestions),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: context.appBarForegroundColor(),
        ),
        body: BlocConsumer<QuestionsBloc, QuestionsState>(
          listener: _onListen,
          builder: (context, state) {
            if (state.questionsMap == null || state.questionsMap!.isEmpty) {
              return Center(
                child: Text(L10n.current.questionsEmpty),
              );
            }

            final widgets = <Widget>[];

            for (final entry in state.questionsMap!.entries) {
              final question = entry.key;
              final answer = entry.value;
              widgets.add(switch (question.questionType) {
                QuestionType.oneLineText => TextInput(question, answer),
                QuestionType.multiLineText => MultiLineTextInput(question, answer),
                QuestionType.radio => RadioInput(question, answer),
                QuestionType.checkbox => CheckboxInput(question, answer),
              });
              widgets.add(const SizedBox(height: midInputsPadding));
            }

            if (visitor == null) {
              widgets.add(Padding(
                padding: const EdgeInsets.only(top: midInputsPadding * 2),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => context.read<QuestionsBloc>().add(SaveNewVisitor()),
                    child: Text(L10n.current.save),
                  ),
                ),
              ));
            }

            return Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Column(
                      children: widgets,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onListen(BuildContext context, QuestionsState state) {
    if (state.qrCodeData == null) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => QrCodeScreen(qrCodeData: state.qrCodeData!),
    );
  }

  void _postFrameCallback(BuildContext context) {
    if (visitor?.qrCodeScannedTime == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(L10n.current.qrCodeAlreadyBeenScanned),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
