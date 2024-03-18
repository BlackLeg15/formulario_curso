import 'package:flutter/material.dart';

sealed class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

class ExceptionThemeState extends ThemeState {
  const ExceptionThemeState(super.themeMode);
}

class LoadingThemeState extends ThemeState {
  const LoadingThemeState(super.themeMode);
}

class SuccessThemeState extends ThemeState {
  const SuccessThemeState(super.themeMode);
}
