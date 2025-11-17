import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/constants/api_end_points.dart';

class SellerProfileRefresh extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final String avatarUrl;
final int starCount;

  const SellerProfileRefresh({
    super.key,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.title, required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90.r),
            child: Image.network(
              "${ApiEndpoints.baseUrl}${avatarUrl.replaceAll('http://localhost:5005', '')}",
              fit: BoxFit.cover,
              width: 50.w,
              height: 50.h,
              loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                  ) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value:
                    loadingProgress.expectedTotalBytes !=
                        null
                        ? loadingProgress
                        .cumulativeBytesLoaded /
                        loadingProgress
                            .expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/icons/user.png',
                    fit: BoxFit.cover,
                    width: 30.w,
                    height: 30.h,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(time ?? '')),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: starCount,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        color: Colors.orange.shade400,
                        size: 24,
                      );
                    },
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 14, color: Color(0xff777980),fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.h),
                Divider(height: 1.h, color: Colors.grey.shade300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
