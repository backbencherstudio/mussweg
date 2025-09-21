import 'package:get_it/get_it.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';

import '../../view_model/auth/signup/signup_viewmodel.dart';
import '../../view_model/home_provider/home_screen_provider.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register ParentScreenProvider with GetIt
  getIt.registerLazySingleton<ParentScreenProvider>(
    () => ParentScreenProvider(),
  );
  getIt.registerLazySingleton<HomeScreenProvider>(() => HomeScreenProvider());

  getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel());
}
