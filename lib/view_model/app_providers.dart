
import 'package:provider/provider.dart';

class AppProviders {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      // ChangeNotifierProvider<ParentScreenProvider>(create: (context) => ParentScreenProvider(),),
      // ChangeNotifierProvider<MoreScreenProvider>(create: (context) => MoreScreenProvider(),),
    ];
  }
}