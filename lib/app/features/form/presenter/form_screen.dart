import 'package:flutter/material.dart';
import 'package:formulario_curso/app/features/form/domain/value_objects/email_value_object.dart';
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

  @override
  void initState() {
    super.initState();
    emailValueObject = const EmailValueObject(value: '');
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    phoneMask = MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: {
        '#': RegExp('\\d'),
      },
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
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
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario'),
          actions: [
            IconButton(
              onPressed: () {
                final themeInheritedWidget = context.getInheritedWidgetOfExactType<ThemeInheritedWidget>()!;
                final temaController = themeInheritedWidget.temaController;
                late ThemeMode chosenMode;
                switch (temaController.themeMode.value) {
                  case ThemeMode.dark:
                    chosenMode = ThemeMode.light;
                    break;
                  default:
                    chosenMode = ThemeMode.dark;
                }
                temaController.changeTheme(chosenMode);
              },
              icon: const Icon(Icons.change_circle),
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
                      focusNode: nameFocusNode,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insira o nome';
                        }

                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
