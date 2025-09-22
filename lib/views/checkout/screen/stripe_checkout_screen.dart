import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/widgets/custom_button.dart';
import 'package:mussweg/views/widgets/custom_primary_button.dart';


import '../../profile/widgets/simple_apppbar.dart';
import '../widgets/stripe_checkout_label_text.dart';
import '../widgets/text_form_field.dart';

class StripeCheckoutScreen extends StatefulWidget {
  const StripeCheckoutScreen({super.key});

  @override
  State<StripeCheckoutScreen> createState() => _StripeCheckoutScreenState();
}

class _StripeCheckoutScreenState extends State<StripeCheckoutScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Stripe Checkout'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h,),
                      StripeCheckoutLabelText(
                        labelText: 'Card Number',
                      ),
                      SizedBox(height: 6.h,),
                      CustomTextFormField(hintText: '1234 5423 3456 9834',),
                      SizedBox(height: 10.h,),
                      StripeCheckoutLabelText(
                        labelText: 'Expiration Date',
                      ),
                      SizedBox(height: 6.h,),
                      CustomTextFormField(hintText: 'MM/YY',),
                      SizedBox(height: 10.h,),
                      StripeCheckoutLabelText(
                        labelText: 'CVC',
                      ),
                      SizedBox(height: 6.h,),
                      CustomTextFormField(hintText: 'CVC',),
                      SizedBox(height: 10.h,),
                      CustomButton(text: 'Pay Now : \$60.00', textColor: Colors.white, buttonColor: Colors.red, onPressed: (){}),
                      SizedBox(height: 6.h,),
                    ],
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

