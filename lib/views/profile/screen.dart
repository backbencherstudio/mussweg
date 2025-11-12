import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/core/services/token_storage.dart';
import 'package:mussweg/core/services/user_email_storage.dart';
import 'package:mussweg/core/services/user_id_storage.dart';
import 'package:mussweg/core/services/user_name_storage.dart';
import 'package:mussweg/data/user_all_products/user_all_products_viewmodel.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/view_model/profile/user_all_products/user_all_products_provider.dart';
import 'package:mussweg/views/profile/widgets/profile_menu_item.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../core/constants/api_end_points.dart';
import '../../view_model/auth/login/get_me_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetMeViewmodel>().fetchUserData();
      context.read<UserAllProductsProvider>().getAllUserProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<GetMeViewmodel>();
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90.r),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.w,
                            ),
                          ),
                          child: Image.network(
                            "${ApiEndpoints.baseUrl}/public/storage/avatar/${userVM.user?.avatar}",
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return SizedBox(
                                width: 90,
                                height: 90,
                                child: Image.asset('assets/icons/user.png',)
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userVM.user?.name ?? 'Guest',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4A4C56),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Image.asset("assets/icons/location.png"),
                                SizedBox(width: 7.w),
                                Text(
                                  userVM.user?.address ?? 'unknown',
                                  style: TextStyle(
                                    color: const Color(0xff777980),
                                    fontSize: 14.sp,
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
                                  RouteNames.accountSettingsPage,
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
                    ),
                    Divider(color: Colors.grey[350]),
                    ProfileMenuItem(
                      image: 'assets/icons/border-all-01.png',
                      title: 'Bid List',
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.bidList);
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
                    ProfileMenuItem(
                      image: 'assets/icons/language.png',
                      title: 'Logout',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Logout'),
                              content: const Text(
                                'Are you sure you want to logout?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await TokenStorage().clearToken();
                                    await UserEmailStorage().clearUserEmail();
                                    await UserIdStorage().clearUserId();
                                    await UserNameStorage().clearUserName();
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteNames.loginScreen,
                                      (pre) => false,
                                    );
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
