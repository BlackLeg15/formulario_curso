import 'package:flutter/material.dart';

class TemaController {
  final ValueNotifier<bool> thema = ValueNotifier(true);

  void changeThema() {
    thema.value = !thema.value;
  }
}
