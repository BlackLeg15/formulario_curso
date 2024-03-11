import 'package:flutter/material.dart';

class TemaController with ChangeNotifier {
  bool _thema = true;
  bool get getThema => _thema;

  void changeThema() {
    _thema = !_thema;
    notifyListeners();
  }
}
