import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData? icon; // 👈 optional now
  final TextEditingController controller;
  final bool? readOnly;
  final int? maxLine;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.icon,
    required this.controller, this.readOnly, this.maxLine, // 👈 no longer required
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          SizedBox(height: 8.h),
          TextField(
            readOnly: readOnly ?? false,
            controller: controller,
            maxLines: maxLine ?? 1,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: icon != null ? Icon(icon) : null,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
