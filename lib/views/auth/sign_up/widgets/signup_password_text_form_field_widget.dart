import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:provider/provider.dart';

class SignUpPasswordTextFormFieldWidget extends StatelessWidget {
  const SignUpPasswordTextFormFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, viewModel, child) {
        return TextField(
          obscureText: !viewModel.passwordVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF6F6F7),
            hintText: 'Password',
            hintStyle: TextStyle(fontSize:16,color: Color(0xFF777980)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF777980)),
            suffixIcon: IconButton(
              icon: Icon(
                viewModel.passwordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Color(0xFF777980),
              ),
              onPressed: viewModel.togglePasswordVisibility,
            ),
          ),
        );
      },
    );
  }
}