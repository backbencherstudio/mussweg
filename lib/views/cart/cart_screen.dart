import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/cart/view_model/payment_screen_provider.dart';
import 'package:mussweg/views/widgets/custom_primary_button.dart';
import 'package:provider/provider.dart';
import '../../view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> isSelectedList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PaymentScreenProvider>().getMyCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentScreenProvider>(context);
    final cart = paymentProvider.cartModel?.data?.items ?? [];

    if (isSelectedList.length != cart.length) {
      isSelectedList = List.generate(cart.length, (index) => false);
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(
          title: 'Cart',
          onBack:
              () => context.read<ParentScreensProvider>().onSelectedIndex(0),
        ),
        body: Column(
          children: [
            cart.isEmpty
                ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final cartData = cart[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectedList[index] = !isSelectedList[index];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color:
                                    isSelectedList[index]
                                        ? Colors.red
                                        : Colors.transparent,
                                width: 1.w,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Container(
                                      height: 80.h,
                                      width: 100.w,
                                      color: Colors.grey.shade200,
                                      child: Image.asset(
                                        'assets/images/post_card.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartData.productTitle ?? "",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          cartData.size ?? "",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${((cartData.price ?? 0) * (cartData.quantity ?? 0)).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),

                                            const Spacer(),
                                            _quantityButton(
                                              false,
                                              cartData,
                                              paymentProvider,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              cartData.quantity.toString(),
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            _quantityButton(
                                              true,
                                              cartData,
                                              paymentProvider,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    '\$ ${paymentProvider.cartModel?.data?.grandTotal ?? "0.00"}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 60.h,
                    width: 160.w,
                    child: CustomPrimaryButton(
                      title: 'Checkout',
                      textStyleSize: 18.sp,
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            RouteNames.checkoutScreen,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(
    bool isIncrement,
    dynamic cartData,
    PaymentScreenProvider provider,
  ) {
    return GestureDetector(
      onTap: () {
        int qty = cartData.quantity ?? 1;

        if (!isIncrement && qty <= 1) return;

        int newQty = isIncrement ? qty + 1 : qty - 1;

        provider.updateCart(cartData.cartItemId.toString(), newQty.toString());
      },
      child: Container(
        height: 28.w,
        width: 28.w,
        decoration: BoxDecoration(
          color: isIncrement ? Colors.red.shade100 : Colors.red.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          color: Colors.red,
          size: 18,
        ),
      ),
    );
  }
}
