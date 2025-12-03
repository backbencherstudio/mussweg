import 'package:flutter/material.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/translator_service.dart';
import '../../../data/model/user/my_dashboard_response_model.dart';

class MyDashboardResponseProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AppTranslator _translator = AppTranslator(); // Added

  bool _isTranslating = false;
  bool _loading = false;
  bool get loading => _loading;

  MyDashboardResponseModel? _myDashboardResponseModel;
  MyDashboardResponseModel? get myDashboardResponseModel => _myDashboardResponseModel;

  String _currentLanguage = 'en';
  String get currentLanguage => _currentLanguage;

  String? _error;
  String? get error => _error;

  final Map<String, Map<String, String>> _translationCache = {};

  Future<void> changeLanguage(String langCode) async {
    if (_currentLanguage == langCode) return;

    _currentLanguage = langCode;
    await _translator.setLanguage(langCode);

    _translationCache.clear();
    notifyListeners();

    if (_myDashboardResponseModel != null) {
      _isTranslating = true;
      notifyListeners();

      await _translateAllReviews(_myDashboardResponseModel!.data.reviews.data);

      _isTranslating = false;
      notifyListeners();
    }
  }

  Future<void> _translateAllReviews(List<ReviewData> items) async {
    if (items.isEmpty) return;

    final cacheKey = 'review_$_currentLanguage';
    if (!_translationCache.containsKey(cacheKey)) {
      _translationCache[cacheKey] = {};
    }
    final cache = _translationCache[cacheKey]!;

    for (var review in items) {
      final key = 'comment_${review.id}';
      if (!cache.containsKey(key)) {
        final translated = await _translator.translateText(review.comment);
        review.translatedComment = translated;
        cache[key] = translated;
      } else {
        review.translatedComment = cache[key];
      }
    }
  }

  Future<void> fetchMyDashboardData() async {
    _setLoading(true);
    _error = null;

    try {
      final response = await _apiService.get(ApiEndpoints.getMyDashboardDetails);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _myDashboardResponseModel = MyDashboardResponseModel.fromJson(response.data);

        // Translate reviews after loading
        if (_myDashboardResponseModel!.data.reviews.data.isNotEmpty) {
          _isTranslating = true;
          notifyListeners();
          await _translateAllReviews(_myDashboardResponseModel!.data.reviews.data);
          _isTranslating = false;
          notifyListeners();
        }
      } else {
        _error = response.data['message'] ?? "Server error";
        _myDashboardResponseModel = null;
      }
    } catch (e, stack) {
      debugPrint("Dashboard fetch error: $e\n$stack");
      _error = "Failed to load dashboard";
      _myDashboardResponseModel = null;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}