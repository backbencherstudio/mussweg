import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/track_progress/widget/delivery_time_line.dart';
import 'package:mussweg/views/track_progress/widget/pickup_timer_widget.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';

class TrackProgressScreen extends StatelessWidget {
  const TrackProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SimpleApppbar(title: 'Track Progress'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: PickupTimerWidget(),
                ),
                SizedBox(height: 24.h,),
                Text(
                  'Tracking History',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h,),
                DeliveryTimeline(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
