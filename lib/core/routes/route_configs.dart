import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/onboarding/screen/onboarding_screen.dart';
import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';
import 'package:mussweg/views/splash/splash_screen.dart';


class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onBoardingScreen : (context) => const OnboardingScreen (),
    RouteNames.parentScreen: (context) => const ParentScreen(),
  };
}
