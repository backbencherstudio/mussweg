import 'package:flutter/material.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';


class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Inbox'),
      body: ListView(
        children: [
          _buildInboxItem(
            context,
            'Kathryn Murphy',
            'Hi! Would you sell this for \$25.00?',
            'an hour ago',
            'assets/icons/user_profile.png',
            [
              'assets/images/dress.png',
              'assets/images/dress.png',
              'assets/images/dress.png',
            ],
          ),
          _buildInboxItem(
            context,
            'Devon Lane',
            'Hi! Would you sell this for \$25.00?',
            '10 hours ago',
            'assets/icons/user_profile.png',
            [
              'assets/images/dress.png',
              'assets/images/dress.png',
              'assets/images/dress.png',
            ],
          ),
          _buildInboxItem(
            context,
            'Annette Black',
            'Hi! Would you sell this for \$25.00?',
            '23 hours ago',
            'assets/icons/user_profile.png',
            [
              'assets/images/dress.png',
              'assets/images/dress.png',
              'assets/images/dress.png',
            ],
            showPlus: true,
            plusCount: 2,
          ),
          _buildInboxItem(
            context,
            'Darlene Robertson',
            'Hi! Would you sell this for \$25.00?',
            '2 days ago',
            'assets/icons/user_profile.png',
            [
              'assets/images/dress.png',
              'assets/images/dress.png',
              'assets/images/dress.png',
            ],
            showPlus: true,
            plusCount: 2,
          ),
          _buildInboxItem(
            context,
            'Arlene McCoy',
            'Hi! Would you sell this for \$25.00?',
            '3 days ago',
            'assets/icons/user_profile.png',
            [
              'assets/images/dress.png',
              'assets/images/dress.png',
              'assets/images/dress.png',
            ],
            showPlus: true,
            plusCount: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildInboxItem(
      BuildContext context,
      String name,
      String message,
      String time,
      String avatarUrl,
      List<String> productImages,
      {bool showPlus = false, int plusCount = 0}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Top row: avatar, name, time
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(avatarUrl),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4A4C56),
                    ),
                  ),
                  Spacer(),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Color(0xff4A4C56)),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 58,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text & images to right
                      children: [
                        Text(
                          message,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min, // Wrap only around images
                          children: productImages.map((imageUrl) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  imageUrl,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
        const Divider(indent: 16, endIndent: 16),
      ],
    );

  }
}
