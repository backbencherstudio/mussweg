import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField extends StatelessWidget {
  final String title;
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final safeValue = (value != null && items.contains(value)) ? value : null;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: safeValue,
                hint: Text(
                  hintText,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
                items: items
                    .toSet()
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
