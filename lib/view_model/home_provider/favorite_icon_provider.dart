import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final Map<String, bool> _favoriteStatus = {};

  bool isFavorite(String productId) {
    return _favoriteStatus[productId] ?? false;
  }

  void toggleFavorite(String productId, bool value) {
    _favoriteStatus[productId] = value;
    notifyListeners();
  }
}
