import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  int _selectedIndex = 0; // Track selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleApppbar(title: 'Selling Items'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
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

              // List of ExpansionTiles
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Card(
                      color: Colors.white,
                      elevation: 1.w,
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        showTrailingIcon: false,
                        title: ItemCards(),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        children: [
                          Card(
                            color: Colors.grey.shade50,
                            elevation: 1.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Order Summary', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),),
                                      SizedBox(height: 4.h,),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                                        child: Column(
                                          spacing: 4.h,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildInfoRow(first: 'Client Name', second: 'ABC'),
                                            _buildInfoRow(first: 'Email:', second: 'abc@gmail.com'),
                                            _buildInfoRow(first: 'Address:', second: 'St.Gallen& Eastern Switzerland'),
                                            _buildInfoRow(first: 'Product:', second: 'Man Exclusive T-Shirt'),
                                            _buildInfoRow(first: 'Quantity:', second: '3'),
                                            _buildInfoRow(first: 'Amount:', second: '\$650'),
                                            _buildInfoRow(first: 'Amount Paid:', second: '\$650'),
                                            _buildInfoRow(first: 'Status:', second: 'Paid'),
                                          ],
                                        ),
                                      ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String first, required String second}) {
    return Row(
      children: [
        Text(first, style: TextStyle(fontSize: 14.sp, color: Colors.black54, fontWeight:FontWeight.w600),),
        Spacer(),
        SizedBox(width: 180.w, child: Text(second, textAlign: TextAlign.end, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight:FontWeight.w400),)),
      ],
    );
  }
}
