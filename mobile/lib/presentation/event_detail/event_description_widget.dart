import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:project/l10n/generated/l10n.dart';

class EventDescriptionWidget extends StatelessWidget {
  const EventDescriptionWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      text,
      expandText: L10n.current.more,
      collapseText: L10n.current.less,
      collapseOnTextTap: true,
      linkEllipsis: false,
      animation: true,
      maxLines: 7,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
