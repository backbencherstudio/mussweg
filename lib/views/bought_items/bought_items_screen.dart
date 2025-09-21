import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

import '../widgets/item_cards.dart';

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

  int _selectedIndex = 0; // Track selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleApppbar(title: 'Bought Items'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              Column(
                spacing: 8.h,
                children: List.generate(10, (index) {
                  return ItemCards();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}