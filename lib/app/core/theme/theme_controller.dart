import 'package:flutter/material.dart';

class ThemeController {
  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.dark);

  void changeTheme() {
    themeMode.value = switch (themeMode.value) {
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      _ => ThemeMode.light,
    };
  }
}
