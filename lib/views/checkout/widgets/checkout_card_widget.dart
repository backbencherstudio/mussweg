import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutCartWidget extends StatelessWidget {
  const CheckoutCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Color(0xFF4A4C56),
              ),
            ),
            SizedBox(height: 16.h),

            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Image.asset(
                      'assets/images/card-image-1.png',
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Man Exclusive T-Shirt',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xFF4A4C56),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Size XL (New Condition)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF777980),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity: 1',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: Color(0xFF4A4C56),
                                ),
                              ),
                              Text(
                                '\$ 20.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: Color(0xFF4A4C56),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(height: 10.h,color: Color(0xFFE9E9EA));
              },
            ),

            SizedBox(height: 10.h),
            Divider(color: Color(0xFFE9E9EA)),

            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xFF4A4C56),
                  ),
                ),
                Text(
                  '\$40.00',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xFF4A4C56),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // Shipping
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping Charge',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xFF4A4C56),
                  ),
                ),
                Text(
                  '\$10.00',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xFF4A4C56),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(color: Color(0xFFE9E9EA)),
            SizedBox(height: 10.h),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Color(0xFF4A4C56),
                  ),
                ),
                Text(
                  '\$50.00',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
