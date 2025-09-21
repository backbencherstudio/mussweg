import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        leading:  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Row(
                  children: [

                  SizedBox(
                  width: 90,
                  height: 90,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/user_profile.png'),
                  ),
                ),

                  const SizedBox(width: 16),
                    // User details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cameron Williamson',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4A4C56)
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            spacing: 6,
                            children: [
                              Image.asset('assets/icons/location.png',scale: 2.8,),
                               Text(
                                'Switzerland',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              // Handle "Edit Profile" tap
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Divider line
              const Divider(height: 1, thickness: 1, color: Color.fromARGB(255, 235, 235, 235)),
              // List of menu items
              Column(
                children: [
                  ProfileMenuItem(icon: Icons.person_outline, title: 'My Profile', onTap: () {}),
                  ProfileMenuItem(icon: Icons.favorite_border, title: 'Favorite items', onTap: () {}),
                  ProfileMenuItem(icon: Icons.add_shopping_cart, title: 'Bought items', onTap: () {}),
                  ProfileMenuItem(icon: Icons.add_circle_outline, title: 'Selling items', onTap: () {}),
                  ProfileMenuItem(icon: Icons.notifications_none, title: 'Notifications', onTap: () {}),
                  ProfileMenuItem(icon: Icons.receipt_long, title: 'Transactions History', onTap: () {}),
                  ProfileMenuItem(icon: Icons.manage_accounts_outlined, title: 'Account Settings', onTap: () {}),
                  ProfileMenuItem(icon: Icons.language_outlined, title: 'Language', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Color(0xff4A4C56),fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}