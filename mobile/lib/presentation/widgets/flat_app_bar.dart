import 'package:flutter/material.dart';
import 'package:project/utils/extensions/context_x.dart';

class FlatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FlatAppBar({
    super.key,
    this.title,
    this.centerTitle,
    this.actions,
    this.switchForegroundColorInDarkMode = true,
  });

  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final bool switchForegroundColorInDarkMode;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: switchForegroundColorInDarkMode ? (context.isLight() ? Colors.black : Colors.white) : null,
      title: title,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
