import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../view_model/parent_provider/parent_screen_provider.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(title: 'Inbox', onBack: () => context.read<ParentScreensProvider>().onSelectedIndex(0)),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildInboxItem(
                    context,
                    'Kathryn Murphy',
                    'Hi! Would you sell this for \$25.00?',
                    'an hour ago',
                    'assets/icons/user_profile.png',
                    [
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                    ],
                  ),
                  _buildInboxItem(
                    context,
                    'Devon Lane',
                    'Hi! Would you sell this for \$25.00?',
                    '10 hours ago',
                    'assets/icons/user_profile.png',
                    [
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                    ],
                  ),
                  _buildInboxItem(
                    context,
                    'Annette Black',
                    'Hi! Would you sell this for \$25.00?',
                    '23 hours ago',
                    'assets/icons/user_profile.png',
                    [
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                    ],
                    showPlus: true,
                    plusCount: 2,
                  ),
                  _buildInboxItem(
                    context,
                    'Darlene Robertson',
                    'Hi! Would you sell this for \$25.00?',
                    '2 days ago',
                    'assets/icons/user_profile.png',
                    [
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                    ],
                    showPlus: true,
                    plusCount: 2,
                  ),
                  _buildInboxItem(
                    context,
                    'Arlene McCoy',
                    'Hi! Would you sell this for \$25.00?',
                    '3 days ago',
                    'assets/icons/user_profile.png',
                    [
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                      'assets/images/dress.png',
                    ],
                    showPlus: true,
                    plusCount: 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: 75.h,)
          ],
        ),
      ),
    );
  }
  Widget _buildInboxItem(
      BuildContext context,
      String name,
      String message,
      String time,
      String avatarUrl,
      List<String> productImages, {
        bool showPlus = false,
        int plusCount = 0,
      }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: AssetImage(avatarUrl),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff4A4C56),
                      fontSize: 14.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xff4A4C56),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 58.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: productImages.map((imageUrl) {
                            return Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.asset(
                                  imageUrl,
                                  width: 40.w,
                                  height: 40.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(indent: 16.w, endIndent: 16.w),
      ],
    );
  }
}