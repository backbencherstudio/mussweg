import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_time_text_field.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});
  @override
  State<EditProductPage> createState() => _EditProductPageState();
}
class _EditProductPageState extends State<EditProductPage> {
  final List<String> _conditions = [
    "New",
    "Used",
    "Refurbished",
  ];
  String? _selectedCondition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Edit Product'),
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
                    child: Image.asset('assets/images/dress.png', fit: BoxFit.cover),
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
            Row(
              children: [
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset('assets/images/dress.png'))),
                SizedBox(width: 8.w),
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset('assets/images/dress.png'))),
                SizedBox(width: 8.w),
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset('assets/images/dress.png'))),
              ],
            ),
            SizedBox(height: 24.h),
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
                      title: 'Title',
                      hintText: 'e.g. Blue Pottery Vase',
                    ),
                    CustomTextField(
                      title: 'Descriptions',
                      hintText: 'e.g. Blue Pottery Vase',
                    ),
                    CustomDropdownField(
                      title: 'Location',
                      hintText: 'Select location',
                      items: _conditions,
                      value: _selectedCondition,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
                    ),
                    CustomDropdownField(
                      title: 'Category',
                      hintText: 'Select category',
                      items: _conditions,
                      value: _selectedCondition,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
                    ),
                    CustomDropdownField(
                      title: 'Size',
                      hintText: 'Select size',
                      items: _conditions,
                      value: _selectedCondition,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
                    ),
                    CustomDropdownField(
                      title: 'Color',
                      hintText: 'Select color',
                      items: _conditions,
                      value: _selectedCondition,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
                    ),
                    CustomDropdownField(
                      title: 'Conditions',
                      hintText: 'Select Condition',
                      items: _conditions,
                      value: _selectedCondition,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
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
                backgroundColor: Color(0xffDE3526),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text('Upload',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp)),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}