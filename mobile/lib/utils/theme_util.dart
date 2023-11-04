import 'package:flutter/material.dart';

abstract class ThemeUtil {
  static bool isLight(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light;
  }
}
