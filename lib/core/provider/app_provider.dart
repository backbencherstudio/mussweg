import 'package:mussweg/view_model/auth/login/user_profile_get_me_provider.dart';
import 'package:mussweg/view_model/bid/bid_for_buyer_provider.dart';
import 'package:mussweg/view_model/bid/place_a_bid_provider.dart';
import 'package:mussweg/view_model/client_dashboard/client_dashboard_details_provider.dart';
import 'package:mussweg/view_model/home_provider/all_category_provider.dart';
import 'package:mussweg/view_model/mussweg/mussweg_product_screen_provider.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/view_model/pickup/pickup_option_provider.dart';
import 'package:mussweg/view_model/profile/update_item_service.dart';
import 'package:mussweg/view_model/profile/update_profile/update_profile_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:mussweg/view_model/home_provider/home_screen_provider.dart';
import '../../view_model/auth/forget_password/forget_password_provider.dart';
import '../../view_model/auth/login/get_me_viewmodel.dart';
import '../../view_model/auth/login/login_viewmodel.dart';
import '../../view_model/bid/bid_for_seller_provider.dart';
import '../../view_model/boost_product/boost_product_create_provider.dart';
import '../../view_model/home_provider/home_nav/electronic_category_based_provider.dart';
import '../../view_model/home_provider/home_nav/fashion_category_based_product_provider.dart';
import '../../view_model/home_provider/favorite_icon_provider.dart';
import '../../view_model/home_provider/home_nav/home_category_based_provider.dart';
import '../../view_model/my_dashboard/my_dashboard_response_provider.dart';
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
import '../../views/auth/disposal/get_disposal_items_provider.dart';
import '../../views/bought_items/viewModel/bought_product/bought_product_provider.dart';
import '../../views/bought_items/viewModel/bought_product/review_provider.dart';
import '../../views/cart/view_model/payment_screen_provider.dart';
import '../../views/inbox/view_model/inbox_screen_provider.dart';
import '../../views/selling_items/model_view/selling_item_screen_provider.dart';

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
    ChangeNotifierProvider(create: (_) => BidForSellerProvider()),
    ChangeNotifierProvider(create: (_) => BidForBuyerProvider()),
    ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
    ChangeNotifierProvider(create: (_) => AllCategoryProvider()),
    ChangeNotifierProvider(create: (_) => GetMeViewmodel()),
    ChangeNotifierProvider(create: (_) => UserProfileGetMeProvider()),
    ChangeNotifierProvider(create: (_) => PickupTimerProvider()),
    ChangeNotifierProvider(create: (_) => PickupOptionProvider()),
    ChangeNotifierProvider(create: (_) => FashionCategoryBasedProductProvider()),
    ChangeNotifierProvider(create: (_) => HomeCategoryBasedProvider()),
    ChangeNotifierProvider(create: (_) => ElectronicCategoryBasedProvider()),
    ChangeNotifierProvider(create: (_) => CategoryBasedProductProvider()),
    ChangeNotifierProvider(create: (_) => WhistlistProviderOfGetFavouriteProduct()),
    ChangeNotifierProvider(create: (_) => WishlistCreate()),
    ChangeNotifierProvider(create: (_) => SellerProfileProvider()),
    ChangeNotifierProvider(create: (_) => MusswegProductScreenProvider()),
    ChangeNotifierProvider(create: (_) => BoostProductCreateProvider()),
    ChangeNotifierProvider(create: (_) => UserAllProductsProvider()),
    ChangeNotifierProvider(create: (_) => UpdateProfileDetailsProvider()),
    ChangeNotifierProvider(create: (_) => GetProductDetailsProvider()),
    ChangeNotifierProvider(create: (_) => PlaceABidProvider()),
    ChangeNotifierProvider(create: (_) => BoughtProductProvider()),
    ChangeNotifierProvider(create: (_) => ReviewProvider()),
    ChangeNotifierProvider(create: (_) => ClientDashboardDetailsProvider()),
    ChangeNotifierProvider(create: (_) => MyDashboardResponseProvider()),
    ChangeNotifierProvider(create: (_) => GetDisposalItemsProvider()),
    ChangeNotifierProvider(create: (_) => InboxScreenProvider()),
    ChangeNotifierProvider(create: (_) => SellingItemScreenProvider()),
    ChangeNotifierProvider(create: (_) => PaymentScreenProvider()),
  ];
}