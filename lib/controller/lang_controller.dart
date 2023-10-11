import 'package:flutter/material.dart';

class LanguageController extends ChangeNotifier {
  bool isHindi = true;

  changeLanguage() {
    isHindi = !isHindi;
    notifyListeners();
  }
}
