import 'package:flutter/material.dart';

import '../../domain/models/event.dart';
import '../visitors_list/visitors_list_screen.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen(this.event, {super.key});

  final Event event;

  static Route route(Event event) {
    return MaterialPageRoute(builder: (context) => EventDetailScreen(event));
  }

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _scrollController = ScrollController();
  var showTitle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                stretch: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  centerTitle: true,
                  titlePadding: const EdgeInsets.all(8),
                  title: Text(
                    widget.event.name,
                    style: showTitle ? null : const TextStyle(color: Colors.transparent),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://www.sinara-group.com/upload/iblock/8ef/DSC09139.jpg',
                        fit: BoxFit.cover,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, 0.5),
                            end: Alignment.center,
                            colors: [
                              Color(0x60000000),
                              Color(0x00000000),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(15),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Text.rich(
                        style: Theme.of(context).textTheme.titleLarge,
                        TextSpan(
                          children: [
                            const TextSpan(text: "Где: "),
                            TextSpan(
                              text: widget.event.location,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        style: Theme.of(context).textTheme.titleLarge,
                        TextSpan(
                          children: [
                            const TextSpan(text: "Когда: "),
                            TextSpan(
                              text: widget.event.startDate.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.event.description,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _buttons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: const Text("Скачать базу"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FilledButton(
              onPressed: _startCheckingPressed,
              child: const Text("Начать проверку"),
            ),
          ),
        ],
      ),
    );
  }

  void _startCheckingPressed() {
    Navigator.of(context).push(VisitorsListScreen.route(widget.event));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final newValue = _scrollController.hasClients && _scrollController.offset < (200 - kToolbarHeight);
    if (showTitle != newValue) setState(() => showTitle = newValue);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
