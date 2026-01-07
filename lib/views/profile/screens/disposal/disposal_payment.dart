import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/route_names.dart';
import '../../../auth/disposal/get_disposal_items_provider.dart';
import '../../../checkout/widgets/checkout_form.dart';

class DisposalPayment extends StatefulWidget {
  const DisposalPayment({super.key});

  @override
  State<DisposalPayment> createState() => _DisposalPaymentState();
}

class _DisposalPaymentState extends State<DisposalPayment> {
  @override
  Widget build(BuildContext context) {
    // Extract arguments directly in build method
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    final productId = routeArgs?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "My Order List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      CheckoutFormButton(
                        image: 'assets/icons/paypal-icon.png',
                        outColor: const Color(0xFF0070BA),
                        onTap: () {},
                      ),
                      SizedBox(height: 6.h),
                      Consumer<GetDisposalItemsProvider>(
                        builder: (context, provider, child) {
                          return CheckoutFormButton(
                            image: 'assets/icons/stripe-icon.png',
                            outColor: const Color(0xFF635BFF),
                            onTap: () async {
                              if (productId.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Product ID is missing'),
                                  ),
                                );
                                return;
                              }

                              try {
                                final clientSecret = await provider
                                    .stripPayForBoost(productId);

                                Navigator.pushNamed(
                                  context,
                                  RouteNames.stripeCheckoutScreen,
                                  arguments: clientSecret,
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Payment initialization failed: $e',
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
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
