import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/utils/extensions/context_x.dart';

class EventImage extends StatelessWidget {
  const EventImage({
    required this.borderRadius,
    required this.event,
    super.key,
  });

  final double borderRadius;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.isLight()
          ? BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 4),
              )
            ])
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 250,
          ),
          width: double.infinity,
          child: CachedNetworkImage(
            cacheManager: DioCacheManager.instance,
            imageUrl: event.photoUrl,
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
