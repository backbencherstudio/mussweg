import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  String? _selectedLanguage;

  String? get selectedLanguage => _selectedLanguage;

  void selectLanguage(String? language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
