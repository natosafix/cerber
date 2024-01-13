import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:project/presentation/event_detail/event_detail_screen.dart';
import 'package:project/presentation/events_list/event_widget.dart';
import 'package:project/presentation/events_list/events_bloc/events_bloc.dart';
import 'package:project/utils/extensions/context_x.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (context) => const EventsListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(context.read<EventsRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(L10n.current.events),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: context.appBarForegroundColor(),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(Unauthenticate());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () => Future.sync(
                () => state.pagingController.refresh(),
              ),
              child: PagedListView<int, Event>(
                pagingController: state.pagingController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                builderDelegate: PagedChildBuilderDelegate<Event>(
                  itemBuilder: (context, event, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(EventDetailScreen.route(event)),
                        child: EventWidget(event),
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return Center(
                      child: Text(L10n.current.youHaveNoEvents),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
