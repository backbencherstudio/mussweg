import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/auth/sign_up/widgets/signup_form.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import '../../../../view_model/auth/signup/signup_viewmodel.dart';
import '../../../parent_screen/screen/parent_screen.dart';
import '../widgets/buttons.dart';
import '../widgets/signup_email_text_form_field_widget.dart';
import '../widgets/signup_password_text_form_field_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetIt.instance<SignUpViewModel>(), // This will work now
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80.h),
                _buildLogo(),
                SizedBox(height: 30.h),
                _buildEmailField(),
                SizedBox(height: 10.h),
                _buildPasswordField(context),
                SizedBox(height: 20.h),
                _buildLoginButton(context),
                SizedBox(height: 60.h),
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
                SizedBox(height: 10.h),
                const SignUpFormButton(
                  title: 'Sign In With Facebook',
                  image: 'assets/icons/microsoft-icon.png',
                ),
                SizedBox(height: 30.h),
                _buildSignUpLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(child: Image.asset('assets/images/logo-1.png'));
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6.h),
        const SignUpEmailTextFormFieldWidget(),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        const SignUpPasswordTextFormFieldWidget(),
        SizedBox(height: 6.h),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, viewModel, child) {
        return PrimaryButton(
          title: 'Sign Up',
          color: const Color(0xFFDE3526),
          textColor: Colors.white,
          onTap: () {
            // TODO: Add validation and signup logic here
            // Example:
            // if (viewModel.validateForm()) {
            //   viewModel.signUp();
            // }
            Navigator.pushNamed(context, RouteNames.parentScreen);
          },
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
            style: TextStyle(
              color: const Color(0xFF777980),
              fontSize: 14.sp,
            ),
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
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF4A4C56),
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ParentScreen()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}