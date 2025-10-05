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

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                    Center(child: Image.asset('assets/images/logo-1.png')),
                    SizedBox(height: 40.h),
                    _buildTextField(
                      controller: _firstNameController,
                      hintText: 'Your First Name',
                      icon: Icons.person_add,
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      controller: _lastNameController,
                      hintText: 'Your Last Name',
                      icon: Icons.person_add_alt_1,
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Your Email',
                      icon: Icons.email_outlined,
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Your Password',
                      icon: Icons.lock_outline,
                      obscureText: true,
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
                                  first_name: _firstNameController.text
                                      .trim(),
                                  last_name: _lastNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
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
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
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
        prefixIcon: Icon(icon, color: const Color(0xFF777980)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
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
                  Navigator.pop(context);
                },
            ),
          ],
        ),
      ),
    );
  }
}
