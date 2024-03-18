import 'package:flutter/material.dart';
import 'package:formulario_curso/app/core/theme/theme_controller.dart';
import 'package:formulario_curso/app/core/theme/theme_inherited_widget.dart';
import 'package:formulario_curso/app/features/form/presenter/form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController _temaController = ThemeController();

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      temaController: _temaController,
      child: Builder(builder: (context) {
        final themeInheritedWidget = context.getInheritedWidgetOfExactType<ThemeInheritedWidget>()!;
        final themeValueNotifier = themeInheritedWidget.temaController.themeMode;
        return ValueListenableBuilder<ThemeMode>(
            valueListenable: themeValueNotifier,
            builder: (context, themeMode, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(primarySwatch: Colors.blue),
                darkTheme: ThemeData.dark(),
                themeMode: themeMode,
                home: const FormScreen(),
              );
            });
      }),
    );
  }
}
