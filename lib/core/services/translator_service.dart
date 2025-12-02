import 'package:flutter/foundation.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class AppTranslator {
  OnDeviceTranslator? _mlKitTranslator;
  String _currentLang = 'en';
  final bool _useOnlineTranslation = false; // Set to true for online translation

  // Languages supported by ML Kit
  static final Set<String> _mlKitSupportedLanguages = {'en', 'de', 'fr', 'bn', 'es', 'hi', 'ar'};

  // Fallback translation (simple dictionary for common words)
  static final Map<String, Map<String, String>> _fallbackTranslations = {
    'de': {
      'Small': 'Klein',
      'Medium': 'Mittel',
      'Large': 'Groß',
      'Excellent': 'Ausgezeichnet',
      'Good': 'Gut',
      'Fair': 'Mittel',
      // Add more as needed
    },
    'fr': {
      'Small': 'Petit',
      'Medium': 'Moyen',
      'Large': 'Grand',
      'Excellent': 'Excellent',
      'Good': 'Bon',
      'Fair': 'Moyen',
    },
    'bn': {
      'Small': 'ছোট',
      'Medium': 'মাঝারি',
      'Large': 'বড়',
      'Excellent': 'চমৎকার',
      'Good': 'ভাল',
      'Fair': 'মোটামুটি',
    },
  };

  Future<void> setLanguage(String targetLangCode) async {
    _currentLang = targetLangCode;

    // If language is not supported by ML Kit, don't initialize it
    if (!_mlKitSupportedLanguages.contains(targetLangCode)) {
      _mlKitTranslator = null;
      debugPrint('Language $targetLangCode not supported by ML Kit, using fallback');
      return;
    }

    try {
      final modelManager = OnDeviceTranslatorModelManager();

      // Close previous translator
      await _mlKitTranslator?.close();

      // Initialize with appropriate language
      final sourceLang = TranslateLanguage.english;
      final targetLang = _getMlKitLanguage(targetLangCode);

      if (targetLang == null) {
        _mlKitTranslator = null;
        return;
      }

      // Download model if needed
      final isModelDownloaded = await modelManager.isModelDownloaded(targetLang.bcpCode);
      if (!isModelDownloaded) {
        await modelManager.downloadModel(targetLang.bcpCode);
      }

      _mlKitTranslator = OnDeviceTranslator(
        sourceLanguage: sourceLang,
        targetLanguage: targetLang,
      );
    } catch (e) {
      debugPrint('Failed to initialize ML Kit translator: $e');
      _mlKitTranslator = null;
    }
  }

  TranslateLanguage? _getMlKitLanguage(String langCode) {
    switch (langCode) {
      case 'en': return TranslateLanguage.english;
      case 'de': return TranslateLanguage.german;
      case 'fr': return TranslateLanguage.french;
      case 'bn': return TranslateLanguage.bengali;
      case 'es': return TranslateLanguage.spanish;
      case 'hi': return TranslateLanguage.hindi;
      case 'ar': return TranslateLanguage.arabic;
      default: return null;
    }
  }

  Future<String> translateText(String text) async {
    if (text.isEmpty) return text;

    // Try ML Kit first
    if (_mlKitTranslator != null) {
      try {
        final translated = await _mlKitTranslator!.translateText(text);
        return translated;
      } catch (e) {
        debugPrint('ML Kit translation failed: $e');
      }
    }

    // Fallback to simple dictionary for common terms
    return _fallbackTranslate(text);
  }

  String _fallbackTranslate(String text) {
    final translations = _fallbackTranslations[_currentLang];

    if (translations != null) {
      // Check for exact matches first
      if (translations.containsKey(text)) {
        return translations[text]!;
      }

      // Check for partial matches (for size/condition)
      for (final key in translations.keys) {
        if (text.contains(key)) {
          return text.replaceAll(key, translations[key]!);
        }
      }
    }

    return text; // Return original if no translation found
  }

  void dispose() {
    _mlKitTranslator?.close();
  }
}