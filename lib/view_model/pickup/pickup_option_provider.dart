import 'package:flutter/material.dart';

enum PickupOption { sendToUs, pickupAtHome }

class PickupOptionProvider extends ChangeNotifier {
  PickupOption _selectedOption = PickupOption.pickupAtHome; // default selected

  PickupOption get selectedOption => _selectedOption;

  void selectOption(PickupOption option) {
    _selectedOption = option;
    notifyListeners();
  }
}
