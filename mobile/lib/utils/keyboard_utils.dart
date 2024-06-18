import 'package:flutter/material.dart';

abstract class KeyboardUtils {
  static void dismiss() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
