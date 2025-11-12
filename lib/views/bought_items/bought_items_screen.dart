import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mussweg/views/bought_items/viewModel/bought_product/bought_product_provider.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import '../widgets/custom_primary_button.dart';
import 'package:mussweg/core/utils/dialogs/review_dialog.dart';

class BoughtItemsScreen extends StatefulWidget {
  const BoughtItemsScreen({super.key});

  @override
  State<BoughtItemsScreen> createState() => _BoughtItemsScreenState();
}

class _BoughtItemsScreenState extends State<BoughtItemsScreen> {
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
    final provider = Provider.of<BoughtProductProvider>(context, listen: false);

    // Fetch all product statuses
    provider.allBoughtProduct();
    provider.pendingBoughtProduct();
    provider.confirmBoughtProduct();
    provider.cancelBoughtProduct();
  }

  List<dynamic> getProducts(BoughtProductProvider provider) {
    switch (selectedIndex) {
      case 1:
        return provider.pendingBoughtProductModel?.data ?? [];
      case 2:
        return provider.confirmBoughtProductModel?.data ?? [];
      case 3:
        return provider.cancelBoughtProductModel?.data ?? [];
      default:
        return provider.allBoughtProductModel?.data ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BoughtProductProvider>(context);
    final products = getProducts(provider);

    return Scaffold(
      appBar: const SimpleApppbar(title: 'Bought Items'),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            // Tabs
            SizedBox(
              height: 35.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected
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

            // Product list
            Expanded(
              child: provider.allBoughtProductModel == null
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
                        final totalQty = items.fold(
                          0,
                          (sum, item) => sum + (item.quantity ?? 0),
                        );
                        final totalPrice = items.fold(
                          0.0,
                          (sum, item) =>
                              sum + (item.price ?? 0) * (item.quantity ?? 0),
                        );

                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Card(
                            elevation: 1,
                            child: ExpansionTile(
                              title: ItemCard(
                                title: product.orderId ?? '',
                                quantity: totalQty,
                                price: totalPrice,
                                status: product.orderStatus ?? '',
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
                                      ...items.map(
                                        (item) => buildItemRow(
                                          item.productTitle,
                                          item.price ?? 0,
                                          item.quantity ?? 0,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Status: ${product.orderStatus ?? ''}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      CustomPrimaryButton(
                                        title: 'Leave Review',
                                        onTap: () => ReviewDialog()
                                            .showReviewDialog(context),
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

  Widget buildItemRow(String? name, double price, int quantity) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name ?? '',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          Text('Qty: $quantity'),
          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

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
        textColor = Colors.orange.shade600;
        break;
      case 'delivered':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade600;
        break;
      case 'cancelled':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade600;
        break;
      default:
        bgColor = Colors.grey.shade200;
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
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Qty: $quantity',
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
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
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
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
