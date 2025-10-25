import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimeField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const CustomTimeField({
    super.key,
    required this.title, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              )),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Set Price',
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