import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mussweg/views/widgets/custom_primary_button.dart';

class ReviewDialog {
  showReviewDialog(context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('How is Your Order?', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Please take a moment to rate and review...'),
            SizedBox(height: 12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 8.w,
                children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber)),
              ),

            SizedBox(height: 12.h),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                hintText: 'Write your review',
                suffixIcon: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SvgPicture.asset('assets/icons/image.svg', height: 20.w, width: 20.w,),
                )
              ),
            ),
            SizedBox(height: 12.h),
           SizedBox(
             width: double.infinity,
             child: CustomPrimaryButton(title: 'Submit', onTap: () {
               Navigator.pop(context);
             }),
           )

          ],
        ),
      );
    });
  }
}
