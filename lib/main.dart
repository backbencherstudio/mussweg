import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/provider/app_provider.dart';
import 'core/routes/route_configs.dart';
import 'core/routes/route_names.dart';
import 'core/services/notification_services.dart';
import 'firebase_options.dart';
import 'views/notification/notification_screen_provider.dart';

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Lock portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();

  // Initialize Notification Service
  await NotificationService().init(navigatorKey);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    // Already initialized in main, you can also call here if needed
    //_notificationService.init(navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return AppProviders.getProviders().isNotEmpty
        ? MultiProvider(
          providers: [
            ...AppProviders.getProviders(),
            ChangeNotifierProvider(create: (_) => NotificationScreenProvider()),
          ],
          child: _buildScreenUtilInit(),
        )
        : _buildScreenUtilInit();
  }

  Widget _buildScreenUtilInit() {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) => _buildMaterialApp(),
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      initialRoute: RouteNames.splashScreen,
      routes: AppRoutes.routes,
      onUnknownRoute:
          (settings) => MaterialPageRoute(
            builder:
                (context) => Scaffold(
                  appBar: AppBar(title: const Text('Route Error')),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No route defined for: ${settings.name}'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                RouteNames.splashScreen,
                              ),
                          child: const Text('Go to Home'),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}
