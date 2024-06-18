import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/usecases/get_events_usecase.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/result.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsState.initial()) {
    on<GetEvents>(_onGetEvents);
    on<Refresh>(_onRefresh);

    state.pagingController.addPageRequestListener((pageKey) {
      add(GetEvents(pageKey: pageKey));
    });
  }

  final _getEventsUsecase = locator<GetEventsUsecase>();

  static const _limit = 5;

  void _onGetEvents(GetEvents event, Emitter<EventsState> emit) async {
    final Result<List<Event>, Exception> result = await _getEventsUsecase(
      offset: event.pageKey,
      limit: _limit,
    );

    if (result.isFailure) {
      state.pagingController.error = result.failure;
      return;
    }

    final newEvents = result.success;

    final isLastPage = newEvents.length < _limit;

    if (isLastPage) {
      state.pagingController.appendLastPage(newEvents);
    } else {
      final nextPageKey = event.pageKey + newEvents.length;
      state.pagingController.appendPage(newEvents, nextPageKey);
    }
  }

  void _onRefresh(Refresh event, Emitter<EventsState> emit) {
    state.pagingController.refresh();
  }
}
