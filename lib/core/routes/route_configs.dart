import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';

import '../../views/profile/screen.dart';
import '../../views/profile/screens/view_seller_product.dart';


class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.profileScreen: (context) => const ProfileScreen(),
    RouteNames.sellerProfilePage: (context) => const SellerProfilePage(),
  };
}
