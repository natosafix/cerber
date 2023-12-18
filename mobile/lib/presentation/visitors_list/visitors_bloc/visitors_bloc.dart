import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/events_repository/events_repository.dart';

part 'visitors_event.dart';
part 'visitors_state.dart';

class VisitorsBloc extends Bloc<VisitorsEvent, VisitorsState> {
  VisitorsBloc(this._eventsRepository, this._eventId) : super(VisitorsState.initial()) {
    on<GetVisitors>(_onGetVisitors);

    state.pagingController.addPageRequestListener((pageKey) {
      add(GetVisitors(pageKey: pageKey));
    });
  }

  final EventsRepository _eventsRepository;
  final int _eventId;

  static const _limit = 25;

  void _onGetVisitors(GetVisitors event, Emitter<VisitorsState> emit) async {
    final result = await _eventsRepository.getVisitors(
      eventId: _eventId,
      limit: _limit,
      offset: event.pageKey,
    );

    final controller = state.pagingController;

    if (result.isFailure) {
      controller.error = result.failure;
      return;
    }

    final newVisitors = result.success;

    final isLastPage = newVisitors.length < _limit;

    if (isLastPage) {
      controller.appendLastPage(newVisitors);
    } else {
      final nextPageKey = event.pageKey + newVisitors.length;
      controller.appendPage(newVisitors, nextPageKey);
    }
  }
}
