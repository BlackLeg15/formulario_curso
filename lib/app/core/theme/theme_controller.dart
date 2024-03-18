import 'package:flutter/material.dart';

class ThemeController {
  final themeMode = ValueNotifier(ThemeMode.system);

  void changeTheme(ThemeMode themeMode) {
    this.themeMode.value = themeMode;
  }
}
