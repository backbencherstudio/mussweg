import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

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
                    ),
                    CustomDropdownField(
                      title: 'Category',
                      hintText: 'Select category',
                    ),
                    CustomDropdownField(
                      title: 'Size',
                      hintText: 'Select size',
                    ),
                    CustomDropdownField(
                      title: 'Color',
                      hintText: 'Select color',
                    ),
                    CustomDropdownField(
                      title: 'Conditions',
                      hintText: 'Select Condition',
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

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              )),
          SizedBox(height: 8.h),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String title;
  final String hintText;

  const CustomDropdownField({
    super.key,
    required this.title,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              )),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: null,
                hint: Text(hintText, style: TextStyle(fontSize: 14.sp)),
                items: const [],
                onChanged: (String? newValue) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTimeField extends StatelessWidget {
  final String title;

  const CustomTimeField({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              )),
          SizedBox(height: 8.h),
          TextField(
            decoration: InputDecoration(
              hintText: 'Set time',
              suffixIcon: Icon(Icons.access_time, size: 20.w),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
