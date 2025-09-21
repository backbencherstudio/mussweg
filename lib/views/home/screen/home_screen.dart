import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_provider/home_screen_provider.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with user info, location, cart, and notifications
              Row(
                children: [
                  ClipRect(child: Image.asset("assets/images/user_1.png")),
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
                  Image.asset("assets/icons/cart.png", scale: 1.5),
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
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF1F0EE),
                  suffixIcon: Icon(Icons.search),
                  hintText: "Search Product Name & Suppliers",
                  hintStyle: TextStyle(color: Color(0xffA5A5AB)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16.h), // Space before categories section
              // Categories title
              Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10.h), // Space after categories title
              // Categories list
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
                            child: Image.asset(
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
              // Fashion Products title
              Text(
                "Fashion Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h), // Space before the grid
              // Fashion products grid with `Expanded` to avoid overflow
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.67,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 10.w,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                // Image widget
                                Image.asset(
                                  "assets/images/shirt.png",
                                  fit: BoxFit.cover,
                                ),
                                // Favorite Icon
                                Positioned(
                                  left: 8,
                                  top: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color(0xffC7C7C7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons
                                          .favorite_border, // Use Icons.favorite for filled
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ), // Added space between the image and text
                          // Text for the product title, size, and price
                          Text(
                            "Max Exclusive T-Shirt",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            "Size XL (New Condition)",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          Text(
                            "\$12.99",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Aug 6 ,13:55",
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: "(12h :12m :30s)",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Text("\$20.00"),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
