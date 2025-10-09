import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/profile/widgets/profile_menu_item.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(
          title: 'Profile',
          onBack: () =>
              context.read<ParentScreensProvider>().onSelectedIndex(0),
        ),
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
                            'assets/icons/myyyy.jpeg',
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Protiva Induri Powered by Rawnak',
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
                                  scale: 1,
                                ),
                                Text(
                                  '',
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
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.sellerProfilePage,
                                );
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
                SizedBox(height: 10.h),
                Column(
                  children: [
                    ProfileMenuItem(
                      image: 'assets/icons/user.png',
                      title: 'My Profile',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.sellerProfilePage,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/love.png',
                      title: 'Favorite items',
                      onTap: () {
                        context.read<ParentScreensProvider>().onSelectedIndex(
                          1,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/border-all-01.png',
                      title: 'Bought items',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.boughtItemsScreen,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/border-all-01.png',
                      title: 'Selling items',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.sellingItemsScreen,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/notification.png',
                      title: 'Notifications',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.notificationsPage,
                        );
                      },
                    ), Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/border-all-01.png',
                      title: 'Bid List',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.bidList,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/credit-card-pos (1).png',
                      title: 'Transactions History',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.transactionsHistoryPage,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/profile_user.png',
                      title: 'Account Settings',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.accountSettingsPage,
                        );
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/language.png',
                      title: 'Language',
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.languagePage);
                      },
                    ),
                    Divider(color: Colors.grey[350]),
                  ],
                ),
                SizedBox(height: 75.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
