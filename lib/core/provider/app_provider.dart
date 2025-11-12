import 'package:mussweg/view_model/bid/place_a_bid_provider.dart';
import 'package:mussweg/view_model/home_provider/all_category_provider.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/view_model/pickup/pickup_option_provider.dart';
import 'package:mussweg/view_model/profile/update_item_service.dart';
import 'package:mussweg/view_model/profile/update_profile/update_profile_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:mussweg/view_model/home_provider/home_screen_provider.dart';
import '../../view_model/auth/login/get_me_viewmodel.dart';
import '../../view_model/auth/login/login_viewmodel.dart';
import '../../view_model/boost_product/boost_product_create_provider.dart';
import '../../view_model/home_provider/home_nav/electronic_category_based_provider.dart';
import '../../view_model/home_provider/home_nav/fashion_category_based_product_provider.dart';
import '../../view_model/home_provider/favorite_icon_provider.dart';
import '../../view_model/home_provider/home_nav/home_category_based_provider.dart';
import '../../view_model/pickup/pickup_timer_provider.dart';
import '../../view_model/product_item_list_provider/category_based_product_provider.dart';
import '../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../view_model/profile/boost_product_service_provider/boost_product_service.dart';
import '../../view_model/profile/edit_image/edit_image.dart';
import '../../view_model/profile/language_selected_provider/language_select.dart';
import '../../view_model/profile/notification_service_provider/notification_service.dart';
import '../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import '../../view_model/profile/transaction_service_provider/transaction_service.dart';
import '../../view_model/profile/user_all_products/user_all_products_provider.dart';
import '../../view_model/search_history_provider/search_history.dart';
import '../../view_model/whistlist/whistlist_provider_of_get_favourite_product.dart';
import '../../view_model/whistlist/wishlist_create.dart';
import '../../views/bought_items/viewModel/bought_product/bought_product_provider.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ParentScreensProvider()),
    ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
    ChangeNotifierProvider(create: (_) => LanguageService()),
    ChangeNotifierProvider(create: (_) => SellItemService()),
    ChangeNotifierProvider(create: (_) => UpdateItemService()),
    ChangeNotifierProvider(create: (_) => TransactionService()),
    ChangeNotifierProvider(create: (_) => NotificationService()),
    ChangeNotifierProvider(create: (_) => BoostProductService()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ChangeNotifierProvider(create: (_) => LoginScreenProvider()),
    ChangeNotifierProvider(create: (_) => AllCategoryProvider()),
    ChangeNotifierProvider(create: (_) => GetMeViewmodel()),
    ChangeNotifierProvider(create: (_) => PickupTimerProvider()),
    ChangeNotifierProvider(create: (_) => PickupOptionProvider()),
    ChangeNotifierProvider(create: (_) => FashionCategoryBasedProductProvider()),
    ChangeNotifierProvider(create: (_) => HomeCategoryBasedProvider()),
    ChangeNotifierProvider(create: (_) => ElectronicCategoryBasedProvider()),
    ChangeNotifierProvider(create: (_) => CategoryBasedProductProvider()),
    ChangeNotifierProvider(create: (_) => WhistlistProviderOfGetFavouriteProduct()),
    ChangeNotifierProvider(create: (_) => WishlistCreate()),
    ChangeNotifierProvider(create: (_) => SellerProfileProvider()),
    ChangeNotifierProvider(create: (_) => BoostProductCreateProvider()),
    ChangeNotifierProvider(create: (_) => UserAllProductsProvider()),
    ChangeNotifierProvider(create: (_) => UpdateProfileDetailsProvider()),
    ChangeNotifierProvider(create: (_) => GetProductDetailsProvider()),
    ChangeNotifierProvider(create: (_) => PlaceABidProvider()),
    ChangeNotifierProvider(create: (_) => BoughtProductProvider()),
  ];
}