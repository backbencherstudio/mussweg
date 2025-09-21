import 'package:flutter/material.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int selectedIndex = 0;
  final List<String> options = ["All", "Recent", "Earlier"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Notifications'),
      body: Column(
        children: [

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
            child: Row(
              children: List.generate(options.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SelectableChip(
                    text: options[index],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                );
              }),
            ),
          ),


          Expanded(
            child: ListView(
              children: [
                _buildNotificationItem(
                  context,
                  'Divya message you.Do you want to reply?',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                  isInteractive: true,
                ),
                _buildNotificationItem(
                  context,
                  'Guillaume review your products.',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                ),
                _buildNotificationItem(
                  context,
                  'Divya and Guillaume placed 2 order (Man exclusive t-shirt)',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                ),
                _buildNotificationItem(
                  context,
                  'Smart TV has just been listed! Check it out before someone else grabs it. Don\'t miss your chance!',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                ),
                _buildNotificationItem(
                  context,
                  'Congrats! Your T-Shirt has been sold. We\'ve notified the buyer, and your payment is being processed.',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                ),
                _buildNotificationItem(
                  context,
                  'Divya message you.Do you want to reply?',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                  isInteractive: true,
                ),
                _buildNotificationItem(
                  context,
                  'Congrats! Your T-Shirt has been sold. We\'ve notified the buyer, and your payment is being processed.',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                ),
                _buildNotificationItem(
                  context,
                  'Congrats! Your T-Shirt has been sold. We\'ve notified the buyer, and your payment is being processed.',
                  '1hr ago',
                  'assets/icons/user_profile.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
      BuildContext context,
      String message,
      String time,
      String avatarUrl, {
        bool isInteractive = false,
      }) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
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
                        message,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),

                if (isInteractive) ...[
                   SizedBox(height: 8.h),
                  Row(
                    children: [
                      _actionButton("Yes", () {}),
                       SizedBox(width: 8.w),
                      _actionButton("No", () {}),
                    ],
                  ),
                ],

                 SizedBox(height: 8.h),
                Divider(height: 1.h, color: Colors.grey.shade300),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String text, VoidCallback onTap) {
    return SizedBox(
      height: 30.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}

class SelectableChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(text),
      selected: isSelected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      labelStyle: TextStyle(
        color: isSelected ? Colors.red : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      ),
      selectedColor: Colors.red.withOpacity(0.2),
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding:  EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
    );
  }
}
