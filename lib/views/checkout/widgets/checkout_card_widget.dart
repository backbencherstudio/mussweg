import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cart/model/cart_model.dart';

class CheckoutCartWidget extends StatelessWidget {
  final List<Items> selectedItems;

  const CheckoutCartWidget({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    final subtotal = selectedItems.fold<double>(
        0.0, (sum, item) => sum + ((item.price ?? 0) * (item.quantity ?? 0)));

    final shippingCharge = 10.0;
    final total = subtotal + shippingCharge;

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: const Color(0xFF4A4C56)),
            ),
            SizedBox(height: 16.h),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final item = selectedItems[index];
                return Row(
                  children: [
                    Container(
                      height: 80.h,
                      width: 80.w,
                      color: Colors.grey.shade200,
                      child: item.photo != null
                          ? Image.network(item.photo!, fit: BoxFit.cover)
                          : const Icon(Icons.image, size: 40),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productTitle ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: const Color(0xFF4A4C56)),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Size: ${item.size ?? '-'} (${item.condition ?? 'New'})',
                            style: TextStyle(
                                fontSize: 12.sp, color: const Color(0xFF777980)),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Qty: ${item.quantity}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: const Color(0xFF4A4C56)),
                              ),
                              Text(
                                '\$${((item.price ?? 0) * (item.quantity ?? 0)).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: const Color(0xFF4A4C56)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) =>
                  Divider(height: 10.h, color: const Color(0xFFE9E9EA)),
            ),

            SizedBox(height: 10.h),
            Divider(color: const Color(0xFFE9E9EA)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shipping Charge', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('\$${shippingCharge.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(color: const Color(0xFFE9E9EA)),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                Text('\$${total.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
