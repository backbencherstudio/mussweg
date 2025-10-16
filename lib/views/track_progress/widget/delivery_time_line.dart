import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/model/track_progress/deliver_step.dart';

class DeliveryTimeline extends StatelessWidget {
  DeliveryTimeline({super.key});

  final steps = [
    DeliveryStep(title: 'Request Submitted', isCompleted: true),
    DeliveryStep(title: 'Pickup Scheduled', isCompleted: true),
    DeliveryStep(title: 'Item Pickup', isCompleted: false),
    DeliveryStep(title: 'Package has been received', isCompleted: false),
    DeliveryStep(title: 'Delivery', isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        final isLast = index == 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isLast)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 5,
                  height: 50,
                  decoration: BoxDecoration(
                    color: step.isCompleted ? Colors.red : Colors.red.shade200,
                    borderRadius: BorderRadius.circular(20.r)
                  ),
                ),
              ),
            Row(
              children: [
                Container(
                  width: 20.h,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: step.isCompleted ? Colors.red : Colors.white,
                    border: Border.all(
                      color: Colors.red,
                      width: 3.5.w,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12.w,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      step.title,
                      style: TextStyle(
                        fontSize: 16,
                        color: step.isCompleted
                            ? Colors.black
                            : Colors.black.withOpacity(0.6),
                        fontWeight: step.isCompleted
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
