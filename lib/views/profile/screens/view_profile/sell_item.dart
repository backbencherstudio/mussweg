import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_time_text_field.dart';

class SellItemPage extends StatefulWidget {
  const SellItemPage({super.key});
  @override
  State<SellItemPage> createState() => _SellItemPageState();
}
class _SellItemPageState extends State<SellItemPage> {
  final List<String> _conditions = [
    "New",
    "Used",
    "Refurbished",
  ];
  String? _selectedCondition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Sell an Item'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  OutlinedButton.icon(
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.red,
                      size: 20.w,
                    ),
                    label: Text(
                      'Upload photos',
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red, width: 1.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Add up to 20 photos.',
                    style: TextStyle(color: Color(0xff929292), fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Color(0xffE9E9EA), width: 1.5.w),
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Sell',
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}