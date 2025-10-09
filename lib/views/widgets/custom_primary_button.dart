import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key, required this.title, required this.onTap, this.textStyleSize,
  });

  final String title;
  final VoidCallback onTap;
  final double? textStyleSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        fixedSize: Size(90.w, 25.h),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: textStyleSize ?? 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}