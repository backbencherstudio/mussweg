import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

import '../../profile/widgets/pickup_option_widget.dart';

class MusswegGuidelineScreen extends StatelessWidget {
  const MusswegGuidelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> headings = [
      {'icon': 'assets/icons/info_circle.svg', 'title': 'Pickup Guidelines'},
      {'icon': 'assets/icons/alert.svg', 'title': 'What we do not accept'},
      {
        'icon': 'assets/icons/note-list-check.svg',
        'title': 'Pickup Conditions',
      },
    ];

    return Scaffold(
      appBar: SimpleApppbar(title: 'Muss-weg Guideline'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeaderRow(
                headline: headings[0]['title'],
                icon: headings[0]['icon'],
              ),
              Text(
                'Please review the following rules before booking a Dispose Now pickup.',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'These guidelines ensure a smooth and safe collection process for both you and our team.',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              buildHeaderRow(
                headline: headings[1]['title'],
                icon: headings[1]['icon'],
              ),
              Text(
                'Hazardous materials such as chemicals , paint, gas bottles, or batteries Food, liquids, or any perishable items Construction debris, rubble, or industrial waste Items containing biological or medical waste Items infested with mold, pests, or insects',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              buildHeaderRow(
                headline: headings[2]['title'],
                icon: headings[2]['icon'],
              ),
              buildInfoRow(
                title: 'Pickups are only available on Saturdays or Sundays.',
              ),
              buildInfoRow(
                title: 'The exact pickup time will be confirmed after payment.',
              ),
              buildInfoRow(
                title:
                    'All items must be placed outside (e.g., curbside, driveway, or building entrance).',
              ),
              buildInfoRow(
                title:
                    'Our team does not enter homes, apartments, or buildings to collect items.',
              ),
              Text(
                'Please ensure items are easily accessible and not blocking public walkways.',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 12.h),
              PrimaryButton(
                onTap: () {
                  Navigator.pop(context);
                  Future.microtask(() {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: PickupOptionWidget(),
                        );
                      },
                    );
                  });
                },
                title: 'I Accept',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderRow({required String icon, required String headline}) {
    return Row(
      children: [
        SvgPicture.asset(icon, height: 24.w, width: 24.w),
        SizedBox(width: 8.w),
        Text(
          headline,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow({required String title}) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/check.svg', height: 16.w, width: 16.w),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
