import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
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
    final provider = context.watch<PaymentScreenProvider>();
    final cartItems = provider.cartModel?.data?.items ?? [];

    if (isSelectedList.length != cartItems.length) {
      isSelectedList = List.generate(cartItems.length, (_) => false);
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
            cartItems.isEmpty
                ? const Expanded(
                  child: Center(child: Text("No Cart Available")),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectedList[index] = !isSelectedList[index];
                            });
                            provider.toggleCartItemSelection(
                              item,
                              isSelectedList[index],
                            );
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
                                    child:
                                        item.photo != null
                                            ? Image.network(
                                              "${ApiEndpoints.baseUrl}/public/storage/product/${item.photo!}",
                                              fit: BoxFit.cover,
                                            )
                                            : const Icon(Icons.image, size: 40),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productTitle ?? "",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        item.size ?? "",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${((item.price ?? 0) * (item.quantity ?? 0)).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Spacer(),
                                          _quantityButton(
                                            false,
                                            item,
                                            provider,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            item.quantity.toString(),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          _quantityButton(true, item, provider),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            cartItems.isEmpty
                ? Align(
                  alignment: Alignment(1, 0),
                  child: Consumer<PaymentScreenProvider>(
                    builder: (context, provider, child) {
                      return CustomPrimaryButton(
                        title: 'My Order',
                        onTap: () async {
                          await provider.getMyOrder();
                          Navigator.pushNamed(
                            context,
                            RouteNames.orderIdWithPayment,
                          );
                        },
                      );
                    },
                  ),
                )
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Text(
                        '\$ ${provider.cartModel?.data?.grandTotal ?? "0.00"}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40.h,
                        width: 120.w,
                        child: CustomPrimaryButton(
                          title: 'Checkout',
                          textStyleSize: 14.sp,
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
            SizedBox(height: 90.h),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(
    bool increment,
    dynamic item,
    PaymentScreenProvider provider,
  ) {
    final currentQty = item.quantity ?? 1;
    return GestureDetector(
      onTap: () {
        if (!increment && currentQty <= 1) return;
        final updatedQty = increment ? currentQty + 1 : currentQty - 1;
        provider.updateCart(item.cartItemId.toString(), updatedQty.toString());
      },
      child: Container(
        height: 28.w,
        width: 28.w,
        decoration: BoxDecoration(
          color: increment ? Colors.red.shade100 : Colors.red.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(
          increment ? Icons.add : Icons.remove,
          color: Colors.red,
          size: 18,
        ),
      ),
    );
  }
}
