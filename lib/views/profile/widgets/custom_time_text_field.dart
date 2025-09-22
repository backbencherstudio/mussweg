import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimeField extends StatelessWidget {
  final String title;

  const CustomTimeField({
    super.key,
    required this.title,
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
            decoration: InputDecoration(
              hintText: 'Set time',
              suffixIcon: Icon(Icons.access_time, size: 20.w),
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