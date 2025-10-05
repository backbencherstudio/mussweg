import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../../../view_model/home_provider/home_screen_provider.dart';
import '../../widgets/custom_product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homScreenProvider = context.watch<HomeScreenProvider>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Padding(
          padding: EdgeInsets.all(16.0), // General padding for the whole screen
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section with user info, location, cart, and notifications
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/icons/myyyy.jpeg',
                        fit: BoxFit.cover,
                        width: 50.w,
                        height: 50.h,
                      ),
                    ),
                    SizedBox(width: 12.w), // Adjusted spacing
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, Treesna",
                          style: TextStyle(
                            color: Color(0xffDE3526),
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
                                color: Color(0xff777980),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<ParentScreensProvider>().onSelectedIndex(
                          2,
                        );
                      },
                      child: Image.asset("assets/icons/cart.png", scale: 1.5),
                    ),
                    SizedBox(width: 12.w), // Adjusted spacing
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.notifications_active),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ), // Space between top section and search bar
                // Search bar section
                GestureDetector(
                  onTap: (){Navigator.pushNamed(context, RouteNames.searchPage);},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
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

                SizedBox(height: 16.h),

                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                      child: Text(
                        "View All",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h), // Space before the grid
                SizedBox(
                  height: 80.h,
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
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffF2F1EF),
                              ),
                              child: SvgPicture.asset(
                                feature["image"],
                                height: 30.h,
                                width: 30.w, // Ensure images are responsive
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ), // Added space between image and title
                            Text(
                              feature["title"],
                              style: TextStyle(
                                color: Color(0xff4A4C56),
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
                SizedBox(height: 16.h), // Space before Fashion Products section

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fashion Products",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("View All", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(height: 10.h), // Space before the grid
                // Fashion products grid with `Expanded` to avoid overflow
                SizedBox(
                  height: 320.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return CustomProductCard();
                    },
                  ),
                ),
                SizedBox(height: 16.h), // Space before Fashion Products section

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Home Accessories",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("View All", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(height: 10.h), // Space before the grid
                // Fashion products grid with `Expanded` to avoid overflow
                SizedBox(
                  height: 320.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return CustomProductCard();
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Electronics Products",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("View All", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(height: 10.h), // Space before the grid
                // Fashion products grid with `Expanded` to avoid overflow
                SizedBox(
                  height: 320.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return CustomProductCard();
                    },
                  ),
                ),
                SizedBox(height: 75.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
