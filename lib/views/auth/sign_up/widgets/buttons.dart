import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;
  final Color? textColor;
  final String? icon;
  final double? height;
  final double? textSize;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.color,
    this.textColor,
    this.height,
    this.textSize,
    this.icon,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: height ?? 56.h,
          decoration: BoxDecoration(
            // color: Color(0xffE9201D),
            color: color,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: textSize ?? 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
      ),
    );
  }
}
