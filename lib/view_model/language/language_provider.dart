// lib/view_model/language/language_provider.dart
import 'package:flutter/material.dart';
import '../../core/services/translator_service.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLang = "en";
  bool _isChangingLanguage = false;

  final AppTranslator translatorService = AppTranslator();

  bool get isChangingLanguage => _isChangingLanguage;

  String translate(String text) {
    return translatorService.translateUIText(text, langCode: currentLang);
  }

  Future<void> changeLanguage(String lang) async {
    if (currentLang == lang) return;

    _isChangingLanguage = true;
    notifyListeners();

    try {
      currentLang = lang;
      await translatorService.setLanguage(lang);
      notifyListeners(); // Notify after successful change
    } catch (e) {
      debugPrint('Error changing language: $e');
      // Revert to previous language on error
      currentLang = currentLang;
      notifyListeners();
      rethrow;
    } finally {
      _isChangingLanguage = false;
    }
  }

  Future<void> changeLanguageWithCallback(
    String lang,
    BuildContext context, {
    required VoidCallback onSuccess,
    VoidCallback? onError,
  }) async {
    if (currentLang == lang) return;

    _isChangingLanguage = true;
    notifyListeners();

    try {
      currentLang = lang;
      await translatorService.setLanguage(lang);
      onSuccess();
    } catch (e) {
      debugPrint('Error changing language: $e');
      // Revert to previous language
      currentLang = currentLang;
      onError?.call();
      if (context.mounted) {
        _showErrorSnackbar(context, translate('Failed to change language'));
      }
    } finally {
      _isChangingLanguage = false;
      notifyListeners();
    }
  }

  Future<bool> showLanguageChangeDialog(
    BuildContext context,
    String lang,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(translate('Change Language')),
                content: Text(
                  '${translate('Change language to')} ${translate(lang)}?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(translate('Cancel')),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(translate('Confirm')),
                  ),
                ],
              ),
        ) ??
        false;
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String getLanguageName(String langCode) {
    switch (langCode) {
      case 'en':
        return translate('English');
      case 'de':
        return translate('German');
      case 'fr':
        return translate('French');
      case 'bn':
        return translate('Bangla');
      default:
        return langCode;
    }
  }

  String getLanguageFlag(String langCode) {
    switch (langCode) {
      case 'en':
        return '🇬🇧';
      case 'de':
        return '🇩🇪';
      case 'fr':
        return '🇫🇷';
      case 'bn':
        return '🇧🇩';
      default:
        return '🌐';
    }
  }

  List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'en', 'name': translate('English'), 'flag': '🇬🇧'},
      {'code': 'de', 'name': translate('German'), 'flag': '🇩🇪'},
      {'code': 'fr', 'name': translate('French'), 'flag': '🇫🇷'},
      {'code': 'bn', 'name': translate('Bangla'), 'flag': '🇧🇩'},
    ];
  }

  void disposeProvider() {
    translatorService.dispose();
  }
}
