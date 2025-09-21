// core/provider/app_provider.dart
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart'; // Correct path
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../view_model/auth/signup/signup_viewmodel.dart';
import '../../view_model/home_provider/home_screen_provider.dart';
import 'inject.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => getIt<ParentScreenProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<HomeScreenProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<SignUpViewModel>()),
  ];
}
