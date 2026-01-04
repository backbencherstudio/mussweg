import 'package:get_it/get_it.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/view_model/home_provider/home_screen_provider.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:mussweg/view_model/profile/transaction_service_provider/transaction_service.dart';

import '../../view_model/boost_product/boost_product_create_provider.dart';
import '../../view_model/profile/boost_product_service_provider/boost_product_service.dart';
import '../../view_model/profile/language_selected_provider/language_select.dart';
import '../../view_model/profile/notification_service_provider/notification_service.dart';
import '../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import '../../view_model/search_history_provider/search_history.dart';
import '../../views/selling_items/model_view/selling_item_screen_provider.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register singletons first
  getIt.registerLazySingleton<ParentScreensProvider>(() => ParentScreensProvider());
  getIt.registerLazySingleton<HomeScreenProvider>(() => HomeScreenProvider());

  // Register factories
  getIt.registerFactory<RegisterProvider>(() => RegisterProvider());

  //Register profiles language
  getIt.registerSingleton<LanguageService>(LanguageService());
  getIt.registerSingleton<SellItemService>(SellItemService());
  getIt.registerSingleton<TransactionService>(TransactionService());
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<BoostProductService>(BoostProductService());
  getIt.registerSingleton<BoostProductCreateProvider>(BoostProductCreateProvider());
  getIt.registerSingleton<SearchProvider>(SearchProvider());
  getIt.registerSingleton<SellingItemScreenProvider>(SellingItemScreenProvider());

  print('GetIt setup completed successfully'); // Optional: for debugging
}