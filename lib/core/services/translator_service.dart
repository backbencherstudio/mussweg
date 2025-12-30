import 'package:flutter/foundation.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class AppTranslator {
  OnDeviceTranslator? _mlKitTranslator;
  String _currentLang = 'en';
  final bool _useOnlineTranslation = false;

  // Languages supported by ML Kit
  static final Set<String> _mlKitSupportedLanguages = {
    'en',
    'de',
    'fr',
    'es',
    'hi',
    'ar',
  };

  // Fallback translation for product attributes
  static final Map<String, Map<String, String>> _fallbackTranslations = {
    // 'de': {
    //   'Small': 'Klein',
    //   'Large': 'Groß',
    //   'Excellent': 'Ausgezeichnet',
    //   'Good': 'Gut',
    //   'Fair': 'Mittel',
    //   'Used': 'Gebraucht',
    //   'Red': 'Rot',
    //   'Blue': 'Blau',
    //   'Green': 'Grün',
    //   'Black': 'Schwarz',
    //   'White': 'Weiß',
    // },
    // 'fr': {
    //   'Small': 'Petit',
    //   'Large': 'Grand',
    //   'Excellent': 'Excellent',
    //   'Good': 'Bon',
    //   'Fair': 'Moyen',
    //   'Used': 'Usagé',
    //   'Red': 'Rouge',
    //   'Blue': 'Bleu',
    //   'Green': 'Vert',
    //   'Black': 'Noir',
    //   'White': 'Blanc',
    // },
    // 'bn': {
    //   'Small': 'ছোট',
    //   'Large': 'বড়',
    //   'Excellent': 'চমৎকার',
    //   'Good': 'ভাল',
    //   'Fair': 'মাঝারি',
    //   'Used': 'ব্যবহৃত',
    //   'Red': 'লাল',
    //   'Blue': 'নীল',
    //   'Green': 'সবুজ',
    //   'Black': 'কালো',
    //   'White': 'সাদা',
    // },
  };

  // UI Text translations
  static String _getTranslatedUIText(String text, String langCode) {
    // Simple translation dictionary for UI texts
    final translations = {
      'en': {
        'Wishlist': 'Wishlist',
        'Favourite List': 'Favourite List',
        'No Favourite Product Found': 'No Favourite Product Found',
        'Size': 'Size',
        'condition': 'condition',
        'Language': 'Language',
        'Translating content...': 'Translating content...',
        'My Products': 'My Products',
        'products uploaded': 'products uploaded',
        'No products yet': 'No products yet',
        'Start selling by clicking the Sell button':
            'Start selling by clicking the Sell button',
        'Sell': 'Sell',
        'Edit': 'Edit',
        'Boost': 'Boost',
        'Delete': 'Delete',
        'Delete Product': 'Delete Product',
        'Are you sure you want to delete this product?':
            'Are you sure you want to delete this product?',
        'Cancel': 'Cancel',
        'Product Deleted': 'Product Deleted',
        'Muss Weg': 'Muss Weg',
        'Change Language': 'Change Language',
        'Change language to': 'Change language to',
        'Confirm': 'Confirm',
        'Failed to change language': 'Failed to change language',
        'Error': 'Error',
        'Retry': 'Retry',
        'Something went wrong': 'Something went wrong',
        "table": "table",
      },
      'de': {
        'Wishlist': 'Wunschliste',
        'Favourite List': 'Favoritenliste',
        'No Favourite Product Found': 'Kein Favoritenprodukt gefunden',
        'Size': 'Größe',
        'condition': 'Zustand',
        'Language': 'Sprache',
        'Translating content...': 'Inhalt wird übersetzt...',
        'My Products': 'Meine Produkte',
        'products uploaded': 'Produkte hochgeladen',
        'No products yet': 'Noch keine Produkte',
        'Start selling by clicking the Sell button':
            'Beginnen Sie mit dem Verkauf, indem Sie auf die Schaltfläche "Verkaufen" klicken',
        'Sell': 'Verkaufen',
        'Edit': 'Bearbeiten',
        'Boost': 'Boosten',
        'Delete': 'Löschen',
        'Delete Product': 'Produkt löschen',
        'Are you sure you want to delete this product?':
            'Sind Sie sicher, dass Sie dieses Produkt löschen möchten?',
        'Cancel': 'Abbrechen',
        'Product Deleted': 'Produkt gelöscht',
        'Muss Weg': 'Muss Weg',
        'Change Language': 'Sprache ändern',
        'Change language to': 'Sprache ändern zu',
        'Confirm': 'Bestätigen',
        'Failed to change language': 'Sprachänderung fehlgeschlagen',
        'Error': 'Fehler',
        'Retry': 'Wiederholen',
        'Something went wrong': 'Etwas ist schief gelaufen',
        "table": "Tisch",
      },
      'fr': {
        'Wishlist': 'Liste de souhaits',
        'Favourite List': 'Liste des favoris',
        'No Favourite Product Found': 'Aucun produit favori trouvé',
        'Size': 'Taille',
        'condition': 'état',
        'Language': 'Langue',
        'Translating content...': 'Traduction du contenu...',
        'My Products': 'Mes Produits',
        'products uploaded': 'produits téléchargés',
        'No products yet': 'Pas encore de produits',
        'Start selling by clicking the Sell button':
            'Commencez à vendre en cliquant sur le bouton "Vendre"',
        'Sell': 'Vendre',
        'Edit': 'Modifier',
        'Boost': 'Booster',
        'Delete': 'Supprimer',
        'Delete Product': 'Supprimer le produit',
        'Are you sure you want to delete this product?':
            'Êtes-vous sûr de vouloir supprimer ce produit?',
        'Cancel': 'Annuler',
        'Product Deleted': 'Produit supprimé',
        'Muss Weg': 'Muss Weg',
        'Change Language': 'Changer de langue',
        'Change language to': 'Changer la langue en',
        'Confirm': 'Confirmer',
        'Failed to change language': 'Échec du changement de langue',
        'Error': 'Erreur',
        'Retry': 'Réessayer',
        'Something went wrong': 'Quelque chose a mal tourné',
        "name": "tableau",
      },
    };

    return translations[langCode]?[text] ?? text;
  }

  // Public method to get UI translations
  String translateUIText(String text, {String? langCode}) {
    final language = langCode ?? _currentLang;
    return _getTranslatedUIText(text, language);
  }

  Future<void> setLanguage(String targetLangCode) async {
    _currentLang = targetLangCode;

    // If language is not supported by ML Kit, don't initialize it
    if (!_mlKitSupportedLanguages.contains(targetLangCode)) {
      _mlKitTranslator = null;
      debugPrint(
        'Language $targetLangCode not supported by ML Kit, using fallback',
      );
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
      final isModelDownloaded = await modelManager.isModelDownloaded(
        targetLang.bcpCode,
      );
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
      case 'en':
        return TranslateLanguage.english;
      case 'de':
        return TranslateLanguage.german;
      case 'fr':
        return TranslateLanguage.french;
      case 'es':
        return TranslateLanguage.spanish;
      case 'hi':
        return TranslateLanguage.hindi;
      case 'ar':
        return TranslateLanguage.arabic;
      default:
        return null;
    }
  }

  Future<String> translateText(String text) async {
    if (text.isEmpty) return text;

    // First check if it's a known UI text
    final uiTranslation = _getTranslatedUIText(text, _currentLang);
    if (uiTranslation != text) {
      return uiTranslation;
    }

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

    return text;
  }

  String get currentLanguage => _currentLang;

  bool isLanguageSupported(String langCode) {
    return _mlKitSupportedLanguages.contains(langCode) ||
        _fallbackTranslations.containsKey(langCode);
  }

  void dispose() {
    _mlKitTranslator?.close();
  }
}
