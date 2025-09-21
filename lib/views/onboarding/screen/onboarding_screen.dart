import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // PageController to control the pages
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                // Screen 1
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text above the image
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 60.h),
                            Text(
                              "Sell Fast. Buy Smart",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Easily list your items, explore great deals, and complete trades — all within 48 hours to keep the marketplace fast and fresh.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      ),
                      // Image with button positioned halfway down
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 400.w,
                            height: 440.h,
                            child: Image.asset(
                              "assets/images/onboarding image 1.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: 20.h,
                            // Positioned with a small gap from the bottom
                            child: ElevatedButton(
                              onPressed: () {
                                if (_currentPage == 2) {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.parentScreen,
                                  );
                                } else {
                                  _controller.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 40.w,
                                ),
                                elevation: 8,
                                shadowColor: Colors.black.withOpacity(0.3),
                                minimumSize: Size(270.w, 56.h),
                              ),
                              child: Text(
                                _currentPage == 2 ? "Sign Up" : "Next",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Screen 2 (similarly structured)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text above the image
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 60.h),
                            Text(
                              "Limited Time, Unlimited Deals.",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Enjoy unlimited deals on a platform where every listing is available for a limited time, creating a fast and exciting marketplace experience",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      ),
                      // Image with button positioned halfway down
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 400.w, // Setting container width
                            height: 440.h, // Setting container height
                            child: Image.asset(
                              "assets/images/onboarding image 1.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: 20.h,
                            // Positioned with a small gap from the bottom
                            child: ElevatedButton(
                              onPressed: () {
                                if (_currentPage == 2) {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.parentScreen,
                                  );
                                } else {
                                  _controller.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 40.w,
                                ),
                                elevation: 8,
                                shadowColor: Colors.black.withOpacity(0.3),
                                minimumSize: Size(270.w, 56.h),
                              ),
                              child: Text(
                                _currentPage == 2 ? "Sign Up" : "Next",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Screen 3 (same structure)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text above the image
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 60.h),
                            Text(
                              "Your Marketplace for Quick Sales",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "A simple and fast marketplace designed to help you sell items quickly and find the best deals in no time.",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      ),
                      // Image with button positioned halfway down
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 400.w, // Setting container width
                            height: 440.h, // Setting container height
                            child: Image.asset(
                              "assets/images/onboarding image 3.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: 20.h,
                            // Positioned with a small gap from the bottom
                            child: ElevatedButton(
                              onPressed: () {
                                if (_currentPage == 2) {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.parentScreen,
                                  );
                                } else {
                                  _controller.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 40.w,
                                ),
                                elevation: 8,
                                shadowColor: Colors.black.withOpacity(0.3),
                                minimumSize: Size(270.w, 56.h),
                              ),
                              child: Text(
                                _currentPage == 2 ? "Sign up" : "Next",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Smooth Page Indicator at the bottom of the screen
          Padding(
            padding: EdgeInsets.only(bottom: 120.h),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 8.0,
                dotWidth: 8.0,
                spacing: 16.0,
                activeDotColor: Colors.red,
                dotColor: Colors.grey[300]!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
