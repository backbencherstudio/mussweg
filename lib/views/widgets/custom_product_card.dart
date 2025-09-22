import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          spacing: 4.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
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
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Aug 6 ,13:55",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "(12h :12m :30s)",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.h, color: Colors.black,),
            Text("\$20.00", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.red),),
          ],
        ),
      ),
    );
  }
}