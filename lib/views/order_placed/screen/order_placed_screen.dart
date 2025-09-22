import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/widgets/custom_button.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Image.asset('assets/icons/success-icon.png'),
                    SizedBox(height: 10.h),
                    Text(
                      'Your order \n has been placed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A4C56),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      textAlign: TextAlign.center,
                      'Your order would be delivered in \n the 30 mins almost',


                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF4A4C56),
                      ),
                    ),

                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Track Your Order',
                      textColor: Colors.white,
                      buttonColor: Colors.red,
                      onPressed: () {},
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
