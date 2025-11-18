import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:mussweg/views/inbox/view_model/inbox_screen_provider.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:mussweg/core/services/user_id_storage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  loadUserId() async {
    currentUserId = await UserIdStorage().getUserId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InboxScreenProvider>(context);
    final messageInfo = provider.allMessageModel?.data ?? [];

    return Scaffold(
      appBar: SimpleApppbar(title: 'Chat'),
      body:
          currentUserId == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/user_2.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cameron Williamson",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rate_outlined,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text("5.0"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // --- Messages List --- //
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: messageInfo.length,
                      itemBuilder: (context, index) {
                        final msg = messageInfo[index];

                        final isCurrentUser = msg.sender?.id == currentUserId;
                        final timestamp =
                            msg.createdAt != null
                                ? DateTime.parse(msg.createdAt!)
                                : DateTime.now();

                        return MessageBubble(
                          message: msg.text ?? "",
                          timestamp: DateFormat('hh:mm a').format(timestamp),
                          isSent: isCurrentUser,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Write a message here...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.send), onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String timestamp;
  final bool isSent;

  const MessageBubble({
    required this.message,
    required this.timestamp,
    required this.isSent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.all(12),
            constraints: BoxConstraints(maxWidth: 260),
            decoration: BoxDecoration(
              color: isSent ? Colors.purple : Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: isSent ? Radius.circular(16) : Radius.zero,
                bottomRight: isSent ? Radius.zero : Radius.circular(16),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isSent ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Text(timestamp, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
