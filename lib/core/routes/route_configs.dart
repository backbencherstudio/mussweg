import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/profile/screen.dart';


class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => ProfileScreen(),

    RouteName.profileScreen: (context) => const ProfileScreen(),


  };
}