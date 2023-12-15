import 'package:flutter/material.dart';

extension SnackbarExt on BuildContext {
  void showSnackbar(String text) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
