import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'edit_product_page.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final bool isBoosted;
  final bool showBoostBottom;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.isBoosted = false,
    this.showBoostBottom = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: SizedBox(
            height: 250.h, // increased card height
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 150.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.r),
                            ),
                            child: Image.asset(
                              imageUrl,
                              height: 110.h, // increased image height for taller card
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 68.h,
                        right: 8.w,
                        child: PopupMenuButton<String>(
                          icon: Image.asset(
                            'assets/icons/more_option.png',
                            scale: 2,
                          ),
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProductPage(),
                                ),
                              );
                            } else if (value == 'delete') {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Delete Product"),
                                  content: const Text(
                                      "Are you sure you want to delete this product?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Product Deleted")),
                                        );
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                      if (isBoosted)
                        Positioned(
                          top: 10.h,
                          left: 18.w,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RouteNames.boostProductPage);
                            },
                            child: Image.asset('assets/icons/boost.png', scale: 2),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Color(0xff4A4C56),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Text(
                              'Size XL',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff777980),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '(New Condition)',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff777980),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Text(
                              'Aug 6,13:55',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff777980),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '(12h:12m:30s)',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1A9882),
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Color(0xffE9E9EA)),
                        Row(
                          children: [
                            Text(
                              price,
                              style: TextStyle(
                                color: Color(0xffDE3526),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            if (showBoostBottom)
                              Image.asset(
                                'assets/icons/boost_product.png',
                                scale: 3.2,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }
}

class SellerProfilePage extends StatefulWidget {
  const SellerProfilePage({Key? key}) : super(key: key);

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
                  child: SizedBox(
                    width: 120.w,
                    height: 120.h,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/user_profile.png',
                        fit: BoxFit.cover,
                        width: 120.w,
                        height: 120.h,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 120.h,
                  right: 16.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
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
                          borderRadius: BorderRadius.circular(20.r),
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
                Positioned(
                  top: 190.h,
                  left: 160.w,
                  right: 16.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cameron Williamson',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff4A4C56),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
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
            tabs: const [
              Tab(text: 'Closet'),
              Tab(text: 'Reviews'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
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
                            child: Image.asset(
                              'assets/icons/sell_items.png',
                              scale: 3,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 8.h,
                          childAspectRatio: 0.7,
                          children: const [
                            ProductCard(
                              imageUrl: 'assets/images/dress.png',
                              productName: 'Man Exclusive T-Shirt',
                              price: '\$20.00',
                              isBoosted: true,
                            ),
                            ProductCard(
                              imageUrl: 'assets/images/dress.png',
                              productName: 'Man Exclusive T-Shirt',
                              price: '\$20.00',
                              isBoosted: true,
                            ),
                            ProductCard(
                              imageUrl: 'assets/images/dress.png',
                              productName: 'Man Exclusive T-Shirt',
                              price: '\$20.00',
                              showBoostBottom: true,
                            ),
                            ProductCard(
                              imageUrl: 'assets/images/dress.png',
                              productName: 'Man Exclusive T-Shirt',
                              price: '\$20.00',
                              showBoostBottom: true,
                            ),
                          ],
                        ),
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
