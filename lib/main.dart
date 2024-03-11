import 'package:flutter/material.dart';
import 'package:formulario_curso/controller/tema_controller.dart';
import 'package:formulario_curso/form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TemaController _temaController = TemaController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _temaController.thema,
        builder: (BuildContext context, bool value, Widget? child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: value
                ? ThemeData(
                    primarySwatch: Colors.blue,
                  )
                : ThemeData.dark(),
            home: FormScreen(
              thema: _temaController,
            ),
          );
        });
  }
}
