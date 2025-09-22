import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/profile/widgets/profile_menu_item.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Profile'),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/icons/user_profile.png',
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cameron Williamson',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4A4C56),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            spacing: 6,
                            children: [
                              Image.asset(
                                'assets/icons/location.png',
                                scale: 2.8,
                              ),
                              Text(
                                'Switzerland',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {

                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red,
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
              const Divider(
                height: 1,
                thickness: 1,
                color: Color.fromARGB(255, 235, 235, 235),
              ),
              SizedBox(height: 10.h,),
              Column(
                children: [
                  ProfileMenuItem(
                    image: 'assets/icons/user.png',
                    title: 'My Profile',
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.sellerProfilePage);
                    },
                  ),
                  Divider(color: Colors.grey[350]),
                  ProfileMenuItem(
                    image: 'assets/icons/love.png',
                    title: 'Favorite items',
                    onTap: () {},
                  ),
                  Divider(color: Colors.grey[350]),
                  ProfileMenuItem(
                    image: 'assets/icons/sell.png',
                    title: 'Bought items',
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.boughtItemsScreen);
                    },
                  ),
                  Divider(color: Colors.grey[350]),
                  ProfileMenuItem(
                    image: 'assets/icons/sell.png',
                    title: 'Selling items',
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.sellingItemsScreen);
                    },
                  ),
                  Divider(color: Colors.grey[350]),
                  ProfileMenuItem(
                    image: 'assets/icons/notification.png',
                    title: 'Notifications',
                    onTap: () { Navigator.pushNamed(context, RouteNames.notificationsPage);},
                  ),
                  Divider(color: Colors.grey[350]),
                  ProfileMenuItem(
                    image: 'assets/icons/credit_card.png',
                    title: 'Transactions History',
                    onTap: () { Navigator.pushNamed(context, RouteNames.transactionsHistoryPage);},
                  ),
                  Divider(color: Colors.grey[350]),
                  ProfileMenuItem(
                    image: 'assets/icons/profile_user.png',
                    title: 'Account Settings',
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.accountSettingsPage);
                    },
                  ),
                  Divider(color: Colors.grey[350]),
                  ProfileMenuItem(
                    image: 'assets/icons/language.png',
                    title: 'Language',
                    onTap: () { Navigator.pushNamed(context, RouteNames.languagePage);},
                  ),
                  Divider(color: Colors.grey[350]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}