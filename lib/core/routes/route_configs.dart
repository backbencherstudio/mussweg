import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';

import 'package:mussweg/views/onboarding/screen/onboarding_screen.dart';

import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';
import 'package:mussweg/views/splash/splash_screen.dart';

import '../../views/home/screens/chat_screen.dart';
import '../../views/home/screens/product_detail_screens.dart';
import '../../views/home/screens/product_list_screen.dart';
import '../../views/home/screens/category_screen.dart';
import '../../views/home/screens/view_profile.dart';
import '../../views/profile/screen.dart';
import '../../views/profile/screens/view_seller_product.dart';


class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onBoardingScreen : (context) => const OnboardingScreen (),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.profileScreen: (context) => const ProfileScreen(),
    RouteNames.sellerProfilePage: (context) => const SellerProfilePage(),
    RouteNames.categoryScreen: (context) => const CategoryScreen(),
    RouteNames.productListScreen: (context) => const ProductListScreen(),
    RouteNames.productDetailScreens: (context) => const ProductDetailScreens(),
    RouteNames.chatScreen: (context) => const ChatScreen(),
    RouteNames.viewProfileScreen: (context) => const ViewProfileScreen(),
  };
}
