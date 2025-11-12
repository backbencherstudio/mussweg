import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../view_model/auth/signup/signup_viewmodel.dart';
import '../widgets/buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Center(child: Image.asset('assets/images/logo-1.png', height: 75.w, fit: BoxFit.fitHeight,)),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Sign up to buy and sell',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildTextField(
                      title: 'First Name',
                      controller: _firstNameController,
                      hintText: 'Your First Name',
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      title: 'Last Name',
                      controller: _lastNameController,
                      hintText: 'Your Last Name',
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      title: 'Location',
                      controller: _locationController,
                      hintText: 'Your Location',
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      title: 'Email',
                      controller: _emailController,
                      hintText: 'Your Email',
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      title: 'Password',
                      controller: _passwordController,
                      hintText: 'Your Password',
                      obscureText: provider.isPassObscured,
                      hasIcon: true,
                      onTapSuffixIcon: provider.togglePassObscured
                    ),
                    SizedBox(height: 60.h),
                    provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            title: 'Sign Up',
                            color: const Color(0xFFDE3526),
                            textColor: Colors.white,
                            onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final success = await provider.registerUser(
                                    first_name: _firstNameController.text.trim(),
                                    last_name: _lastNameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    location: _locationController.text.trim()
                                  );

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(provider.errorMessage),
                                      ),
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.otpScreen,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(provider.errorMessage),
                                      ),
                                    );
                                  }
                                }
                            },
                          ),

                    SizedBox(height: 40.h),
                    _buildSignUpLink(context),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          );
        },
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
            color: Colors.black54,
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

  Widget _buildSignUpLink(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Already have an account? ",
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF4A4C56)),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(
                    context,
                    RouteNames.loginScreen,
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
