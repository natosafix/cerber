import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';

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
      body: CustomScrollView(
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
                        TextSpan(text: "${L10n.current.where}: "),
                        TextSpan(
                          text: widget.event.address,
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
                        TextSpan(text: "${L10n.current.when}: "),
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
                    expandText: L10n.current.more,
                    collapseText: L10n.current.less,
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
    );
  }

  Widget _buttons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {},
            child: Text(L10n.current.downloadDatabase),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _startCheckingPressed,
            child: Text(L10n.current.beginChecking),
          ),
        ),
      ],
    );
  }

  void _startCheckingPressed() {
    Navigator.of(context).push(VisitorsListScreen.route(widget.event));
  }
}
