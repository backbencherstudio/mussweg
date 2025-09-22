import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback onPressed;
  final IconData? suffixIcon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    required this.onPressed,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (suffixIcon != null) ...[
              SizedBox(width: 8.w),
              Icon(
                suffixIcon,
                color: textColor,
                size: 20.sp,
              ),
            ]
          ],
        ),
      ),
    );
  }
}