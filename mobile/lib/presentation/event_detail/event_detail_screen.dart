import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                stretch: true,
                expandedHeight: 250,
                collapsedHeight: kToolbarHeight * 2,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  centerTitle: true,
                  titlePadding: const EdgeInsets.all(8),
                  title: Text(widget.event.name),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "https://www.sinara-group.com/upload/iblock/8ef/DSC09139.jpg",
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
                      ExpandableText(
                        widget.event.description,
                        expandText: "больше",
                        collapseText: "меньше",
                        collapseOnTextTap: true,
                        linkEllipsis: false,
                        animation: true,
                        maxLines: 7,
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
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              child: const Text("Скачать базу"),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: double.infinity,
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
}
