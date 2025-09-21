import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpEmailTextFormFieldWidget extends StatelessWidget {
  const SignUpEmailTextFormFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF6F6F7),
        hintText: 'Your Email',
        hintStyle: TextStyle(fontSize:16,color: Color(0xFF777980)),
        prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF777980)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r), // Add border radius
          borderSide: BorderSide.none, // Remove border line
        ),
      ),
    );
  }
}
