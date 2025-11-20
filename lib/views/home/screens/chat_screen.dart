import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
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
  String? conversationId;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  File? image;

  @override
  void initState() {
    super.initState();
    loadUserId();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        final provider =
        Provider.of<InboxScreenProvider>(context, listen: false);
        if (conversationId != null) {
          provider.getAllMessage(conversationId!, isLoadMore: true);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    conversationId = args?['conversationId'];

    if (conversationId != null) {
      Provider.of<InboxScreenProvider>(context, listen: false)
          .getAllMessage(conversationId!);
    }
  }

  Future<void> loadUserId() async {
    currentUserId = await UserIdStorage().getUserId();
    setState(() {});
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = File(picked.path));
    }
  }

  void sendMessage(InboxScreenProvider provider) {
    final text = _controller.text.trim();
    if ((text.isEmpty && image == null) || conversationId == null) return;

    provider.sendMessage(text, conversationId!, image);
    _controller.clear();
    setState(() => image = null);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InboxScreenProvider>(context);
    final messages = provider.allMessageModel?.data ?? [];

    return Scaffold(
      appBar: SimpleApppbar(title: "Chat"),
      body: currentUserId == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: provider.isMoreLoading
                  ? messages.length + 1
                  : messages.length,
              itemBuilder: (context, index) {
                if (provider.isMoreLoading && index == messages.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final msg = messages[index];
                final isMe = msg.sender?.id == currentUserId;
                final timestamp = msg.createdAt != null
                    ? DateTime.parse(msg.createdAt!)
                    : DateTime.now();

                return MessageBubble(
                  message: msg.text ?? "",
                  timestamp: DateFormat('hh:mm a').format(timestamp),
                  isSent: isMe,
                );
              },
            ),
          ),

          if (image != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(image!, width: 100, height: 100),
                  GestureDetector(
                    onTap: () => setState(() => image = null),
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Write a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => sendMessage(provider),
                ),
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
    super.key,
    required this.message,
    required this.timestamp,
    required this.isSent,
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
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 260),
            decoration: BoxDecoration(
              color: isSent ? Colors.purple : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isSent ? Colors.white : Colors.black,
              ),
            ),
          ),
          Text(timestamp,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
