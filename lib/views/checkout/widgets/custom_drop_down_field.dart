import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownFormField({
    required this.hintText,
    required this.items,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF6F6F7),
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF97989D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(
            country,
            style: TextStyle(color: Color(0xFF97989D)),
          ),
        );
      }).toList(),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Color(0xFF97989D), // Change the icon color if needed
      ),
    );
  }
}
