// lib/view_model/language/language_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/translator_service.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLang = "en";
  bool _isChangingLanguage = false;
  final AppTranslator _translatorService = AppTranslator();

  // Stream controller for real-time language updates
  final StreamController<String> _languageChangeStreamController =
  StreamController<String>.broadcast();
  Stream<String> get languageChangeStream => _languageChangeStreamController.stream;

  // Global event bus for language changes (alternative approach)
  static final _languageChangeEvents = StreamController<String>.broadcast();
  static Stream<String> get languageChangeEvents => _languageChangeEvents.stream;

  // Cache for database translations
  final Map<String, Map<String, String>> _databaseTranslationCache = {};

  // Key for SharedPreferences
  static const String _languageKey = 'app_language';

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLang = prefs.getString(_languageKey) ?? 'en';
      await setLanguage(savedLang, save: false, notifyGlobal: false);
    } catch (e) {
      debugPrint('Error loading saved language: $e');
    }
  }

  bool get isChangingLanguage => _isChangingLanguage;
  String get currentLang => _currentLang;
  AppTranslator get translatorService => _translatorService;

  // Main method to change language
  Future<void> setLanguage(
      String langCode, {
        bool save = true,
        bool notifyGlobal = true,
      }) async {
    if (_currentLang == langCode || _isChangingLanguage) return;

    _isChangingLanguage = true;
    notifyListeners();

    try {
      final oldLang = _currentLang;
      _currentLang = langCode;

      // Update translator service
      await _translatorService.setLanguage(langCode);

      // Save to SharedPreferences
      if (save) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_languageKey, langCode);
      }

      // Clear cache for old language
      clearTranslationCacheForLanguage(oldLang);

      // Notify via stream
      _languageChangeStreamController.add(langCode);

      // Global notification for app-wide updates
      if (notifyGlobal) {
        _languageChangeEvents.add(langCode);
      }

      debugPrint('Language changed to: $langCode');
    } catch (e) {
      debugPrint('Error changing language: $e');
      // Revert on error
      _currentLang = _currentLang;
      rethrow;
    } finally {
      _isChangingLanguage = false;
      notifyListeners();
    }
  }

  // Translate text
  String translate(String text) {
    return _translatorService.translateUIText(text, langCode: _currentLang);
  }

  // Translate database content
  Future<String> translateDatabaseText(String text, {String? contextKey}) async {
    if (text.isEmpty) return text;

    // Check cache first
    final cacheKey = contextKey != null ? '${contextKey}_$text' : text;
    if (_databaseTranslationCache[_currentLang]?.containsKey(cacheKey) == true) {
      return _databaseTranslationCache[_currentLang]![cacheKey]!;
    }

    // Translate using ML Kit or fallback
    final translated = await _translatorService.translateText(text);

    // Cache the result
    if (!_databaseTranslationCache.containsKey(_currentLang)) {
      _databaseTranslationCache[_currentLang] = {};
    }
    _databaseTranslationCache[_currentLang]![cacheKey] = translated;

    return translated;
  }

  // Clear translation cache
  void clearTranslationCache() {
    _databaseTranslationCache.clear();
  }

  // Clear cache for specific language
  void clearTranslationCacheForLanguage(String langCode) {
    _databaseTranslationCache.remove(langCode);
  }

  // Language name
  String getLanguageName(String langCode) {
    switch (langCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'German';
      case 'fr':
        return 'French';
      case 'bn':
        return 'Bangla';
      default:
        return langCode.toUpperCase();
    }
  }

  // Get all supported languages
  List<Map<String, String>> getAllLanguages() {
    return [
      {'code': 'en', 'name': 'English'},
      {'code': 'de', 'name': 'German'},
      {'code': 'fr', 'name': 'French'},
      {'code': 'bn', 'name': 'Bangla'},
    ];
  }

  // Check if language is supported
  bool isLanguageSupported(String langCode) {
    final languages = getAllLanguages();
    return languages.any((lang) => lang['code'] == langCode);
  }

  @override
  void dispose() {
    _languageChangeStreamController.close();
    _translatorService.dispose();
    super.dispose();
  }
}