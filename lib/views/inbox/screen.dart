import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/inbox/view_model/inbox_screen_provider.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../view_model/parent_provider/parent_screen_provider.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final Map<int, int> _visibleCounts = {};

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(
          title: 'Inbox',
          onBack:
              () => context.read<ParentScreensProvider>().onSelectedIndex(0),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<InboxScreenProvider>(
                builder: (context, inboxProvider, child) {
                  final conversations =
                      inboxProvider.inboxModel?.conversations ?? [];

                  return ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final item = conversations[index];

                      final participants = item.participants ?? [];
                      final participantName =
                          participants.length > 1
                              ? participants[1].name
                              : "Unknown";

                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                (participants[1].avatar != null)
                                    ? participants[1].avatar!
                                    : "https://nftcalendar.io/storage/uploads/2022/02/21/image-not-found_0221202211372462137974b6c1a.png", // fallback image
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    participantName!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    (item.lastMessage?.text ?? "N/A"),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Divider(color: Colors.grey),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 75.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInboxItem(
    BuildContext context,
    int index,
    String name,
    String message,
    String time,
    String avatarUrl,
    List<String> productImages,
    int visibleCount,
  ) {
    bool hasMore = visibleCount < productImages.length;
    int remaining = productImages.length - visibleCount;

    List<String> visibleImages = productImages.take(visibleCount).toList();

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.chatScreen);
      },
      child: Column(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff4A4C56),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ],
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
                    SizedBox(width: 54.w),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...visibleImages.map((imageUrl) {
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
                          if (hasMore)
                            Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _visibleCounts[index] =
                                        (_visibleCounts[index] ?? 2) + 2;
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.r),
                                      child: Image.asset(
                                        productImages[visibleCount],
                                        width: 40.w,
                                        height: 40.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: 40.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                          5.r,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '+$remaining',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}

// Dummy data for inbox items
final List<Map<String, dynamic>> _inboxData = [
  {
    'name': 'Kathryn Murphy',
    'message': 'Hi! Would you sell this for \$25.00?',
    'time': 'an hour ago',
    'avatarUrl': 'assets/icons/user_profile.png',
    'productImages': [
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
    ],
  },
  {
    'name': 'Devon Lane',
    'message': 'Hi! Would you sell this for \$25.00?',
    'time': '10 hours ago',
    'avatarUrl': 'assets/icons/user_profile.png',
    'productImages': [
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
    ],
  },
  {
    'name': 'Annette Black',
    'message': 'Hi! Would you sell this for \$25.00?',
    'time': '23 hours ago',
    'avatarUrl': 'assets/icons/user_profile.png',
    'productImages': [
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
    ],
  },
  {
    'name': 'Darlene Robertson',
    'message': 'Hi! Would you sell this for \$25.00?',
    'time': '2 days ago',
    'avatarUrl': 'assets/icons/user_profile.png',
    'productImages': [
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
    ],
  },
  {
    'name': 'Arlene McCoy',
    'message': 'Hi! Would you sell this for \$25.00?',
    'time': '3 days ago',
    'avatarUrl': 'assets/icons/user_profile.png',
    'productImages': [
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
      'assets/images/dress.png',
    ],
  },
];
