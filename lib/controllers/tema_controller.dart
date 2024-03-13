import 'package:flutter/material.dart';

class TemaController {
  final themeMode = ValueNotifier(ThemeMode.system);

  void changeThema(ThemeMode themeMode) {
    this.themeMode.value = themeMode;
  }
}
