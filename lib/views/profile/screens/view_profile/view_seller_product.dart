import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/auth/login/get_me_viewmodel.dart';
import '../../../../view_model/parent_provider/parent_screen_provider.dart';
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
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<GetMeViewmodel>(context);
    return Scaffold(
      appBar: SimpleApppbar(title: 'View Profile'),
      body: Column(
        children: [
          SizedBox(
            height: 280.h,
            child: Stack(
              children: [
                SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/cover.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 120.h,
                  left: 16.w,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 120.w,
                        height: 120.h,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icons/myyyy.jpeg',
                            fit: BoxFit.cover,
                            width: 120.w,
                            height: 120.h,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4.w,
                        bottom: 4.w,
                        child: GestureDetector(
                          onTap: (){},
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/add_image.png',
                                fit: BoxFit.cover,
                                width: 120.w,
                                height: 120.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 120.h,
                  right: 16.w,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2,
                        ),
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
                        "${userVM.user?.name ?? 'Guest'}",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff4A4C56),
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
                            '5.0',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff777980),
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            ' 86 Reviewers',
                            style: TextStyle(
                                color: Color(0xff777980), fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Image.asset('assets/icons/location.png', scale: 1),
                          SizedBox(width: 6.w),
                          Text(
                            'Switzerland',
                            style: TextStyle(
                                color: Color(0xff777980), fontSize: 14.sp),
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
            tabs: const [
              Tab(text: 'Offers'),
              Tab(text: 'Reviews'),
            ],
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
                          Text(
                            '50+ products uploaded',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4A4C56),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.sellItemPage);
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
                                  Icon(Icons.add_box_outlined, color: Colors.white, size: 16.w),
                                  Text('Sell', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: GridView.builder(itemCount: 6,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                            crossAxisSpacing: 8.w,mainAxisSpacing: 8.w, childAspectRatio: .65
                            ),
                            itemBuilder: (context, index) {
                          return ProductCard(
                            imageUrl: 'assets/images/dress.png',
                            productName: 'Man Exclusive T-Shirt',
                            price: '\$20.00',
                            isBoosted: true,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const Center(child: Text('Reviews Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}