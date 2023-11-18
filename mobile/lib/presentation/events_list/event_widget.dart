import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../domain/models/event.dart';
import '../../utils/theme_util.dart';

class EventWidget extends StatelessWidget {
  const EventWidget(this.event, {super.key});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeUtil.isLight(context) ? Colors.white : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        children: [
          // if (event.photoBlob != null) _eventPhoto(event.photoBlob!),
          _eventPhotoMock(context),
          Padding(
            padding: const EdgeInsets.all(20),
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
                    event.location,
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

  Widget _eventPhoto(BuildContext context, Uint8List photoBlob) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: ThemeUtil.isLight(context) ? Colors.grey.withOpacity(0.4) : Colors.black26,
          spreadRadius: 5,
          blurRadius: 25,
          offset: const Offset(0, 5),
        )
      ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          width: double.infinity,
          height: 170,
          child: Image.memory(
            photoBlob,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Widget _eventPhotoMock(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: ThemeUtil.isLight(context) ? Colors.grey.withOpacity(0.4) : Colors.black26,
          spreadRadius: 5,
          blurRadius: 25,
          offset: const Offset(0, 5),
        )
      ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          width: double.infinity,
          height: 170,
          child: Image.network(
            "https://www.sinara-group.com/upload/iblock/8ef/DSC09139.jpg",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
