import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formulario_curso/app/core/theme/theme_bloc.dart';
import 'package:formulario_curso/app/core/theme/theme_inherited_widget.dart';
import 'package:formulario_curso/app/core/theme/theme_state.dart';
import 'package:formulario_curso/app/features/form/presenter/form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //final ThemeController _temaController = ThemeController();
  final _temaController = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      temaController: _temaController,
      child: Builder(builder: (context) {
        final themeInheritedWidget = context.getInheritedWidgetOfExactType<ThemeInheritedWidget>()!;
        final themeBloc = themeInheritedWidget.temaController;
        return BlocBuilder<ThemeBloc, ThemeState>(
            bloc: themeBloc,
            builder: (context, state) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(primarySwatch: Colors.blue),
                darkTheme: ThemeData.dark(),
                themeMode: state.themeMode,
                home: const FormScreen(),
                debugShowCheckedModeBanner: false,
              );
            });
      }),
    );
  }
}
