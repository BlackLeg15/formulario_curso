import 'package:flutter/material.dart';
import 'package:formulario_curso/controllers/tema_controller.dart';
import 'package:formulario_curso/screens/form_screen.dart';
import 'package:formulario_curso/widgets/theme_inherited_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TemaController _temaController = TemaController();

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
