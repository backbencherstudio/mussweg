import 'package:flutter/material.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';


class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Account Settings'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side:  BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(context, 'Full Name', 'Cameron Williamson'),
                    _buildSettingItem(context, 'Email Address', 'cameron@gmail.com'),
                    _buildSettingItem(context, 'Location', 'Switzerland'),
                    _buildSettingItem(context, 'Gender', 'Male'),
                    _buildSettingItem(context, 'Date Of Birth', '02 Aug 1999'),
                    _buildSettingItem(context, 'Change Password', '**** **** *****'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, color: Color(0xff4A4C56),fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 14,color: Color(0xff777980)),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Image.asset('assets/icons/edit_text.png',scale: 3,),
                onPressed: () {
                  // Handle edit action
                },
              ),
            ],
          ),
        ),
        if (title != 'Change Password') // Add a divider for all but the last item
          const Divider(height: 1, color: Color(0xffE9E9EA)),
      ],
    );
  }
}
