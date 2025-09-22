import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutFormButton extends StatelessWidget {
  const CheckoutFormButton ({
    super.key,
    this.onTap,
    this.color,
    required this.image,
    required this.outColor,

  });

  final Color outColor;
  final VoidCallback? onTap;
  final Color? color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(16.sp),
          border: Border.all(color: outColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 100.w,
              height: 20.h,
            ),

          ],
        ),
      ),
    );
  }
}
