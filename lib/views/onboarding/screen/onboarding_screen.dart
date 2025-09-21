import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/onboarding/widgets/onboarding_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/onboarding_page_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: "Sell Fast. Buy Smart",
      description:
          "Easily list your items, explore great deals, and complete trades — all within 48 hours to keep the marketplace fast and fresh.",
      imagePath: "assets/images/onboarding image 1.png",
    ),
    OnboardingPageData(
      title: "Discover Great Deals",
      description:
          "Find items you love at amazing prices from trusted sellers in your community.",
      imagePath: "assets/images/onboarding image 2.png",
    ),
    OnboardingPageData(
      title: "Safe & Secure Trading",
      description:
          "Meet in safe locations and trade with confidence using our verified user system.",
      imagePath: "assets/images/onboarding image 3.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () => setState(() => _currentPage = _controller.page?.round() ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (context, index) => OnboardingWIdget(
                data: _pages[index],
                currentPage: _currentPage,
                totalPages: _pages.length,
                controller: _controller,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 130.h),
            child: SmoothPageIndicator(
              controller: _controller,
              count: _pages.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8.h,
                dotWidth: 8.w,
                spacing: 16.w,
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
