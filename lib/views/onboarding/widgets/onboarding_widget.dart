import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/route_names.dart';
import 'onboarding_page_data.dart';

class OnboardingWIdget extends StatelessWidget {
  final OnboardingPageData data;
  final int currentPage;
  final int totalPages;
  final PageController controller;

  const OnboardingWIdget({
    Key? key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Text(data.title, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black), textAlign: TextAlign.center),
                SizedBox(height: 16.h),
                Text(data.description, style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], height: 1.4), textAlign: TextAlign.center),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(width: 400.w, height: 440.h, child: Image.asset(data.imagePath, fit: BoxFit.contain)),
              Positioned(
                bottom: 20.h,
                child: ElevatedButton(
                  onPressed: () => currentPage == totalPages - 1
                      ? Navigator.pushNamed(context, RouteNames.loginScreen)
                      : controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 40.w),
                    elevation: 8, shadowColor: Colors.black.withOpacity(0.3),
                    minimumSize: Size(270.w, 56.h),
                  ),
                  child: Text(currentPage == totalPages - 1 ? "Sign Up" : "Next", style: TextStyle(fontSize: 18.sp, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}