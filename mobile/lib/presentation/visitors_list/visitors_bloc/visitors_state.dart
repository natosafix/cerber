part of 'visitors_bloc.dart';

final class VisitorsState {
  final PagingController<int, Visitor> pagingController;

  VisitorsState({
    required this.pagingController,
  });

  factory VisitorsState.initial() {
    return VisitorsState(
      pagingController: PagingController(firstPageKey: 0),
    );
  }
}
