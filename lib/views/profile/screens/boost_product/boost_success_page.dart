import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';

class BoostSuccessPage extends StatelessWidget {
  const BoostSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Boost Successfully',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 80.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(24.0.sp),
              child: SizedBox(
                width: double.infinity.w,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.grey.shade100)),
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(32.0.sp),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 100.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              Image.asset(
                                'assets/icons/success_boost.png',
                                scale: 2.8.w,
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'Your Product has been\nboost now.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4A4C56),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Your product would be boost in the\n3 days almost',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xff4A4C56),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          ElevatedButton(
                            onPressed: () {
                           Navigator.pushNamed(context, RouteNames.sellerProfilePage);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffDE3526),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.w, vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Back to profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}