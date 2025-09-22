import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/checkout/widgets/checkout_form.dart';
import 'package:provider/provider.dart';


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
  final List<String> _countries = ['USA', 'Canada', 'India', 'Germany', 'Australia'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Cart List',),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            children: [
              CheckoutCartWidget(),
              SizedBox(height: 10.h,),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                )
                              ),
                              child: Row(

                                children: [
                                  Icon(Icons.edit_outlined,color: Colors.white,),
                                  SizedBox(width: 4.w,),
                                  Text('Edit Address',style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )
                          ],
                        ),
                      SizedBox(height: 10.h,),
                      RequiredLabel(
                        labelText: 'Full Name',
                      ),
                      SizedBox(height: 6.h,),
                      CustomTextFormField(hintText: 'Enter Your Name',),
                      SizedBox(height: 10.h,),
                      RequiredLabel(
                        labelText: 'Country',
                      ),
                      SizedBox(height: 6.h,),
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
                      SizedBox(height: 10.h,),
                      RequiredLabel(
                        labelText: 'State',
                      ),
                      SizedBox(height: 6.h,),
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
                      SizedBox(height: 10.h,),
                      RequiredLabel(
                        labelText: 'City',
                      ),
                      SizedBox(height: 6.h,),
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
                      SizedBox(height: 10.h,),
                      RequiredLabel(
                        labelText: 'ZIP Code (Postal Code)',
                      ),
                      SizedBox(height: 6.h,),
                      CustomTextFormField(hintText: 'Enter Zip Code',),
                      SizedBox(height: 10.h,),
                      RequiredLabel(
                        labelText: 'Address',
                      ),
                      SizedBox(height: 6.h,),
                      CustomTextFormField(hintText: 'Enter Your Address',),
                      SizedBox(height: 15.h,),

                      Text(
                        'Payment',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Color(0xFF4A4C56),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      const CheckoutFormButton(image: 'assets/icons/paypal-icon.png', outColor: Color(0xFF0070BA),),
                      SizedBox(height: 6.h,),
                       CheckoutFormButton(

                        image: 'assets/icons/stripe-icon.png', outColor: Color(0xFF635BFF),
                        onTap: (){
                          Navigator.pushNamed(context, RouteNames.stripeCheckoutScreen);
                        },

                      ),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 75.h,)
            ],
          ),
        ),
      ),
    );
  }
  
}

