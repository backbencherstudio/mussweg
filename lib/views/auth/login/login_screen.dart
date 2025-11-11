import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginScreenProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                title: 'Email',
                controller: _emailController,
                hintText: 'Your Email',
              ),
              SizedBox(height: 10.h),
              _buildTextField(
                title: 'Password',
                controller: _passwordController,
                hintText: 'Your Password',
                obscureText: provider.isObscured,
                hasIcon: true,
                onTapSuffixIcon: provider.toggleObscured,
              ),
              SizedBox(height: 20.h),
              _buildLoginButton(context),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              _buildOrJoinWithDivider(),
              SizedBox(height: 20.h),
              const SignUpFormButton(
                title: 'Sign In With Google',
                image: 'assets/icons/google-icon.png',
              ),
              SizedBox(height: 10.h),
              const SignUpFormButton(
                title: 'Sign In With Apple',
                image: 'assets/icons/apple-icon.png',
              ),
              SizedBox(height: 30.h),
              _buildSignUpLink(context),
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

  Widget _buildLoginButton(BuildContext context) {
    return Consumer<LoginScreenProvider>(
      builder: (context, viewModel, child) {
        return Visibility(
          visible: !viewModel.isLoading,
          replacement: const Center(child: CircularProgressIndicator()),
          child: PrimaryButton(
            title: 'Login',
            color: const Color(0xFFDE3526),
            textColor: Colors.white,
            onTap: () async {
              if (_emailController.text.isEmpty ||
                  _passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please fill all the fields")),
                );
                return;
              }
              final result = await viewModel.login(
                email: _emailController.text,
                password: _passwordController.text,
              );
              if (result) {
                await context.read<GetMeViewmodel>().fetchUserData();
                await context.read<AllCategoryProvider>().getAllCategories();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(viewModel.errorMessage ?? "Login Successful"),
                  ),
                );
                Navigator.pushNamed(context, RouteNames.parentScreen);
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

  Widget _buildOrJoinWithDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFE9E9E9),
            thickness: 1.0,
            indent: 4.0,
            endIndent: 7.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            'Or Join With',
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xFF777980), fontSize: 14.sp),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xFFE9E9E9),
            thickness: 1.0,
            indent: 7.0,
            endIndent: 4.0,
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
              text: 'Sign Up',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
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
