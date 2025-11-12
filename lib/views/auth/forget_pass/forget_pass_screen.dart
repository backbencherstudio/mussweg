import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/auth/forget_password/forget_password_provider.dart';
import 'package:mussweg/views/auth/sign_up/screen/sign_up_screen.dart';
import 'package:mussweg/views/auth/sign_up/widgets/signup_form.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../view_model/auth/login/get_me_viewmodel.dart';
import '../../../view_model/auth/login/login_viewmodel.dart';
import '../../../view_model/auth/signup/signup_viewmodel.dart';
import '../../../view_model/home_provider/all_category_provider.dart';
import '../sign_up/widgets/buttons.dart';
import '../sign_up/widgets/signup_email_text_form_field_widget.dart';
import '../sign_up/widgets/signup_password_text_form_field_widget.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginScreenProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              Center(child: Image.asset('assets/images/logo-1.png', height: 75.w, fit: BoxFit.fitHeight,)),
              SizedBox(height: 10.h),
              Text(
                'Forget Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Please enter your email to reset password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
              _buildTextField(
                title: 'Email',
                controller: _emailController,
                hintText: 'Your Email',
              ),
              SizedBox(height: 20.h),
              _buildButton(context),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    bool hasIcon = false,
    VoidCallback? onTapSuffixIcon,
  }) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF6F6F7),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF777980)),
            suffixIcon: hasIcon
                ? GestureDetector(
              onTap: onTapSuffixIcon,
              child: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            )
                : SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Consumer<ForgetPasswordProvider>(
      builder: (context, viewModel, child) {
        return Visibility(
          visible: !viewModel.isFPLoading,
          replacement: const Center(child: CircularProgressIndicator()),
          child: PrimaryButton(
            title: 'Send OTP',
            color: const Color(0xFFDE3526),
            textColor: Colors.white,
            onTap: () async {
              if (_emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please fill all the fields")),
                );
                return;
              }
              final result = await viewModel.forgetPassword(
                email: _emailController.text,
              );
              if (result) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(viewModel.errorMessage ?? "A OTP has been sent to your email"),
                  ),
                );
                viewModel.setEmail(_emailController.text.trim());
                Navigator.pushNamed(context, RouteNames.forgetPassOtpScreen);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      viewModel.errorMessage ?? "Something went wrong",
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget textFormField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF6F6F7),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16, color: Color(0xFF777980)),
        prefixIcon: Icon(icon, color: Color(0xFF777980)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r), // Add border radius
          borderSide: BorderSide.none, // Remove border line
        ),
      ),
    );
  }
}
