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
    return ScreenUtilInit(
      designSize: const Size(375, 812), // your design size
      builder: (context, child) {
        return Scaffold(
          appBar: SimpleApppbar(title: 'Profile'),
          body: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0.w,
                      vertical: 20.0.h,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90.w,
                          height: 90.h,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/icons/user_profile.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cameron Williamson',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff4A4C56),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/icons/location.png',
                                    scale: 1,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Switzerland',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontSize: 14.sp,
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
                  Divider(
                    height: 1.h,
                    thickness: 1.h,
                    color: Color.fromARGB(255, 235, 235, 235),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      ProfileMenuItem(
                        image: 'assets/icons/user.png',
                        title: 'My Profile',
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.sellerProfilePage);
                        },
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                      ProfileMenuItem(
                        image: 'assets/icons/love.png',
                        title: 'Favorite items',
                        onTap: () {},
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                      ProfileMenuItem(
                        image: 'assets/icons/sell.png',
                        title: 'Bought items',
                        onTap: () {},
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                      ProfileMenuItem(
                        image: 'assets/icons/sell.png',
                        title: 'Selling items',
                        onTap: () { Navigator.pushNamed(context, RouteNames.sellItemPage);},
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                      ProfileMenuItem(
                        image: 'assets/icons/notification.png',
                        title: 'Notifications',
                        onTap: () { Navigator.pushNamed(context, RouteNames.notificationsPage);},
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                      ProfileMenuItem(
                        image: 'assets/icons/credit_card.png',
                        title: 'Transactions History',
                        onTap: () {Navigator.pushNamed(context, RouteNames.transactionsHistoryPage);},
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                      ProfileMenuItem(
                        image: 'assets/icons/profile_user.png',
                        title: 'Account Settings',
                        onTap: () { Navigator.pushNamed(context, RouteNames.accountSettingsPage);},
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                      ProfileMenuItem(
                        image: 'assets/icons/language.png',
                        title: 'Language',
                        onTap: () {Navigator.pushNamed(context, RouteNames.languagePage);},
                      ),
                      Divider(color: Colors.grey[350], height: 1.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}