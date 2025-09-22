import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/checkout/widgets/checkout_form.dart';
import '../../profile/widgets/simple_apppbar.dart';
import '../widgets/checkout_card_widget.dart';
import '../widgets/custom_drop_down_field.dart';
import '../widgets/label_text.dart';
import '../widgets/text_form_field.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  final List<String> _countries = [
    'USA',
    'Canada',
    'India',
    'Germany',
    'Australia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Cart List'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
            child: Column(
              children: [
                // Cart Summary Widget
                CheckoutCartWidget(),
                SizedBox(height: 10.h),

                // Shipping Address Card
                Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Edit Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Address',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Color(0xFF4A4C56),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Edit Address',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),

                        // Full Name Field
                        RequiredLabel(labelText: 'Full Name'),
                        SizedBox(height: 6.h),
                        CustomTextFormField(hintText: 'Enter Your Name'),
                        SizedBox(height: 15.h),

                        // Country Field
                        RequiredLabel(labelText: 'Country'),
                        SizedBox(height: 6.h),
                        CustomDropdownFormField(
                          hintText: 'Select your country',
                          items: _countries,
                          selectedValue: _selectedCountry,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCountry = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 15.h),

                        // State Field
                        RequiredLabel(labelText: 'State'),
                        SizedBox(height: 6.h),
                        CustomDropdownFormField(
                          hintText: 'Select your state',
                          items: _countries,
                          // You should have separate state list
                          selectedValue: _selectedState,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedState = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 15.h),

                        // City Field
                        RequiredLabel(labelText: 'City'),
                        SizedBox(height: 6.h),
                        CustomDropdownFormField(
                          hintText: 'Select your city',
                          items: _countries,
                          // You should have separate city list
                          selectedValue: _selectedCity,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCity = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 15.h),

                        // ZIP Code Field
                        RequiredLabel(labelText: 'ZIP Code (Postal Code)'),
                        SizedBox(height: 6.h),
                        CustomTextFormField(hintText: 'Enter Zip Code'),
                        SizedBox(height: 15.h),

                        // Address Field
                        RequiredLabel(labelText: 'Address'),
                        SizedBox(height: 6.h),
                        CustomTextFormField(hintText: 'Enter Your Address'),
                        SizedBox(height: 20.h),

                        // Payment Section
                        Text(
                          'Payment',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Color(0xFF4A4C56),
                          ),
                        ),
                        SizedBox(height: 15.h),

                        // PayPal Option
                        CheckoutFormButton(
                          image: 'assets/icons/paypal-icon.png',
                          outColor: Color(0xFF0070BA),
                        ),
                        SizedBox(height: 10.h),

                        // Stripe Option
                        CheckoutFormButton(
                          image: 'assets/icons/stripe-icon.png',
                          outColor: Color(0xFF635BFF),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.stripeCheckoutScreen,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Add bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
