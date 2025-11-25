import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/selling_items/model_view/selling_item_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import '../widgets/custom_primary_button.dart';
import 'package:mussweg/core/utils/dialogs/review_dialog.dart';

class SellingItemsScreen extends StatefulWidget {
  const SellingItemsScreen({super.key});

  @override
  State<SellingItemsScreen> createState() => _SellingItemsScreenState();
}

class _SellingItemsScreenState extends State<SellingItemsScreen> {
  final List<String> tabs = [
    'All Products',
    'Pending',
    'Delivered',
    'Cancelled',
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SellingItemScreenProvider>(
      context,
      listen: false,
    );

    // Fetch all records on screen load
    provider.allSelProduct();
    provider.pendingSelProduct();
    provider.confirmSelProduct();
    provider.cancelSelProduct();
  }

  List<dynamic> getProducts(SellingItemScreenProvider provider) {
    switch (selectedIndex) {
      case 1:
        return provider.pendingSellProductModel?.data ?? [];
      case 2:
        return provider.confirmSellProductModel?.data ?? [];
      case 3:
        return provider.cancelSellProductModel?.data ?? [];
      default:
        return provider.allSellProductModel?.data ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellingItemScreenProvider>(context);
    final products = getProducts(provider);

    return Scaffold(
      appBar: const SimpleApppbar(title: 'Selling Items'),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            // ========================== TABS ==========================
            SizedBox(
              height: 35.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  final bool isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Colors.red.shade100
                                : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                isSelected
                                    ? Colors.red.shade600
                                    : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            // ======================= PRODUCT LIST ======================
            Expanded(
              child:
                  provider.allSellProductModel == null
                      ? const Center(child: CircularProgressIndicator())
                      : products.isEmpty
                      ? Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final items = product.items ?? [];

                          int totalQty = 0;
                          double totalPrice = 0.0;

                          // Calculate total quantity
                          for (final item in items) {
                            final quantity = _parseToInt(item.quantity);
                            totalQty += quantity;
                          }

                          // Calculate total price
                          for (final item in items) {
                            final quantity = _parseToInt(item.quantity);
                            final price = _parseToDouble(item.price);
                            totalPrice += price * quantity;
                          }

                          final productOwnerId =
                              items.isNotEmpty
                                  ? (items.first.productOwnerId?.toString() ??
                                      "")
                                  : "";

                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Card(
                              elevation: 1,
                              child: ExpansionTile(
                                title: ItemCard(
                                  title: product.orderId?.toString() ?? '',
                                  quantity: totalQty,
                                  price: totalPrice,
                                  status: product.orderStatus?.toString() ?? '',
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Order Details',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        SizedBox(height: 8.h),

                                        // -------- ITEM ROWS --------
                                        ...items.map(
                                          (item) => buildItemRow(
                                            item.productTitle?.toString(),
                                            _parseToDouble(item.price),
                                            _parseToInt(item.quantity),
                                          ),
                                        ),

                                        SizedBox(height: 10.h),

                                        Text(
                                          'Status: ${product.orderStatus?.toString() ?? ''}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                        SizedBox(height: 10.h),

                                        CustomPrimaryButton(
                                          title: 'Leave Review',
                                          onTap: () {
                                            ReviewDialog().showReviewDialog(
                                              context,
                                              productOwnerId,
                                              product.orderId!.toString(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  // =====================================================
  Widget buildItemRow(String? name, double price, int quantity) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name ?? '',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),

          Text('Qty: $quantity'),

          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
class ItemCard extends StatelessWidget {
  final String title;
  final int quantity;
  final double price;
  final String status;

  const ItemCard({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        break;
      case 'delivered':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        break;
      case 'cancelled':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;
      default:
        bgColor = Colors.grey.shade300;
        textColor = Colors.black87;
    }

    return Row(
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Image.asset('assets/images/post_card.png', fit: BoxFit.cover),
        ),

        SizedBox(width: 10.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),

              SizedBox(height: 4.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Qty: $quantity',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
