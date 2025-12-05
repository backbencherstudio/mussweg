import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notification_screen_provider.dart';
import 'notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationScreenProvider _provider;

  @override
  void initState() {
    super.initState();
    // Fetch notifications when screen loads
    _provider = Provider.of<NotificationScreenProvider>(context, listen: false);
    _provider.refreshNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: Consumer<NotificationScreenProvider>(
        builder: (context, provider, child) {
          final notifications = provider.notificationModel?.data ?? [];

          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 6),
                    Text('Status: ${notification.status ?? '-'}'),
                    const SizedBox(height: 4),
                    Text('Created at: ${notification.createdAt ?? '-'}'),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        notification.readAt == null
                            ? Icons.mark_email_unread
                            : Icons.mark_email_read,
                        color:
                            notification.readAt == null
                                ? Colors.red
                                : Colors.green,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
