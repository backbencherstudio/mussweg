import 'package:flutter/cupertino.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';

import '../../core/services/api_service.dart';

class HomeScreenProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _featureList = [
    {"image": "assets/icons/fasion.svg", "title": "Fashion"},
    {"image": "assets/icons/applience.svg", "title": "Home"},
    {"image": "assets/icons/electronics.svg", "title": "Electronics"},
    {"image": "assets/icons/sports.svg", "title": "Sports"},
    {"image": "assets/icons/jewellery.svg", "title": "Jewellery"},
    {"image": "assets/icons/vehicle.svg", "title": "Vehicles"},
    {"image": "assets/icons/food.svg", "title": "Vehicles"},
    {"image": "assets/icons/gadgets.svg", "title": "Vehicles"},
    {"image": "assets/icons/book.svg", "title": "Vehicles"},
    {"image": "assets/icons/library.svg", "title": "Vehicles"},
  ];

  List<Map<String, dynamic>> get featureList => _featureList;

}
