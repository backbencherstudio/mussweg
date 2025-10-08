import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mussweg/core/utils/dialogs/review_dialog.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

import '../widgets/custom_primary_button.dart';

class BoughtItemsScreen extends StatefulWidget {
  const BoughtItemsScreen({super.key});

  @override
  State<BoughtItemsScreen> createState() => _BoughtItemsScreenState();
}

class _BoughtItemsScreenState extends State<BoughtItemsScreen> {
  final List<String> _tabs = [
    'All Products',
    'Pending',
    'Delivered',
    'Cancelled',
  ];

  int _selectedIndex = 0;

  // Dummy product data
  final List<Map<String, dynamic>> allProducts = [
    {'title': 'Man Exclusive T-Shirt', 'status': 'Pending', 'quantity': 1, 'price': 200.0},
    {'title': 'Cotton Hoodie', 'status': 'Pending', 'quantity': 2, 'price': 150.0},
    {'title': 'Formal Shirt', 'status': 'Delivered', 'quantity': 1, 'price': 120.0},
    {'title': 'Casual Polo', 'status': 'Delivered', 'quantity': 3, 'price': 100.0},
    {'title': 'Denim Jacket', 'status': 'Cancelled', 'quantity': 1, 'price': 180.0},
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (_selectedIndex == 0) return allProducts;
    if (_selectedIndex == 1) {
      return allProducts.where((e) => e['status'] == 'Pending').toList();
    } else if (_selectedIndex == 2) {
      return allProducts.where((e) => e['status'] == 'Delivered').toList();
    } else {
      return allProducts.where((e) => e['status'] == 'Cancelled').toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleApppbar(title: 'Bought Items'),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            /// Tabs
            SizedBox(
              height: 30.0.h,
              child: ListView.builder(
                itemCount: _tabs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8.0.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16.0.r),
                      ),
                      child: Center(
                        child: Text(
                          _tabs[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.red.shade600
                                : Colors.black,
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0.h),

            /// Filtered Product List
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                child: Text(
                  "No products found",
                  style: TextStyle(
                    fontSize: 15.0.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final double price = (product['price'] as num).toDouble();
                  final int quantity = product['quantity'] as int;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.0.h),
                    child: Card(
                      color: Colors.white,
                      elevation: 1.0.w,
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        showTrailingIcon: false,
                        title: ItemCards(
                          title: product['title'],
                          quantity: quantity,
                          price: price,
                          status: product['status'],
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 1.0.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 20.0.r,
                                    child: Image.asset(
                                      'assets/icons/user_profile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: const Text('Cameron Williamson'),
                                  subtitle: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/location-04.svg',
                                        color: Colors.black,
                                      ),
                                      const Text(' Switzerland'),
                                    ],
                                  ),
                                  trailing: CustomPrimaryButton(
                                    onTap: () {
                                      ReviewDialog().showReviewDialog(context);
                                    },
                                    title: 'Leave Review',
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order Summary',
                                        style: TextStyle(
                                            fontSize: 18.0.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 4.0.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 25.0.h,
                                              width: 100.0.w,
                                              margin: EdgeInsets.only(right: 8.0.w),
                                              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                              decoration: BoxDecoration(
                                                color: product['status'] == 'Pending'
                                                    ? Colors.orange.shade100
                                                    : product['status'] == 'Delivered'
                                                    ? Colors.green.shade100
                                                    : Colors.red.shade100,
                                                borderRadius: BorderRadius.circular(16.0.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  product['status'],
                                                  style: TextStyle(
                                                    color: product['status'] == 'Pending'
                                                        ? Colors.orange.shade600
                                                        : product['status'] == 'Delivered'
                                                        ? Colors.green.shade600
                                                        : Colors.red.shade600,
                                                    fontSize: 13.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(product['title'],
                                                style: TextStyle(
                                                    fontSize: 14.0.sp,
                                                    fontWeight: FontWeight.w500)),
                                            Text('Size: XL (New Condition)'),
                                            _buildInfoRow(
                                                first: 'Quantity: $quantity',
                                                second: 'Price: \$$price'),
                                            SizedBox(height: 4.0.h),
                                            _buildInfoRow(
                                                first: 'Subtotal:',
                                                second: '\$${quantity * price}'),
                                            _buildInfoRow(
                                                first: 'Shipping Charge:',
                                                second: '\$50'),
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                      _buildInfoRow(
                                          first: 'Total Price:',
                                          second: '\$${quantity * price + 50}',
                                          isLast: true),
                                      SizedBox(height: 4.0.h),
                                    ],
                                  ),
                                )
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

  Widget _buildInfoRow({required String first, required String second, bool isLast = false}) {
    return Row(
      children: [
        Text(
          first,
          style: TextStyle(
            fontSize: isLast ? 15.0.sp : 13.0.sp,
            color: Colors.black,
            fontWeight: isLast ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          second,
          style: TextStyle(
            fontSize: isLast ? 15.0.sp : 13.0.sp,
            color: isLast ? Colors.red : Colors.black,
            fontWeight: isLast ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ItemCards extends StatelessWidget {
  final String title;
  final int quantity;
  final double price;
  final String status;

  const ItemCards({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Set background and text color based on status
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Pending':
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade600;
        break;
      case 'Delivered':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade600;
        break;
      case 'Cancelled':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade600;
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.black;
    }

    return Card(
      color: Colors.white,
      elevation: 0.0,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0.r),
            child: Container(
              height: 80.0.h,
              width: 100.0.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              child: Image.asset(
                'assets/images/post_card.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 8.0.w),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 140.0.w,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 50.0.w,
                      child: Text(
                        'Qty: $quantity',
                        style: TextStyle(
                          fontSize: 13.0.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 25.0.h,
                      margin: EdgeInsets.only(right: 8.0.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16.0.r),
                      ),
                      child: Center(
                        child: Text(
                          status, // Will display Pending / Delivered / Cancelled
                          style: TextStyle(
                            color: textColor,
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
