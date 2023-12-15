part of 'visitors_bloc.dart';

sealed class VisitorsEvent {}

final class GetVisitors extends VisitorsEvent {
  GetVisitors({required this.pageKey});
  
  final int pageKey;
}
