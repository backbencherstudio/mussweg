import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/auth/sign_up/screen/sign_up_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/services/fm_token_storage.dart';
import '../../../view_model/auth/login/get_me_viewmodel.dart';
import '../../../view_model/auth/login/login_viewmodel.dart';
import '../../../view_model/auth/login/user_profile_get_me_provider.dart';
import '../../../view_model/home_provider/all_category_provider.dart';
import '../sign_up/widgets/buttons.dart';
import '../sign_up/widgets/signup_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              Center(
                child: Image.asset(
                  'assets/images/logo-1.png',
                  height: 75.w,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Sign in to continue',
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
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.forgetPassScreen);
                  },
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
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF6F6F7),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF777980)),
            suffixIcon:
                hasIcon
                    ? GestureDetector(
                      onTap: onTapSuffixIcon,
                      child: Icon(
                        obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    )
                    : null,
            border: OutlineInputBorder(
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
        return viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : PrimaryButton(
              title: 'Login',
              color: const Color(0xFFDE3526),
              textColor: Colors.white,
              onTap: () async {
                FocusScope.of(context).unfocus();

                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all the fields")),
                  );
                  return;
                }
                final fcmToken = await FcmTokenStorage().getFcmToken() ?? "";

                final result = await viewModel.login(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                  fcmToken : fcmToken
                );

                if (!mounted) return;

                if (result) {
                  // Fetch data first
                  await Future.wait([
                    context.read<GetMeViewmodel>().fetchUserData(),
                    context
                        .read<UserProfileGetMeProvider>()
                        .getUserProfileDetails(),
                    context.read<AllCategoryProvider>().getAllCategories(),
                  ]);

                  if (!mounted) return;

                  // Navigate first
                  context.read<ParentScreensProvider>().onSelectedIndex(0);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.parentScreen,
                    (_) => false,
                  );

                  // Then show SnackBar on the NEW screen
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Successful")),
                    );
                  });
                } else {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        viewModel.errorMessage ?? "Invalid credentials",
                      ),
                    ),
                  );
                }
              },
            );
      },
    );
  }

  Widget _buildOrJoinWithDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Color(0xFFE9E9E9), thickness: 1.0),
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
          child: Divider(color: Color(0xFFE9E9E9), thickness: 1.0),
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
              text: "Don't have an account? ",
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF4A4C56)),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              recognizer:
                  TapGestureRecognizer()
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
}
