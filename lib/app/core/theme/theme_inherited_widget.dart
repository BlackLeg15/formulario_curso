import 'package:flutter/widgets.dart';
import 'package:formulario_curso/app/core/theme/theme_bloc.dart';

class ThemeInheritedWidget extends InheritedWidget {
  //final ThemeController temaController;
  final ThemeBloc temaController;
  const ThemeInheritedWidget({super.key, required super.child, required this.temaController});

  @override
  bool updateShouldNotify(covariant ThemeInheritedWidget oldWidget) {
    //return temaController.themeMode.value != oldWidget.temaController.themeMode.value;
    return temaController.state != oldWidget.temaController.state;
  }
}
