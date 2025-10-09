import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';

class ProductDetailsBuyScreens extends StatelessWidget {
  const ProductDetailsBuyScreens({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Product Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.asset(
                    "assets/images/shirt.png", // Replace with your product image path
                    height: 200.h,
                    width: 500.w,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: 160,
                  bottom: 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: Colors.white,
                    ),
                    child: Wrap(
                      children: [
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/user_2.png",
                    ), // Replace with seller profile image
                  ),
                  SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cameron Williamson",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "300 items",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RouteNames.chatScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        "Message seller",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  SizedBox(width: 15.w,),
                  Container(
                    width: 48.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: Color(0xffEEFAF6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(child: Text('Men',style: TextStyle(color: Color(0xff3A9B7A),fontWeight: FontWeight.w700),)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Men Exclusive T-Shirt",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),

                  Row(spacing: 2,
                    children: [
                      Icon(Icons.location_on_outlined,color: Color(0xffA5A5AB),size: 20,),
                      Text(
                        "Switzerland",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xffA5A5AB),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Text(
                    '\$25.00',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 4.h,),
                  Text(
                    "Description Product",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter, and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffFDF3F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Column(spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Condition",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Size",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Materials",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Color",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Uploaded",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Remaining Time",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ": Like New",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ": XL",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ": Cotton Blend",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ": Orange",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ": 6 Aug 2025",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ": 12h : 12m : 30s",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  Center(
                    child: Container(
                      width: 320.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Color(0xffF4FCF8),
                        borderRadius: BorderRadius.circular(50),
                      ),child: Row(
                      children: [
                        SizedBox(width: 12,),
                        Icon(Icons.check_circle_outline,color: Color(0Xff1DBF73),),
                        SizedBox(width: 12.w,),
                        Text("If a scam occurs, their money is protected.",style: TextStyle(
                            color: Color(0xff1DBF73)
                        ),)
                      ],
                    ),
                    ),
                  ),
                  SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ParentScreensProvider>().onSelectedIndex(2);
                            Navigator.pushNamed(context, RouteNames.parentScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            "Place a Bid",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),

                  SizedBox(height: 70.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
