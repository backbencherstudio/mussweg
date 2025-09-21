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
                            color: Colors.white,
                            elevation: 1.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 20.r,
                                    child: Image.asset(
                                      'assets/icons/user_profile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: const Text('Cameron Williamson'),
                                  subtitle: Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/location-04.svg', color: Colors.black,),
                                      Text(' Switzerland'),
                                    ],
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      fixedSize: Size(80.w, 40.h),
                                    ),
                                    child: Text(
                                      'Leave Review',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
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
                                            Container(
                                              height: 25.h,
                                              width: 100.w,
                                              margin: EdgeInsets.only(right: 8.w),
                                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade100,
                                                borderRadius: BorderRadius.circular(16.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Paid',
                                                  style: TextStyle(
                                                    color: Colors.green.shade600,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text('Men Exclusive T-Shirt', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500), ),
                                            Text('Size: XL (New Condition)'),
                                            _buildInfoRow(first: 'Quantity: 3', second: 'Price: \$200'),
                                            SizedBox(height: 4.h,),
                                            _buildInfoRow(first: 'Subtotal:', second: '\$600'),
                                            _buildInfoRow(first: 'Shipping Charge:', second: '\$50'),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      _buildInfoRow(first: 'Total Price:', second: '\$650', isLast: true),
                                      SizedBox(height: 4.h,),
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

  Widget _buildInfoRow({required String first, required String second, bool isLast = false}) {
    return Row(
      children: [
        Text(first, style: TextStyle(fontSize: isLast ? 15.sp : 13.sp),),
        Spacer(),
        Text(second, style: TextStyle(fontSize: isLast ? 15.sp : 13.sp),),
      ],
    );
  }
}
