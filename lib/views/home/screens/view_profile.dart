import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/client_dashboard/client_dashboard_details_provider.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/api_end_points.dart';
import '../../widgets/seller_profile_refresh.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ClientDashboardDetailsProvider>().fetchClientData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userVM =
        context
            .watch<ClientDashboardDetailsProvider>()
            .clientDashboardDetailsModel
            ?.data;

    return Scaffold(
      appBar: SimpleApppbar(title: 'View Profile'),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 180.h,
                width: double.infinity,
                child: userVM?.profile.coverPhotoUrl != null
                    ? Image.network(
                  "${ApiEndpoints.baseUrl}${userVM?.profile.coverPhotoUrl!.replaceAll('http://localhost:5005', '')}",
                  fit: BoxFit.cover,
                  width: 80.w,
                  height: 80.h,
                  loadingBuilder: (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                      ) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value:
                        loadingProgress.expectedTotalBytes !=
                            null
                            ? loadingProgress
                            .cumulativeBytesLoaded /
                            loadingProgress
                                .expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 180.h,
                      ),
                    );
                  },
                )
                    : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/placeholder.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180.h,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Transform.translate(
                  offset: Offset(0, -40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child:
                          userVM?.profile.avatarUrl != null
                              ? Image.network(
                                "${ApiEndpoints.baseUrl}${userVM?.profile.avatarUrl!.replaceAll('http://localhost:5005', '')}",
                                fit: BoxFit.cover,
                                width: 80.w,
                                height: 80.h,
                                loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/icons/user.png',
                                      fit: BoxFit.cover,
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  );
                                },
                              )
                              : Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/icons/user.png',
                                  fit: BoxFit.cover,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userVM?.profile.name ?? 'Guest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 4),
                        Text(userVM?.profile.rating.toString() ?? '', style: TextStyle(fontSize: 14)),
                        SizedBox(width: 6),
                        Text(
                          "(${userVM?.profile.reviewCount} Reviews)",
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 12.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/location-04.svg'),
                        SizedBox(width: 4),
                        Text(
                          userVM?.profile.address == null || userVM?.profile.city == null ? 'unknown' : '${userVM?.profile.address}, ${userVM?.profile.city}',
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
                      tabs: [Tab(text: 'Closet'), Tab(text: 'Reviews')],
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.w,
                                mainAxisSpacing: 8.w,
                                childAspectRatio: .68,
                              ),
                          itemCount: userVM?.products.data.length ?? 0,
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
                                    (userVM?.products.data[index].photoUrls.isNotEmpty ?? false)
                                        ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        "${ApiEndpoints.baseUrl}${userVM!.products.data[index].photoUrls.first.replaceAll('http://localhost:5005', '')}",
                                        height: 110.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return SizedBox(
                                            height: 110.h,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder: (_, __, ___) => Container(
                                          height: 110.h,
                                          color: Colors.grey[300],
                                          child: Image.asset(
                                            'assets/images/placeholder.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                        : Container(
                                      height: 110.h,
                                      color: Colors.grey[300],
                                      child: Image.asset(
                                        'assets/images/placeholder.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      userVM?.products.data[index].productTitle ?? '',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    Divider(
                                      color: Colors.grey.shade200,
                                      thickness: .9.h,
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
                                            '\$${userVM?.products.data[index].price}',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/icons/cart.png',
                                            color: Colors.red,
                                            height: 20.w,
                                            width: 20.w,
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
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: userVM?.reviews.data.length ?? 0,
                          itemBuilder: (context, index) {
                            return SellerProfileRefresh(
                              title: userVM?.reviews.data[index].reviewerName ?? '',
                              time: userVM?.reviews.data[index].createdAgo ?? '',
                              avatarUrl: userVM?.reviews.data[index].reviewerAvatar ?? '',
                              message: userVM?.reviews.data[index].comment ?? '',
                              starCount: userVM?.reviews.data[index].rating ?? 0,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
