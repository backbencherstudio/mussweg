import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import '../../../widgets/simple_apppbar.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_time_text_field.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});
  final List<String> _conditions = const ["New", "Used", "Refurbished"];

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<SellItemService>();
    return Scaffold(
      appBar: const SimpleApppbar(title: 'Edit Product'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 160.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      'assets/images/dress.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          icon: Icon(Icons.add_a_photo, color: Colors.white, size: 20.w),
                          label: Text(
                            'Upload photos',
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 1.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Add up to 20 photos.',
                          style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        'assets/images/dress.png',
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: const Color(0xffE9E9EA), width: 1.5.w),
              ),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  children: [
                    CustomTextField(
                      title: 'Title',
                      hintText: 'e.g. Blue Pottery Vase',
                    ),
                    CustomTextField(
                      title: 'Descriptions',
                      hintText: 'e.g. Blue Pottery Vase',
                    ),
                    AnimatedBuilder(
                      animation: service,
                      builder: (context, _) => Column(
                        children: [
                          CustomDropdownField(
                            title: 'Location',
                            hintText: 'Select location',
                            items: _conditions,
                            value: service.location,
                            onChanged: service.setLocation,
                          ),
                          CustomDropdownField(
                            title: 'Category',
                            hintText: 'Select category',
                            items: _conditions,
                            value: service.category,
                            onChanged: service.setCategory,
                          ),
                          CustomDropdownField(
                            title: 'Size',
                            hintText: 'Select size',
                            items: _conditions,
                            value: service.size,
                            onChanged: service.setSize,
                          ),
                          CustomDropdownField(
                            title: 'Color',
                            hintText: 'Select color',
                            items: _conditions,
                            value: service.color,
                            onChanged: service.setColor,
                          ),
                          CustomDropdownField(
                            title: 'Condition',
                            hintText: 'Select Condition',
                            items: _conditions,
                            value: service.condition,
                            onChanged: service.setCondition,
                          ),
                        ],
                      ),
                    ),
                    CustomTimeField(title: 'Time'),
                    CustomTimeField(title: 'Time'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffDE3526),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Upload',
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}