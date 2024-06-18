import 'package:flutter/material.dart';

class FlatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FlatAppBar({
    super.key,
    this.title,
    this.centerTitle,
    this.actions,
    this.foregroundColor,
  });

  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: foregroundColor,
      title: title,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
