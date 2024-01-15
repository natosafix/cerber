import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void showSnackbar(String text) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  bool isLight() {
    return MediaQuery.of(this).platformBrightness == Brightness.light;
  }

  Color appBarForegroundColor() {
    return isLight() ? Colors.black : Colors.white;
  }
}
