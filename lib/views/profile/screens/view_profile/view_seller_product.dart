import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/profile/user_all_products/user_all_products_provider.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/api_end_points.dart';
import '../../../../view_model/auth/login/get_me_viewmodel.dart';
import '../../../../view_model/auth/login/user_profile_get_me_provider.dart';
import '../../../../view_model/my_dashboard/my_dashboard_response_provider.dart';
import '../../../../view_model/profile/edit_image/edit_image.dart';
import '../../../widgets/seller_profile_refresh.dart';
import '../../widgets/product_card.dart';

class SellerProfilePage extends StatefulWidget {
  const SellerProfilePage({super.key});

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<MyDashboardResponseProvider>().fetchMyDashboardData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<GetMeViewmodel>(context);
    final userProfileDetails =
        context.watch<UserProfileGetMeProvider>().userProfileResponse?.data;
    final sellerVM = Provider.of<SellerProfileProvider>(context);
    final userProductVM = Provider.of<UserAllProductsProvider>(context);

    final myProfileDashboardDetails = context.watch<MyDashboardResponseProvider>().myDashboardResponseModel?.data;

    final reviews = context.watch<MyDashboardResponseProvider>().myDashboardResponseModel?.data.reviews;

    return Scaffold(
      appBar: SimpleApppbar(title: 'View Profile'),
      body: Column(
        children: [
          SizedBox(
            height: 300.h,
            child: Stack(
              children: [
                SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.w,
                        ),
                      ),
                      child: Image.network(
                        "${ApiEndpoints.baseUrl}/public/storage/coverPhoto/${userProfileDetails?.coverPhoto}",
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) {
                          return SizedBox(
                            width: double.infinity,
                            height: 180.h,
                            child: Image.asset('assets/images/placeholder.jpg'),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 120.h,
                  left: 16.w,
                  child: GestureDetector(
                    onTap: () async {
                      await sellerVM.pickProfileImage();
                      if (sellerVM.profileImage != null) {
                        final success = await sellerVM.uploadProfileImage();
                        if (success) {
                          await context.read<GetMeViewmodel>().fetchUserData();
                          await context
                              .read<UserProfileGetMeProvider>()
                              .getUserProfileDetails();
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? sellerVM.uploadMessage ??
                                        'Profile updated'
                                    : 'Upload failed',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 110.w,
                          height: 110.h,
                          child: ClipRRect(
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
                                "${ApiEndpoints.baseUrl}/public/storage/avatar/${userVM.user!.avatar!}",
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (_, __, ___) {
                                  return SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Image.asset('assets/icons/user.png'),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          right: 4.w,
                          bottom: 4.w,
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/add_image.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 140.h,
                  right: 16.w,
                  child: GestureDetector(
                    onTap: () async {
                      await sellerVM.pickCoverImage();
                      if (sellerVM.coverImage != null) {
                        final success = await sellerVM.uploadCoverImage();
                        if (success) {
                          await context.read<GetMeViewmodel>().fetchUserData();
                          await context
                              .read<UserProfileGetMeProvider>()
                              .getUserProfileDetails();
                        }
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? sellerVM.uploadMessage ??
                                        'Profile updated'
                                    : 'Upload failed',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 35.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                              width: 1.5.w,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Change Cover',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 190.h,
                  left: 160.w,
                  right: 16.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userVM.user?.name ?? 'Guest',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff4A4C56),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange.shade300,
                            size: 16.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            (myProfileDashboardDetails?.profile.rating ?? 0).toStringAsFixed(
                              1,
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff777980),
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            ' - ${myProfileDashboardDetails?.profile.reviewCount} Reviewers',
                            style: TextStyle(
                              color: const Color(0xff777980),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Image.asset("assets/icons/location.png"),
                          SizedBox(width: 7.w),
                          Text(
                            '${myProfileDashboardDetails?.profile.address}, ${myProfileDashboardDetails?.profile.city}',
                            style: TextStyle(
                              color: const Color(0xff777980),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 12.w,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 7.w),
                          Text(
                            myProfileDashboardDetails?.profile.totalEarning ?? '',
                            style: TextStyle(
                              color: const Color(0xff777980),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Icon(
                            Icons.assignment_outlined,
                            size: 12.w,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 7.w),
                          Text(
                            myProfileDashboardDetails?.profile.totalPenalties ?? '',
                            style: TextStyle(
                              color: const Color(0xff777980),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.red,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [Tab(text: 'Offers'), Tab(text: 'Reviews')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (userProductVM.userAllProductsViewmodel?.data !=
                              null)
                            Text(
                              userProductVM
                                          .userAllProductsViewmodel!
                                          .data
                                          .length >
                                      50
                                  ? '50+ products uploaded'
                                  : '${userProductVM.userAllProductsViewmodel?.data.length} products uploaded',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff4A4C56),
                              ),
                            ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.sellItemPage,
                              );
                            },
                            child: Container(
                              width: 80.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_box_outlined,
                                    color: Colors.white,
                                    size: 16.w,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Sell',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: Consumer<UserAllProductsProvider>(
                          builder: (_, provider, __) {
                            final userAllProducts =
                                provider.userAllProductsViewmodel?.data;
                            return GridView.builder(
                              itemCount: userAllProducts?.length ?? 0,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.w,
                                    mainAxisSpacing: 8.w,
                                    childAspectRatio: .7,
                                  ),
                              itemBuilder: (context, index) {
                                final image =
                                    (userAllProducts?[index]
                                                .productPhotoUrl
                                                ?.isNotEmpty ??
                                            false)
                                        ? userAllProducts![index]
                                            .productPhotoUrl!
                                            .first
                                        : null;
                                return ProductCard(
                                  imageUrl: image,
                                  productName:
                                      userAllProducts?[index].title ?? '',
                                  price: userAllProducts?[index].price ?? '',
                                  isBoosted:
                                      userAllProducts?[index].remainingTime !=
                                      null,
                                  productId: userAllProducts?[index].id ?? '',
                                  productDate:
                                      userAllProducts?[index].uploaded ?? '',
                                  productBoostTime:
                                      userAllProducts?[index].remainingTime ??
                                      '',
                                  productSize:
                                      userAllProducts?[index].size ?? '',
                                  condition:
                                      userAllProducts?[index].condition ?? '',
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: reviews?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    return SellerProfileRefresh(
                      title: reviews?.data[index].reviewerName ?? '',
                      time: reviews?.data[index].createdAgo ?? '',
                      avatarUrl: reviews?.data[index].reviewerAvatar ?? '',
                      message: reviews?.data[index].comment ?? '',
                      starCount: reviews?.data[index].rating ?? 0,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
