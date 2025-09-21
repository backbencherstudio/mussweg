// core/provider/app_provider.dart
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';  // Correct path
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'inject.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    // Using getIt to fetch the instance of ParentScreenProvider
    ChangeNotifierProvider(create: (_) => getIt<ParentScreenProvider>()),
  ];
}
