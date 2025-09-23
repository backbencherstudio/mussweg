import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:mussweg/views/checkout/widgets/custom_drop_down_field.dart';
import 'package:mussweg/views/profile/widgets/custom_dropdown_field.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

import '../../../core/routes/route_names.dart';
import '../../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import 'filter_dopdown.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _categoryFilter = [
      {"title": "Filter"},
      {"title": "Latest products"},
      {"title": "Oldest Product"},
    ];
    return Scaffold(
      appBar: SimpleApppbar(title: 'Fashion Products'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category filter row
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryFilter.length,
                  itemBuilder: (context, index) {
                    final data = _categoryFilter[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffF1F0EE),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (data["title"] == "Filter") {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Dialog(
                                      backgroundColor: Colors.white,
                                      insetPadding: EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      child: FilterPage(),
                                    );
                                  },
                                );
                              }
                            },
                            child: Row(
                              children: [
                                data["title"] == "Filter"
                                    ? Image.asset("assets/icons/filter.png")
                                    : const SizedBox(),
                                const SizedBox(width: 10),
                                Text(data["title"]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ), // Space between category filter and product title
              // Section title
              Text(
                "Latest Products",
                style: TextStyle(
                  color: Color(0xff4A4C56),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Space between title and product list
              // Product list
              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.productDetailScreens,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/images/shirt.png",
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xffADA8A5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xffADA8A5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Man Exclusive T-Shirt",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$20.00",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                "Size XL (New Condition)",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Aug 6, 13:55",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " (12h : 12m : 30s)",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.red),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),

                                    onPressed: () {},
                                    child: Text(
                                      "Bid Now",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 13.w),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      side: BorderSide(color: Colors.red),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Buy Now",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}