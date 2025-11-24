import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/view_model/auth/forget_password/forget_password_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/route_names.dart';
import '../sign_up/widgets/buttons.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ForgetPasswordProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text(
                      'Set a new Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Create a new password. Ensure it differs from previous ones for security',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Password field
                    _buildTextField(
                      title: 'Password',
                      controller: _passwordController,
                      hintText: 'Your Password',
                      obscureText: provider.isPassObscured,
                      hasIcon: true,
                      onTapSuffixIcon: provider.togglePassObscured,
                    ),
                    SizedBox(height: 10.h),

                    // Confirm Password
                    _buildTextField(
                      title: 'Confirm Password',
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: provider.isConfirmPassObscured,
                      hasIcon: true,
                      onTapSuffixIcon: provider.toggleConfirmPassObscured,
                    ),
                    SizedBox(height: 60.h),

                    provider.isRPLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                      title: 'Reset Password',
                      color: const Color(0xFFDE3526),
                      textColor: Colors.white,
                      onTap: () async {
                        FocusScope.of(context).unfocus();

                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match!'),
                            ),
                          );
                          return;
                        }

                        if (!_formKey.currentState!.validate()) return;

                        final success = await provider.resetPassword(
                          password: _passwordController.text.trim(),
                        );

                        if (!mounted) return;

                        final message = provider.errorMessage.isNotEmpty
                            ? provider.errorMessage
                            : (success
                            ? 'Password updated successfully'
                            : 'Password update failed');

                        if (!mounted) return;
                        final snack = ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));

                        snack.closed.then((_) async {
                          if (mounted && success) {
                            await Future.delayed(
                                const Duration(milliseconds: 50));
                            if (!mounted) return;
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.loginScreen,
                                  (_) => false,
                            );
                          }
                        });
                      },
                    ),
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
          validator: (value) =>
          value == null || value.isEmpty ? 'This field cannot be empty' : null,
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
}
