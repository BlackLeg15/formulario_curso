import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formulario_curso/app/core/theme/theme_event.dart';
import 'package:formulario_curso/app/core/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const SuccessThemeState(ThemeMode.dark)) {
    on<SwitchThemeEvent>((event, emit) async {
      final currentThemeMode = state.themeMode;
      final newThemeMode = switch (currentThemeMode) {
        ThemeMode.dark => ThemeMode.light,
        ThemeMode.light => ThemeMode.dark,
        _ => ThemeMode.light,
      };
      emit(SuccessThemeState(newThemeMode));
    });
  }
}
