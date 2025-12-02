// lib/view_model/language/language_provider.dart
import 'package:flutter/material.dart';
import '../../core/services/translator_service.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLang = "en";
  bool _isChangingLanguage = false;

  final AppTranslator translatorService = AppTranslator();

  bool get isChangingLanguage => _isChangingLanguage;

  Future<void> changeLanguage(String lang) async {
    if (currentLang == lang) return;

    _isChangingLanguage = true;
    notifyListeners();

    try {
      currentLang = lang;
      await translatorService.setLanguage(lang);
    } catch (e) {
      print('Error changing language: $e');
    } finally {
      _isChangingLanguage = false;
      notifyListeners();
    }
  }

  void disposeProvider() {
    translatorService.dispose();
  }
}