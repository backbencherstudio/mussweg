import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
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

                      return GestureDetector(
                        onTap: () async {
                          await inboxProvider.getAllMessage(item.id ?? "");
                          if (item.id != null) {
                            Navigator.pushNamed(
                              context,
                              RouteNames.chatScreen,
                              arguments: {
                                'conversationId': conversations[index].id, // <-- Use a string key
                              },
                            );
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("User Id Not Found")),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  (participants[1].avatar != null && participants[1].avatar!.isNotEmpty)
                                      ?  "${ApiEndpoints.baseUrl}/public/storage/avatar/${participants[1].avatar}"
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
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey),
                            ],
                          ),
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
}
