part of 'questions_bloc.dart';

sealed class QuestionsEvent {}

final class AddQuestions extends QuestionsEvent {}

final class SaveNewVisitor extends QuestionsEvent {}
