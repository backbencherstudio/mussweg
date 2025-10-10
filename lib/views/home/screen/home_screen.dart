import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../../../view_model/auth/login/get_me_viewmodel.dart';
import '../../../view_model/home_provider/home_screen_provider.dart';
import '../../widgets/custom_product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<GetMeViewmodel>(context);
    final homScreenProvider = context.watch<HomeScreenProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFDFDFD),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section with user info
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteNames.viewProfileScreen);
                      },
                      child: ClipOval(
                        child: userVM.user?.avatar != null
                            ? Image.network(
                          userVM.user!.avatar!,
                          fit: BoxFit.cover,
                          width: 50.w,
                          height: 50.h,
                        )
                            : Image.asset(
                          'assets/icons/myyyy.jpeg',
                          fit: BoxFit.cover,
                          width: 50.w,
                          height: 50.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${userVM.user?.name ?? 'Guest'}",
                          style: TextStyle(
                            color: const Color(0xffDE3526),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset("assets/icons/location.png"),
                            SizedBox(width: 7.w),
                            Text(
                              "Switzerland",
                              style: TextStyle(
                                color: const Color(0xff777980),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ParentScreensProvider>()
                            .onSelectedIndex(2);
                      },
                      child: Image.asset("assets/icons/cart.png", scale: 1.5),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.notifications_active),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),

                // Search bar
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.searchPage);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F0EE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          "Search Product Name & Suppliers",
                          style: TextStyle(color: Color(0xffA5A5AB)),
                        ),
                        Spacer(),
                        Icon(Icons.search, color: Color(0xffA5A5AB)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.categoryScreen);
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                SizedBox(
                  height: 75.h,
                  child: ListView.builder(
                    itemCount: homScreenProvider.featureList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final feature = homScreenProvider.featureList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffF2F1EF),
                              ),
                              child: SvgPicture.asset(
                                feature["image"],
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              feature["title"],
                              style: TextStyle(
                                color: const Color(0xff4A4C56),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Fashion Products Section
                _buildProductSection("Fashion Products"),

                // Home Accessories Section
                _buildProductSection("Home Accessories"),

                // Electronics Products Section
                _buildProductSection("Electronics Products"),

                SizedBox(height: 90.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build product sections
  Widget _buildProductSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text("View All", style: TextStyle(color: Colors.red)),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 235.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return CustomProductCard();
            },
          ),
        ),
      ],
    );
  }
}
