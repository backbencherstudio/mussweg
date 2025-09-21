import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/provider/app_provider.dart';
import 'core/provider/inject.dart';
import 'core/routes/route_configs.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    // Everything stays in the same zone
    WidgetsFlutterBinding.ensureInitialized();

    // Lock orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Ensure screen util
    await ScreenUtil.ensureScreenSize();

    // Dependency injection setup
    try {
      setup();
    } catch (e, st) {
      debugPrint("❌ setup() failed: $e\n$st");
    }

    runApp(const MyApp());
  }, (error, stack) {
    debugPrint("❌ Uncaught zone error: $error\n$stack");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),

            // Make sure your initial route exists
            initialRoute: '/',
            routes: {
              '/': (context) => const Scaffold(
                body: Center(child: Text("✅ Home Screen Placeholder")),
              ),
              ...AppRoutes.routes,
            },

            // Catch unknown routes
            onUnknownRoute: (settings) {
              debugPrint(
                '⚠️ Attempted to navigate to unknown route: ${settings.name}',
              );
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: const Text('Route Error')),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No route defined for: ${settings.name}'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          child: const Text('Go to Home'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
