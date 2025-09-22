import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/widgets/custom_primary_button.dart';
import 'package:provider/provider.dart';

import '../../view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart'; // Ensure this path is correct

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> isSelectedList = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(
          title: 'Cart',
          onBack: () {
            context.read<ParentScreensProvider>().onSelectedIndex(0);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 4, itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
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
                                color: isSelectedList[index] ? Colors.red : Colors.transparent,
                                width: 1.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 8.w,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 24.w,
                                          width: 24.w,
                                          decoration: BoxDecoration(
                                            color: isSelectedList[index] ? Colors.red : Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Container(
                                          height: 20.w,
                                          width: 20.w,
                                          decoration: BoxDecoration(
                                            color: isSelectedList[index] ? Colors.red : Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Cameron Williamson',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.more_horiz_outlined,
                                      size: 20.w,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.w),
                                  ),
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
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Men Exclusive T-Shirt',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              'Size XL (New Condition)',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            SizedBox(height: 16.h),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '\$200',
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Spacer(),
                                                _incAndDecButton(isIncrement: false),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  '1',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                _incAndDecButton(isIncrement: true),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h,),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 16.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text('\$ 60.76', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),),
                  Spacer(),
                  SizedBox(height: 60.h, width: 160.w, child: CustomPrimaryButton(title: 'Checkout', textStyleSize: 18.sp, onTap: () => Navigator.pushNamed(context, RouteNames.checkoutScreen)))
                ],
              ),
            ),
            SizedBox(height: 100.h,),
          ],
        ),
      ),
    );
  }

  Widget _incAndDecButton({required bool isIncrement}) {
    return Container(
      height: 28.w,
      width: 28.w,
      decoration: BoxDecoration(
        color: isIncrement ? Colors.red.shade100 : Colors.red.shade50,
        shape: BoxShape.circle,
      ),
      child: Icon(isIncrement ? Icons.add : Icons.remove, color: Colors.red),
    );
  }
}
