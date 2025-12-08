import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/widgets/custom_button.dart';

import '../../profile/widgets/simple_apppbar.dart';

class StripeCheckoutScreen extends StatefulWidget {
  const StripeCheckoutScreen({super.key});

  @override
  State<StripeCheckoutScreen> createState() => _StripeCheckoutScreenState();
}

class _StripeCheckoutScreenState extends State<StripeCheckoutScreen> {
  final CardFormEditController _controller = CardFormEditController();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final clientSecret = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: SimpleApppbar(title: 'Stripe Checkout'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Details',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CardFormField(
                controller: _controller,
                style: CardFormStyle(
                  borderRadius: 12,
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                  borderColor: Colors.blueAccent,
                  cursorColor: Colors.blueAccent,
                  textErrorColor: Colors.redAccent,
                  placeholderColor: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            _isProcessing
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: 'Pay Now',
              textColor: Colors.white,
              buttonColor: Colors.redAccent,
              onPressed: () async {
                setState(() => _isProcessing = true);
                try {
                  await Stripe.instance.confirmPayment(
                    paymentIntentClientSecret: clientSecret,
                    data: PaymentMethodParams.card(
                      paymentMethodData: PaymentMethodData(),
                    ),
                  );
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.orderPlacedScreen,
                          (route) => false,
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment failed: $e')),
                  );
                } finally {
                  if (mounted) setState(() => _isProcessing = false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}