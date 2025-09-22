import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerProfileRefresh extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final String avatarUrl;
  final bool isInteractive;
  final VoidCallback? onYes;
  final VoidCallback? onNo;


  const SellerProfileRefresh({
    super.key,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.isInteractive = false,
    this.onYes,
    this.onNo,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: AssetImage(avatarUrl),
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
                      time,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
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
