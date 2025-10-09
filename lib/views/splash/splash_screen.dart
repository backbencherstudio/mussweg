import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_names.dart';
import '../../core/services/token_storage.dart';
import '../../view_model/parent_provider/parent_screen_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {

        final token = await TokenStorage().getToken();
        if (token != null) {
          context.read<ParentScreensProvider>().onSelectedIndex(0);
          Navigator.pushReplacementNamed(context, RouteNames.parentScreen);
        } else {
          Navigator.pushReplacementNamed(context, RouteNames.onboardingScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDE3526),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 250.w,
          height: 150.h,
        ),
      ),
    );
  }
}
