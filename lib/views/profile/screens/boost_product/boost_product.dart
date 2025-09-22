import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/profile/widgets/custom_dropdown_field.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import '../../widgets/custom_text_field.dart';

class BoostProductPage extends StatefulWidget {
  BoostProductPage({super.key});

  @override
  State<BoostProductPage> createState() => _BoostProductPageState();
}

class _BoostProductPageState extends State<BoostProductPage> {
  final List<String> _conditions = [
    "New",
    "Used",
    "Refurbished",
  ];
  String? _selectedCondition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Boost Product'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Product Info',
                style: TextStyle(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity.w,
                          height: 150.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.r),
                            ),
                            child: Image.asset(
                              'assets/images/dress.png',
                              height: 80.h,
                              width: double.infinity.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Man Exclusive T-Shirt',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Color(0xff4A4C56),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Text(
                              'Size XL',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff777980),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '(New Condition)',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff777980),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Text(
                              'Aug 6 ,13:55',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff777980),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '(12h :12m :30s)',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1A9882),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Divider(color: Color(0xffE9E9EA)),
                        Row(
                          children: [
                            Text(
                              '💲',
                              style: TextStyle(
                                color: Color(0xffDE3526),
                                fontSize: 16.sp,
                              ),
                            ), Text(
                              '100.00',
                              style: TextStyle(
                                color: Color(0xffDE3526),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 25.w),
                          ],
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(
                  color: Color(0xffE9E9EA),
                  width: 1.5.w,
                ),
              ),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  children: [
                    CustomTextField(
                      title: 'Boosting Duration',
                      hintText: '3 Days',
                      icon: Icons.access_time,
                    ),
                    CustomDropdownField(
                      title: 'Boosting Type',
                      hintText: 'Standard (+\$10)',
                      items: _conditions,
                      value: _selectedCondition,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[350],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text('Cancel', style: TextStyle(fontSize: 18.sp)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteNames.boostSuccessPage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text('Boost',
                        style:
                        TextStyle(color: Colors.white, fontSize: 18.sp)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
