import 'package:flutter/material.dart';

class SellItemService extends ChangeNotifier {
  String? location;
  String? category;
  String? size;
  String? color;
  String? condition;

  void setLocation(String? value) {
    location = value;
    notifyListeners();
  }

  void setCategory(String? value) {
    category = value;
    notifyListeners();
  }

  void setSize(String? value) {
    size = value;
    notifyListeners();
  }

  void setColor(String? value) {
    color = value;
    notifyListeners();
  }

  void setCondition(String? value) {
    condition = value;
    notifyListeners();
  }
}