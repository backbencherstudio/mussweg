import 'package:flutter/material.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/bought_items/bought_items_screen.dart';
import 'package:mussweg/views/cart/cart_screen.dart';
import 'package:mussweg/views/checkout/screen/checkout_cart_list_screen.dart';

import 'package:mussweg/views/onboarding/screen/onboarding_screen.dart';

import 'package:mussweg/views/parent_screen/screen/parent_screen.dart';
import 'package:mussweg/views/selling_items/selling_items_screen.dart';
import 'package:mussweg/views/splash/splash_screen.dart';
import 'package:mussweg/views/wishlist/wishlist_screen.dart';

import '../../views/auth/sign_up/screen/sign_up_screen.dart';
import '../../views/auth/otp_verify/otp_screen.dart';
import '../../views/checkout/screen/stripe_checkout_screen.dart';
import '../../views/home/screens/chat_screen.dart';
import '../../views/home/screens/product_details_bid_screens.dart';
import '../../views/home/screens/product_details_buy_screens.dart';
import '../../views/home/screens/product_list_screen.dart';
import '../../views/home/screens/category_screen.dart';
import '../../views/home/screens/view_profile.dart';
import '../../views/auth/login/login_screen.dart';
import '../../views/onboarding/screen/onboarding_screen.dart';
import '../../views/inbox/screen.dart';
import '../../views/inbox/screens/account_settings.dart';
import '../../views/order_placed/screen/order_placed_screen.dart';
import '../../views/profile/screen.dart';
import '../../views/profile/screens/bid_list/bid_list.dart';
import '../../views/profile/screens/boost_product/boost_product.dart';
import '../../views/profile/screens/boost_product/boost_success_page.dart';
import '../../views/profile/screens/languages/language_page.dart';
import '../../views/profile/screens/transaction/transactions_history.dart';
import '../../views/profile/screens/view_profile/edit_product_page.dart';
import '../../views/profile/screens/notifications/notifications_page.dart';
import '../../views/profile/screens/view_profile/sell_item.dart';
import '../../views/profile/screens/view_profile/view_seller_product.dart';
import '../../views/home/screens/search.dart';


class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {

    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.signUpScreen: (context) => const SignUpScreen(),
    RouteNames.otpScreen: (context) => const OtpScreen(),
    RouteNames.profileScreen: (context) => const ProfileScreen(),
    RouteNames.sellerProfilePage: (context) => const SellerProfilePage(),
    RouteNames.categoryScreen: (context) => const CategoryScreen(),
    RouteNames.productListScreen: (context) => const ProductListScreen(),
    RouteNames.productDetailsBidScreens: (context) => const ProductDetailsBidScreens(),
    RouteNames.chatScreen: (context) => const ChatScreen(),
    RouteNames.viewProfileScreen: (context) =>  ViewProfileScreen(),
    RouteNames.boughtItemsScreen: (context) => BoughtItemsScreen(),
    RouteNames.sellingItemsScreen: (context) => SellingItemsScreen(),
    RouteNames.sellItemPage: (context) => const SellItemPage(),
    RouteNames.editProductPage: (context) => const EditProductPage(),
    RouteNames.boostProductPage: (context) =>  BoostProductPage(),
    RouteNames.boostSuccessPage: (context) => const BoostSuccessPage(),
    RouteNames.onboardingScreen: (context) => const OnboardingScreen(),
    RouteNames.inboxPage: (context) => const InboxPage(),
    RouteNames.accountSettingsPage: (context) => const AccountSettingsPage(),
    RouteNames.notificationsPage: (context) => const NotificationsPage(),
    RouteNames.languagePage: (context) =>  LanguagePage(),
    RouteNames.transactionsHistoryPage: (context) => const TransactionsHistoryPage(),
    //RouteNames.wishlistScreen: (context) => const WishlistScreen(),

    RouteNames.checkoutScreen:(context) => const CheckoutScreen(),
    RouteNames.stripeCheckoutScreen:(context) => const StripeCheckoutScreen(),
    RouteNames.searchPage:(context) => const SearchPage(),
    RouteNames.orderPlacedScreen:(context) => const OrderPlacedScreen(),
    RouteNames.cartScreen:(context) => const CartScreen(),
    RouteNames.loginScreen:(context) => const LoginScreen(),
    RouteNames.productDetailsBuyScreens:(context) => const ProductDetailsBuyScreens(),
    RouteNames.bidList:(context) => const BidList(),
  };
}