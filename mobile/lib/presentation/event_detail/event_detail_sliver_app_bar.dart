import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:project/domain/models/event.dart';

class EventDetailSliverAppBar extends StatelessWidget {
  const EventDetailSliverAppBar({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
        title: Text(
          event.name,
          style: const TextStyle(color: Colors.white),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            event.photoUrl != null
                ? CachedNetworkImage(
                    cacheManager: DioCacheManager.instance,
                    imageUrl: event.photoUrl!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/no_image.png',
                    fit: BoxFit.cover,
                  ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0, 4),
                  end: Alignment.center,
                  colors: [
                    Color(0xFF000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
