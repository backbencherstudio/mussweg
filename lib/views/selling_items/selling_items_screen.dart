import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

import '../widgets/item_cards.dart';

class SellingItemsScreen extends StatefulWidget {
  const SellingItemsScreen({super.key});

  @override
  State<SellingItemsScreen> createState() => _SellingItemsScreenState();
}

class _SellingItemsScreenState extends State<SellingItemsScreen> {
  final List<String> _tabs = [
    'All Products',
    'Pending',
    'Delivered',
    'Cancelled',
  ];

  int _selectedIndex = 0;

  // Dummy selling products data
  final List<Map<String, dynamic>> allProducts = [
    {
      'title': 'Man Exclusive T-Shirt',
      'status': 'Pending',
      'quantity': 1,
      'price': 200.0
    },
    {
      'title': 'Cotton Hoodie',
      'status': 'Delivered',
      'quantity': 2,
      'price': 150.0
    },
    {
      'title': 'Formal Shirt',
      'status': 'Cancelled',
      'quantity': 1,
      'price': 120.0
    },
    {
      'title': 'Casual Polo',
      'status': 'Pending',
      'quantity': 3,
      'price': 100.0
    },
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
      appBar: const SimpleApppbar(title: 'Selling Items'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Tabs
            SizedBox(
              height: 30.h,
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
                          _tabs[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.red.shade600
                                : Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),

            // Products list
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                child: Text(
                  "No products found",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final double price =
                  (product['price'] as num).toDouble();
                  final int quantity = product['quantity'] as int;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Card(
                      color: Colors.white,
                      elevation: 1.w,
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        showTrailingIcon: false,
                        title: ItemCards(
                          title: product['title'],
                          quantity: quantity,
                          price: price,
                          status: product['status'], // dynamic status
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        children: [
                          Card(
                            color: Colors.grey.shade50,
                            elevation: 1.w,
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Summary',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        _buildInfoRow(
                                          first: 'Client Name',
                                          second: 'ABC',
                                        ),
                                        _buildInfoRow(
                                          first: 'Email:',
                                          second: 'abc@gmail.com',
                                        ),
                                        _buildInfoRow(
                                          first: 'Address:',
                                          second:
                                          'St.Gallen & Eastern Switzerland',
                                        ),
                                        _buildInfoRow(
                                          first: 'Product:',
                                          second: product['title'],
                                        ),
                                        _buildInfoRow(
                                          first: 'Quantity:',
                                          second: '$quantity',
                                        ),
                                        _buildInfoRow(
                                          first: 'Amount:',
                                          second: '\$${price * quantity}',
                                        ),
                                        _buildInfoRow(
                                          first: 'Amount Paid:',
                                          second: '\$${price * quantity}',
                                        ),
                                        _buildInfoRow(
                                          first: 'Status:',
                                          second: product['status'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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

  Widget _buildInfoRow(
      {required String first, required String second}) {
    return Row(
      children: [
        Text(
          first,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        SizedBox(
          width: 180.w,
          child: Text(
            second,
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
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
    Color statusColor;
    if (status == 'Pending') {
      statusColor = Colors.orange.shade100;
    } else if (status == 'Delivered') {
      statusColor = Colors.green.shade100;
    } else {
      statusColor = Colors.red.shade100;
    }

    Color statusTextColor;
    if (status == 'Pending') {
      statusTextColor = Colors.orange.shade600;
    } else if (status == 'Delivered') {
      statusTextColor = Colors.green.shade600;
    } else {
      statusTextColor = Colors.red.shade600;
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              height: 80.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Image.asset(
                'assets/images/post_card.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 140.w,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 50.w,
                      child: Text(
                        'Qty: $quantity',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 25.h,
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusTextColor,
                            fontSize: 13.sp,
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
