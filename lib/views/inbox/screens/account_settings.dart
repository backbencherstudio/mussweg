import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Account Settings'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0.r),
                  side: BorderSide(color: Colors.grey.shade300, width: 0.5.w),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(context, 'Full Name', 'Cameron Williamson'),
                    _buildSettingItem(context, 'Email Address', 'cameron@gmail.com'),
                    _buildSettingItem(context, 'Location', 'Switzerland'),
                    _buildSettingItem(context, 'Gender', 'Male'),
                    _buildSettingItem(context, 'Date Of Birth', '02 Aug 1999'),
                    _buildSettingItem(context, 'Change Password', '**** **** *****'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSettingItem(BuildContext context, String title, String value) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xff4A4C56),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff777980),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/edit_text.png',
                  scale: 3.w,
                ),
                onPressed: () {
                  // Handle edit action
                },
              ),
            ],
          ),
        ),
        if (title != 'Change Password')
          Divider(height: 1.h, color: const Color(0xffE9E9EA)),
      ],
    );
  }
}