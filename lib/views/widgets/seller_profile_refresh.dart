// lib/views/widgets/seller_profile_refresh.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import '../../core/constants/api_end_points.dart';
import '../../view_model/language/language_provider.dart';

class SellerProfileRefresh extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final String avatarUrl;
  final int starCount;
  final LanguageProvider? languageProvider;

  const SellerProfileRefresh({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.starCount,
    this.languageProvider,
  });

  @override
  Widget build(BuildContext context) {
   // final langProvider = languageProvider ?? context.read<LanguageProvider>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          _buildAvatar(context),
          SizedBox(width: 16.w),
          // Review content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Debug text removed
                // Text(langProvider.translate('table')), // Removed this line

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      _formatTime(time),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Star rating
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color:
                      index < starCount
                          ? Colors.orange.shade400
                          : Colors.grey.shade300,
                      size: 18.w,
                    );
                  }),
                ),
                SizedBox(height: 8.h),

                // Review message
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff777980),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),

                // Divider
                Divider(height: 1.h, color: Colors.grey.shade300),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child:
        avatarUrl.isNotEmpty
            ? _buildNetworkImage()
            : _buildPlaceholderImage(),
      ),
    );
  }

  Widget _buildNetworkImage() {
    String imageUrl;

    // Handle different URL formats
    if (avatarUrl.startsWith('http')) {
      imageUrl = avatarUrl;
    } else if (avatarUrl.startsWith('/')) {
      imageUrl = "${ApiEndpoints.baseUrl}$avatarUrl";
    } else {
      imageUrl = "${ApiEndpoints.baseUrl}/public/storage/avatar/$avatarUrl";
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value:
            loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholderImage();
      },
    );
  }

  Widget _buildPlaceholderImage() {
    return Center(
      child: Icon(Icons.person, size: 30.w, color: Colors.grey[500]),
    );
  }

  String _formatTime(String time) {
    if (time.isEmpty) return '';

    try {
      // If time is already a relative time (e.g., "2 days ago")
      if (time.contains('ago') ||
          time.contains('day') ||
          time.contains('hour') ||
          time.contains('minute') ||
          time.contains('second') ||
          time.contains('month') ||
          time.contains('year')) {
        return time;
      }

      // Try to parse as DateTime if it's in ISO format
      final dateTime = DateTime.tryParse(time);
      if (dateTime != null) {
        final now = DateTime.now();
        final difference = now.difference(dateTime);

        if (difference.inDays > 365) {
          final years = (difference.inDays / 365).floor();
          return '$years ${years == 1 ? 'year' : 'years'} ago';
        } else if (difference.inDays > 30) {
          final months = (difference.inDays / 30).floor();
          return '$months ${months == 1 ? 'month' : 'months'} ago';
        } else if (difference.inDays > 0) {
          final days = difference.inDays;
          return '$days ${days == 1 ? 'day' : 'days'} ago';
        } else if (difference.inHours > 0) {
          final hours = difference.inHours;
          return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
        } else if (difference.inMinutes > 0) {
          final minutes = difference.inMinutes;
          return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
        } else {
          return 'Just now';
        }
      }

      return time;
    } catch (e) {
      return time;
    }
  }
}