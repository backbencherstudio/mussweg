import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';
import 'package:mussweg/views/splash/splash_screen.dart';

import '../../views/home/screens/chat_screen.dart';
import '../../views/home/screens/product_detail_screens.dart';
import '../../views/home/screens/product_list_screen.dart';
import '../../views/home/screens/category_screen.dart';
import '../../views/home/screens/view_profile.dart';
import '../../views/auth/sign_up/screen/signup_screen.dart';
import '../../views/onboarding/screen/onboarding_screen.dart';
import '../../views/profile/screen.dart';
import '../../views/profile/screens/boost_product.dart';
import '../../views/profile/screens/boost_success_page.dart';
import '../../views/profile/screens/edit_product_page.dart';
import '../../views/profile/screens/sell_item.dart';
import '../../views/profile/screens/view_seller_product.dart';


class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {

    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.signUpScreen: (context) => const SignupScreen(),
    RouteNames.profileScreen: (context) => const ProfileScreen(),
    RouteNames.sellerProfilePage: (context) => const SellerProfilePage(),
    RouteNames.categoryScreen: (context) => const CategoryScreen(),
    RouteNames.productListScreen: (context) => const ProductListScreen(),
    RouteNames.productDetailScreens: (context) => const ProductDetailScreens(),
    RouteNames.chatScreen: (context) => const ChatScreen(),
    RouteNames.viewProfileScreen: (context) => const ViewProfileScreen(),
    RouteNames.sellItemPage: (context) => const SellItemPage(),
    RouteNames.editProductPage: (context) => const EditProductPage(),
    RouteNames.boostProductPage: (context) => const BoostProductPage(),
    RouteNames.boostSuccessPage: (context) => const BoostSuccessPage(),
    RouteNames.onboardingScreen: (context) => const OnboardingScreen(),
  };
}