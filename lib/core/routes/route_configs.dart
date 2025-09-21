import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/home/screen/home_screen.dart';
import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';


class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    RouteNames.parentScreen: (context) => const ParentScreen(),
  };
}
