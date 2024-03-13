import 'package:flutter/widgets.dart';
import 'package:formulario_curso/controllers/tema_controller.dart';

class ThemeInheritedWidget extends InheritedWidget {
  final TemaController temaController;
  const ThemeInheritedWidget({super.key, required super.child, required this.temaController});

  @override
  bool updateShouldNotify(covariant ThemeInheritedWidget oldWidget) {
    return temaController.themeMode.value != oldWidget.temaController.themeMode.value;
  }
}
