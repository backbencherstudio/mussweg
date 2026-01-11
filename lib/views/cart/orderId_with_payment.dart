import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/cart/view_model/payment_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_names.dart';
import '../checkout/widgets/checkout_form.dart';

class OrderIdWithPayment extends StatefulWidget {
  const OrderIdWithPayment({super.key});

  @override
  State<OrderIdWithPayment> createState() => _OrderIdWithPaymentState();
}

class _OrderIdWithPaymentState extends State<OrderIdWithPayment> {
  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentScreenProvider>(context);
    final orders = paymentProvider.myOrderModel?.data ?? [];

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
      body:
          orders.isEmpty
              ? const Center(
                child: Text(
                  "No orders found",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          final isSelected =
                              paymentProvider.selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              debugPrint("Order ID======: ${order.orderId}");
                              paymentProvider.selectOrder(
                                order.orderId.toString(),
                                index,
                              );
                            },
                            child: Card(
                              color:
                                  isSelected
                                      ? Colors.blue.shade50
                                      : Colors.white,
                              margin: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order ID: ${order.orderId}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Seller: ${order.seller?.name ?? 'N/A'}",
                                    ),
                                    Text("Total: \$${order.total ?? '0'}"),
                                    Text(
                                      "Status: ${order.status ?? 'Pending'}",
                                    ),
                                    Text(
                                      "Created At: ${order.createdAt ?? ''}",
                                    ),
                                    const Divider(),
                                    ListView.builder(
                                      itemCount: order.items?.length ?? 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, itemIndex) {
                                        final item = order.items![itemIndex];
                                        return ListTile(
                                          title: Text(item.title ?? ''),
                                          subtitle: Text(
                                            "Qty: ${item.quantity ?? 0} | Price: \$${item.price ?? '0'}",
                                          ),
                                          trailing: Text(
                                            "Total: \$${item.totalPrice ?? '0'}",
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Payment Options
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
                                onTap: () {
                                  // TODO: Implement PayPal payment logic
                                },
                              ),
                              SizedBox(height: 6.h),
                              Consumer<PaymentScreenProvider>(
                                builder: (context, provider, child) {
                                  return CheckoutFormButton(
                                    image: 'assets/icons/stripe-icon.png',
                                    outColor: const Color(0xFF635BFF),
                                    onTap: () async {
                                      try {
                                        final clientSecret =
                                            await provider.stripPay();

                                        // Navigate to Stripe Checkout screen with clientSecret
                                        Navigator.pushNamed(
                                          context,
                                          RouteNames.stripeCheckoutScreen,
                                          arguments: clientSecret,
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
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
