import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardWidget extends StatelessWidget {
  const ShimmerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 220.w,
        padding: EdgeInsets.all(
          8.0,
        ), // Ensure this padding doesn't overlap or hide content
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmered Image Placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: _buildContainer(120, 220),
            ),
            SizedBox(height: 8.h), // Add space between elements
            // Shimmered Title Placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: _buildContainer(16, 220),
            ),
            SizedBox(height: 8.h), // Add space between elements
            // Shimmered Size/Condition Placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: _buildContainer(13, 220),
            ),
            SizedBox(height: 8.h), // Add space between elements
            // Shimmered Time/Boost Placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: _buildContainer(14, 220),
            ),
            SizedBox(height: 20.h), // Add space between elements
            // Shimmered Price Placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: _buildContainer(20, 100),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildContainer(double height, double width) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
