import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formulario_curso/app/core/theme/theme_event.dart';
import 'package:formulario_curso/app/core/theme/theme_state.dart';
import 'package:formulario_curso/app/features/form/domain/value_objects/email_value_object.dart';
import 'package:formulario_curso/app/features/form/domain/value_objects/name_value_object.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/theme/theme_inherited_widget.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final FocusNode emailFocusNode;
  late final FocusNode nameFocusNode;
  late final FocusNode phoneFocusNode;

  late MaskTextInputFormatter phoneMask;

  late EmailValueObject emailValueObject;
  String? emailError;

  late NameValueObject nameValueObject;
  String? nameError;

  @override
  void initState() {
    super.initState();
    emailValueObject = const EmailValueObject(value: '');
    emailFocusNode = FocusNode();
    nameValueObject = const NameValueObject(value: '');
    nameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    phoneMask = MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: {
        '#': RegExp('\\d'),
      },
    );
    // Future.delayed(const Duration(milliseconds: 300), () {
    //   nameFocusNode.requestFocus();
    // });
  }

  void goNext() {
    if (_formKey.currentState!.validate()) {
      print('continuar...');
    }
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeInheritedWidget = context.getInheritedWidgetOfExactType<ThemeInheritedWidget>()!;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario'),
          actions: [
            BlocConsumer(
              bloc: themeInheritedWidget.temaController,
              listener: (context, state) {
                if (state is ExceptionThemeState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Uma exceção ocorreu')));
                }
              },
              builder: (context, state) {
                final icon = switch (state) {
                  SuccessThemeState success => switch (success.themeMode) {
                      ThemeMode.dark => Icons.light_mode_rounded,
                      ThemeMode.light => Icons.dark_mode_rounded,
                      _ => Icons.light_mode_rounded,
                    },
                  _ => Icons.light_mode_rounded,
                };
                onPressedFunction() {
                  final temaController = themeInheritedWidget.temaController;
                  temaController.add(SwitchThemeEvent());
                }

                final void Function()? iconButtonFunction = switch (state) {
                  LoadingThemeState() => null,
                  _ => onPressedFunction,
                };

                return IconButton(
                  onPressed: iconButtonFunction,
                  icon: Icon(icon),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 3,
                  )),
              height: 600,
              width: 375,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: const Key('NameFormField'),
                      focusNode: nameFocusNode,
                      validator: nameValueObject.validate,
                      onChanged: (value) {
                        nameValueObject = NameValueObject(value: value);
                        setState(() {
                          nameError = nameValueObject.validate(value);
                        });
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        errorText: nameError,
                        border: const OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                      onFieldSubmitted: (value) {
                        emailFocusNode.requestFocus();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: const Key('EmailFormField'),
                      focusNode: emailFocusNode,
                      validator: emailValueObject.validate,
                      onChanged: (value) {
                        emailValueObject = EmailValueObject(value: value);
                        setState(() {
                          emailError = emailValueObject.validate(value);
                        });
                      },
                      controller: emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        errorText: emailError,
                        border: const OutlineInputBorder(),
                        hintText: 'Email',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                      onFieldSubmitted: (value) {
                        phoneFocusNode.requestFocus();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      inputFormatters: [phoneMask],
                      focusNode: phoneFocusNode,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Insira o telefone';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Telefone',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                      onFieldSubmitted: (value) {
                        goNext();
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: goNext,
                    child: const Text('Continuar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
