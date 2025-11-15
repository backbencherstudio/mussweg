
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../data/model/bids/bids_response.dart';

class BiderListCard extends StatelessWidget {
  const BiderListCard({
    super.key, this.bid,
  });

  final Bid? bid;

  @override
  Widget build(BuildContext context) {


    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(90.r),
          child: Image.network(
            "${ApiEndpoints.baseUrl}${bid?.biderAvatar.replaceAll('http://localhost:5005', '')}",
            height: 44.w,
            width: 44.w,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (_, __, ___) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(90.r),
                child: Container(
                  height: 44.w,
                  width: 44.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Image.asset(
                    'assets/icons/user.png',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 8.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(bid?.biderName ?? 'Unknown', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),),
                  Text('\$${bid?.bidAmount}', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),),
                ],
              ),
              Text(bid?.status ?? 'Unknown', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),),
            ],
          ),
        )
      ],
    );
  }
}