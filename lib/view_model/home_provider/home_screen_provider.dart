import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _featureList = [
    {"image": "assets/images/fashion.png", "title": "Fashion"},
    {"image": "assets/images/home.png", "title": "Home"},
    {"image": "assets/images/electro.png", "title": "Electronics"},
    {"image": "assets/images/sports.png", "title": "Sports"},
    {"image": "assets/images/jewellery.png", "title": "Jewellery"},
    {"image": "assets/images/vehicles.png", "title": "Vehicles"},
  ];

  List<Map<String, dynamic>> get featureList => _featureList;
}
