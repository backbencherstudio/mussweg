import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(title: 'Wishlist', onBack: () => context.read<ParentScreensProvider>().onSelectedIndex(0),),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Favourite List",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4.h,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12.r)
                                    ),
                                    child: Image.asset('assets/images/post_card.png'),
                                  ),
                                ),
                                Positioned(
                                  top: 8.w,
                                  left: 8.w,
                                  child: Container(
                                    height: 36.h,
                                    width: 36.w,
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffC7C8C8)
                                    ),
                                    child: Center(child: Icon(Icons.favorite, color: Colors.red, size: 20.h,)),
                                  ),
                                )
                              ],
                            ),
                            Text('Men Exclusive T-Shirt', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),),
                            Text('Size Xl (New condition)', style: TextStyle(fontSize: 13.sp, color: Colors.grey),),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'Aug 6, 13:55 ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '(12h: 12m :12s)',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.green.shade600,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey.shade200, thickness: .7.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('\$100', style: TextStyle(color: Colors.red, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                                  Image.asset('assets/icons/cart.png', color: Colors.red, height: 24.h, width: 24.h,)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8.h),
                ),
              ),
              SizedBox(height: 75.h,)
            ],
          ),
        ),
      ),
    );
  }
}
