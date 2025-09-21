import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
<<<<<<< HEAD
import 'package:mussweg/views/onboarding/screen/onboarding_screen.dart';
=======
>>>>>>> b2917dfa1b073fc413dbb67229ef40fcb023948d
import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';
import 'package:mussweg/views/splash/splash_screen.dart';
import 'package:mussweg/views/wishlist/wishlist_screen.dart';

import '../../views/profile/screen.dart';
import '../../views/profile/screens/view_seller_product.dart';


class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {



    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onBoardingScreen : (context) => const OnboardingScreen (),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.profileScreen: (context) => const ProfileScreen(),
    RouteNames.sellerProfilePage: (context) => const SellerProfilePage(),
    RouteNames.wishlistScreen: (context) => const WishlistScreen(),
  };
}
