import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';

import '../../domain/models/event.dart';
import '../../utils/theme_util.dart';

class EventWidget extends StatelessWidget {
  const EventWidget(this.event, {super.key});

  final Event event;

  static const double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeUtil.isLight(context) ? Colors.white : const Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: ThemeUtil.isLight(context)
                ? Colors.grey.withOpacity(0.15)
                : const Color.fromARGB(255, 15, 15, 15).withOpacity(0.3),
            spreadRadius: 2.5,
            blurRadius: 5,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        children: [
          _eventImage(context),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 30, right: 20, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    event.address,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    event.startDate.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: ThemeUtil.isLight(context) ? Colors.grey.withOpacity(0.2) : Colors.black26,
          spreadRadius: 5,
          blurRadius: 9,
          offset: const Offset(0, 4),
        )
      ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 250,
          ),
          child: CachedNetworkImage(
            cacheManager: DioCacheManager.instance,
            imageUrl: event.photoUrl,
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            // fadeInDuration: Duration.zero,
            // httpHeaders: context.read<AuthenticationRepository>().httpHeadersForAuthentication,
          ),
        ),
      ),
    );
  }
}
