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
                color: context.isLight() ? Colors.grey.withOpacity(0.2) : Colors.black26,
                spreadRadius: 5,
                blurRadius: 9,
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
