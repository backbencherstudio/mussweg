import 'package:flutter/material.dart';
import 'package:mussweg/views/cart/cart_screen.dart';
import 'package:mussweg/views/checkout/screen/checkout_cart_list_screen.dart';
import 'package:mussweg/views/inbox/screen.dart';
import 'package:mussweg/views/profile/screen.dart';

import '../../views/home/screen/home_screen.dart';
import '../../views/wishlist/wishlist_screen.dart';


class ParentScreensProvider with ChangeNotifier {
  List<Widget> screens = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    InboxPage(),
    ProfileScreen(),

  ];
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
    debugPrint("Selected Index : $selectedIndex");
  }

  gotoFeedScreen() {
    _selectedIndex = 3;
    notifyListeners();
  }

  gotoHomeScreen() {
    _selectedIndex = 0;
    notifyListeners();
  }
}