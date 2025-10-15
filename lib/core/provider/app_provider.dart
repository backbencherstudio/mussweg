import 'package:mussweg/view_model/home_provider/all_category_provider.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:mussweg/view_model/home_provider/home_screen_provider.dart';
import '../../view_model/auth/login/get_me_viewmodel.dart';
import '../../view_model/auth/login/login_viewmodel.dart';
import '../../view_model/home_provider/favorite_icon_provider.dart';
import '../../view_model/profile/boost_product_service_provider/boost_product_service.dart';
import '../../view_model/profile/language_selected_provider/language_select.dart';
import '../../view_model/profile/notification_service_provider/notification_service.dart';
import '../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import '../../view_model/profile/transaction_service_provider/transaction_service.dart';
import '../../view_model/search_history_provider/search_history.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ParentScreensProvider()),
    ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
    ChangeNotifierProvider(create: (_) => LanguageService()),
    ChangeNotifierProvider(create: (_) => SellItemService()),
    ChangeNotifierProvider(create: (_) => TransactionService()),
    ChangeNotifierProvider(create: (_) => NotificationService()),
    ChangeNotifierProvider(create: (_) => BoostProductService()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ChangeNotifierProvider(create: (_) => LoginScreenProvider()),
    ChangeNotifierProvider(create: (_) => AllCategoryProvider()),
    ChangeNotifierProvider(create: (_) => GetMeViewmodel()),
  ];
}