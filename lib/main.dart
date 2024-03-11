import 'package:flutter/material.dart';
import 'package:formulario_curso/controller/tema_controller.dart';
import 'package:formulario_curso/form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TemaController _thema = TemaController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _thema.thema
          ? ThemeData(
              primarySwatch: Colors.blue,
            )
          : ThemeData.dark(),
      home: FormScreen(
        thema: _thema,
      ),
    );
  }
}
