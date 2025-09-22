import 'package:flutter/material.dart';

class TransactionService extends ChangeNotifier {
  String _selectedFilter = 'All';

  String get selectedFilter => _selectedFilter;

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
}
