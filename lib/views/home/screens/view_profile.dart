import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../view_model/auth/login/get_me_viewmodel.dart';
import '../../widgets/seller_profile_refresh.dart';

class ViewProfileScreen extends StatelessWidget {
   ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<GetMeViewmodel>(context);

    return Scaffold(
      appBar: SimpleApppbar(title: 'View Profile'),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/banner.png", width: double.infinity),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Transform.translate(
                  offset: Offset(0, -40),
                  child: ClipOval(
                    child: userVM.user?.avatar != null
                        ? Image.network(
                      "${ApiEndpoints.imageBaseurl}/public/storage//avatar${userVM.user!.avatar!}",
                      fit: BoxFit.cover,
                      width: 80.w,
                      height: 80.h,
                    )
                        : Image.asset(
                      'assets/icons/user.png',
                      fit: BoxFit.cover,
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "${userVM.user?.name ?? 'Guest'}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 4),
                        Text("5.0", style: TextStyle(fontSize: 14)),
                        SizedBox(width: 6),
                        Text(
                          "(86 Reviews)",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/location-04.svg'),
                        SizedBox(width: 4),
                        Text(
                          "Switzerland",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                // Message Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.chatScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      "Message",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.red,
                      tabs: [
                        Tab(text: 'Closet'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10,
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.w,
                            mainAxisSpacing: 8.w,
                            childAspectRatio: 0.65,
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.white,
                              elevation: 1,
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4.h,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                12.r,
                                              ),
                                            ),
                                            child: Image.asset(
                                              'assets/images/post_card.png',
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8.w,
                                          left: 8.w,
                                          child: Container(
                                            height: 36.h,
                                            width: 36.w,
                                            padding: EdgeInsets.all(4.w),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffC7C8C8),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 20.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Men Exclusive T-Shirt',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Size Xl (New condition)',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    Text(
                                      'Aug 6, 13:55 ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '(12h: 12m :12s)',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.green.shade600,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    Divider(
                                      color: Colors.grey.shade200,
                                      thickness: .7.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$100',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/icons/cart.png',
                                            color: Colors.red,
                                            height: 24.h,
                                            width: 24.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Reviews Tab
                        ListView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          children: const [
                            SellerProfileRefresh(
                              title: 'Floyd Miles',
                              time: '2hr ago',
                              avatarUrl: 'assets/icons/user_profile.png',
                              message: 'Fast shipping! Thank you!!',
                            ),
                            SellerProfileRefresh(
                              title: 'Esther Howard',
                              time: '5hr ago',
                              avatarUrl: 'assets/icons/user_profile.png',
                              message: 'Shipped very fast, great communication. Only wish the material was listed because I’m not sure I would have bought it',
                            ),
                            SellerProfileRefresh(
                              title: 'Jacob Jones',
                              time: '1 day ago',
                              avatarUrl: 'assets/icons/user_profile.png',
                              message: 'Shipped very fast, great communication. Only wish the material was listed because I’m not sure I would have bought it',
                            ),
                            SellerProfileRefresh(
                              title: 'Kristin Watson',
                              time: '2 days ago',
                              avatarUrl: 'assets/icons/user_profile.png',
                              message: 'Fast shipping! Thank you!!',
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 16.h,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
