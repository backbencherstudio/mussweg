
import 'package:provider/provider.dart';

import 'auth/signup/signup_viewmodel.dart';

class AppProviders {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider<SignUpViewModel>(create: (context) => SignUpViewModel(),),
      // ChangeNotifierProvider<MoreScreenProvider>(create: (context) => MoreScreenProvider(),),
    ];
  }
}