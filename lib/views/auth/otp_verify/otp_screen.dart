import 'package:flutter/material.dart';
import 'package:mussweg/view_model/auth/signup/signup_viewmodel.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../sign_up/widgets/custom_pincode_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {


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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Image.asset("assets/images/logo-1.png"),
              SizedBox(height: 18),
              Text(
                "Enter OTP Code",
                style: TextStyle(
                  color: Color(0xff1D1F2C),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Show the email that was passed
              Text(
                "Verify your email ${context.watch<RegisterProvider>().email}. This helps us keep your account secure by verifying that it's really you.",
                style: TextStyle(
                  color: Color(0xff4A4C56),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              PincodeTextField(controller: _otpController),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Consumer<RegisterProvider>(
                  builder: (context, provider, child) {
                    return Visibility(
                      visible: !provider.isOVLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: PrimaryButton(
                        title: 'Verify',
                        color: const Color(0xFFDE3526),
                        textColor: Colors.white,
                        onTap: () async {
                          final success = await provider.getOtpVerification(_otpController.text);

                          if (mounted){
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(provider.errorMessage),
                                ),
                              );
                              Navigator.pushReplacementNamed(context, RouteNames.loginScreen,);
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
                    );
                  },
                ),
              ),
              SizedBox(height: 32),

              Align(
                alignment: Alignment.center,
                child: Consumer<RegisterProvider>(
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
