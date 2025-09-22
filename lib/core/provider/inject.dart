import 'package:get_it/get_it.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/view_model/home_provider/home_screen_provider.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register singletons first
  getIt.registerLazySingleton<ParentScreensProvider>(() => ParentScreensProvider());
  getIt.registerLazySingleton<HomeScreenProvider>(() => HomeScreenProvider());

  // Register factories
  getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel());

  print('GetIt setup completed successfully'); // Optional: for debugging
}