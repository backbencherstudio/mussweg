import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final List<String> _searchHistory = [
    'Man T-shirt',
    'TV',
    'Macbook',
    'Table',
    'Mobile phone',
  ];

  String _selectedProduct = "Product";

  List<String> get searchHistory => _searchHistory;
  String get selectedProduct => _selectedProduct;

  void selectProduct(String product) {
    _selectedProduct = product;
    _searchHistory.insert(0, product);
    notifyListeners();
  }

  void removeHistory(String item) {
    _searchHistory.remove(item);
    notifyListeners();
  }
}
