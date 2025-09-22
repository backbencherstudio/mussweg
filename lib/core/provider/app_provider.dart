import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:mussweg/view_model/home_provider/home_screen_provider.dart';
import '../../view_model/profile/boost_product_service_provider/boost_product_service.dart';
import '../../view_model/profile/language_selected_provider/language_select.dart';
import '../../view_model/profile/notification_service_provider/notification_service.dart';
import '../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import '../../view_model/profile/transaction_service_provider/transaction_service.dart';
import '../../view_model/search_history_provider/search_history.dart';
import 'inject.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => getIt<ParentScreensProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<HomeScreenProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<LanguageService>()),
    ChangeNotifierProvider(create: (_) => getIt<SellItemService>()),
    ChangeNotifierProvider(create: (_) => getIt<TransactionService>()),
    ChangeNotifierProvider(create: (_) => getIt<NotificationService>()),
    ChangeNotifierProvider(create: (_) => getIt<BoostProductService>()),
    ChangeNotifierProvider(create: (_) => getIt<SearchProvider>()),
    // Remove SignUpViewModel from here - it will be created locally in the widget
  ];
}