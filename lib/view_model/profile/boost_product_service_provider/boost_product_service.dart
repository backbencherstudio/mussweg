import 'package:flutter/material.dart';

class BoostProductService extends ChangeNotifier {
  String? _selectedCondition;

  String? get selectedCondition => _selectedCondition;

  void setSelectedCondition(String? value) {
    _selectedCondition = value;
    notifyListeners();
  }
}