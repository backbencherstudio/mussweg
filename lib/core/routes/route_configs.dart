import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';
import 'package:mussweg/views/splash/splash_screen.dart';

import '../../views/auth/sign_up/screen/signup_screen.dart';
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
    RouteNames.sellItemPage: (context) => const SellItemPage(),
    RouteNames.editProductPage: (context) => const EditProductPage(),
    RouteNames.boostProductPage: (context) => const BoostProductPage(),
    RouteNames.boostSuccessPage: (context) => const BoostSuccessPage(),
    //RouteNames.wishlistScreen: (context) => const WishlistScreen(),
  };
}