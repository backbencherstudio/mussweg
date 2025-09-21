import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/route_names.dart';

class ProductDetailScreens extends StatelessWidget {
  const ProductDetailScreens({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text("Product Details", style: TextStyle(color: Colors.black)),
        actions: [Icon(Icons.more_horiz, color: Colors.black)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.asset(
                    "assets/images/shirt.png", // Replace with your product image path
                    height: 200,
                    width: MediaQuery.of(context).size.width * 1,
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
                  SizedBox(height: 8),
                  Text(
                    "\$20.00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffFDF3F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Column(
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
                        Column(
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

                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF4FCF8),
                      borderRadius: BorderRadius.circular(50),
                    ),child: Row(
                    children: [
                      SizedBox(width: 16,),
                      Icon(Icons.check_circle_outline,color: Color(0Xff1DBF73),),
                      SizedBox(width: 12.w,),
                      Text("If a scam occurs, their money is protected.",style: TextStyle(
                        color: Color(0xff1DBF73)
                      ),)
                    ],
                  ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "Buy Now",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
