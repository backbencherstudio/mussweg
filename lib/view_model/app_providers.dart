//
// import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
// import 'package:provider/provider.dart';
//
// import 'auth/signup/signup_viewmodel.dart';
// import 'home_provider/home_screen_provider.dart';
//
// class AppProviders {
//   static List<ChangeNotifierProvider> getProviders() {
//     return [
//       ChangeNotifierProvider<SignUpViewModel>(create: (context) => SignUpViewModel(),),
//        ChangeNotifierProvider<ParentScreensProvider>(create: (context) => ParentScreensProvider(),),
//        ChangeNotifierProvider<HomeScreenProvider>(create: (context) => HomeScreenProvider(),),
//       //     ChangeNotifierProvider(create: (_) => getIt<ParentScreenProvider>()),
// //     ChangeNotifierProvider(create: (_) => getIt<HomeScreenProvider>()),
// //     ChangeNotifierProvider(create: (_) => getIt<SignUpViewModel>()),
//     ];
//   }
// }