import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/mock_events_repo.dart';
import '../authentication/authentication_bloc/authentication_bloc.dart';
import '../event_detail/event_detail_screen.dart';
import 'event_widget.dart';
import 'events_bloc/events_bloc.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({
    super.key,
    required this.token,
  });

  final String token;

  static Route route(String token) {
    return MaterialPageRoute(builder: (context) => EventsListScreen(token: token));
  }

  @override
  Widget build(BuildContext context) {
    final remoteRepo = MockEventsRepo();

    return BlocProvider(
      create: (context) => EventsBloc(remoteRepo)..add(GetEvents()),
      child: _EventsListView(),
    );
  }
}

class _EventsListView extends StatefulWidget {
  @override
  State<_EventsListView> createState() => _EventsListViewState();
}

class _EventsListViewState extends State<_EventsListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          if (state.hasReachedMax && state.events.isEmpty) {
            return const Center(
              child: Text("У вас нет мероприятий"),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.events.length + (state.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= state.events.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: SizedBox.square(
                      dimension: 25,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              final event = state.events[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(EventDetailScreen.route(event)),
                  child: EventWidget(event),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<EventsBloc>().add(GetEvents());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
