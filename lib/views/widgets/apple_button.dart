import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/routes/route_names.dart';
import '../../view_model/auth/login/google_login.dart'; // same as LoginViewModel

class AppleButton extends StatelessWidget {
  const AppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Consumer<LoginViewModel>(
        builder: (context, loginProvider, _) {
          return InkWell(
            onTap: () async {
              loginProvider.setLoadingForGoogle(true);
              try {
                final result = await loginProvider.appleSignIn();
                if (result['success'] == true && context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.parentScreen,
                    (route) => false,
                  );
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result['message'] ?? "Apple login failed."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } finally {
                loginProvider.setLoadingForGoogle(false);
              }
            },
            borderRadius: BorderRadius.circular(32.r),
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffdcd7d7)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/apple-icon.png',
                    height: 25.h,
                    width: 25.h,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Sign in with Apple",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
