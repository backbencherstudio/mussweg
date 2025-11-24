import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/view_model/auth/forget_password/forget_password_provider.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../sign_up/widgets/custom_pincode_field.dart';

class ForgetPassOtpScreen extends StatefulWidget {
  const ForgetPassOtpScreen({super.key});

  @override
  State<ForgetPassOtpScreen> createState() => _ForgetPassOtpScreenState();
}

class _ForgetPassOtpScreenState extends State<ForgetPassOtpScreen> {


  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              Center(child: Image.asset('assets/images/logo-1.png', height: 75.w, fit: BoxFit.fitHeight,)),
              SizedBox(height: 10.h),
              Text(
                'Verify Code',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Please enter your OTP code to reset password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
              PincodeTextField(controller: _otpController),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Consumer<ForgetPasswordProvider>(
                  builder: (_, verifyOTPProvider, __) {
                    return Visibility(
                      visible: !verifyOTPProvider.isVOLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: PrimaryButton(
                        title: 'Verify',
                        color: const Color(0xFFDE3526),
                        textColor: Colors.white,
                        onTap: () async {
                          await verifyOTPProvider.setOtpToken(_otpController.text);

                          final res = await verifyOTPProvider.verifyOTP();

                          if (res) {
                            Navigator.pushNamed(context, RouteNames.resetPassScreen);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(verifyOTPProvider.errorMessage),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: 32),

              Align(
                alignment: Alignment.center,
                child: Consumer<ForgetPasswordProvider>(
                  builder: (_, pro, __) {
                    return Visibility(
                      visible: !pro.isRCLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final res = await pro.resendCode();
                          if (res) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(pro.errorMessage),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(pro.errorMessage),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Resend code",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Go back",
                    style: TextStyle(
                      color: Color(0xff1D1F2C),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
