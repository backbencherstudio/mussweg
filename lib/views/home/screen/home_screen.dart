import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mussweg/data/model/home/category_based_product_model.dart';
import 'package:mussweg/data/model/home/category_model.dart';
import 'package:mussweg/view_model/home_provider/home_nav/electronic_category_based_provider.dart';
import 'package:mussweg/view_model/home_provider/home_nav/fashion_category_based_product_provider.dart';
import 'package:mussweg/view_model/home_provider/home_nav/home_category_based_provider.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/routes/route_names.dart';
import '../../../data/model/home/category_based_product_model.dart';
import '../../../view_model/auth/login/get_me_viewmodel.dart';
import '../../../view_model/home_provider/all_category_provider.dart';
import '../../../view_model/home_provider/home_screen_provider.dart';
import '../../../view_model/product_item_list_provider/category_based_product_provider.dart';
import '../../widgets/custom_product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<GetMeViewmodel>(context);
    final homScreenProvider = context.watch<HomeScreenProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFDFDFD),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.viewProfileScreen,
                        );
                      },
                      child: ClipOval(
                        child: userVM.user?.avatar != null
                            ? Image.network(
                          "${ApiEndpoints.imageBaseurl}/public/storage//avatar${userVM.user!.avatar!}",
                                fit: BoxFit.cover,
                                width: 50.w,
                                height: 50.h,
                              )
                            : Image.asset(
                                'assets/icons/myyyy.jpeg',
                                fit: BoxFit.cover,
                                width: 50.w,
                                height: 50.h,
                              ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${userVM.user?.name ?? 'Guest'}",
                          style: TextStyle(
                            color: const Color(0xffDE3526),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
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
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<ParentScreensProvider>().onSelectedIndex(
                          2,
                        );
                      },
                      child: Image.asset("assets/icons/cart.png", scale: 1.5),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.notifications_active),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),

                // Search bar
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.searchPage);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F0EE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          "Search Product Name & Suppliers",
                          style: TextStyle(color: Color(0xffA5A5AB)),
                        ),
                        Spacer(),
                        Icon(Icons.search, color: Color(0xffA5A5AB)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.categoryScreen);
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                Consumer<AllCategoryProvider>(
                  builder: (_, categoryProvider, __) {
                    return SizedBox(
                      height: 75.h,
                      child: ListView.builder(
                        itemCount:
                            categoryProvider.categoryModel?.data.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final feature =
                              categoryProvider.categoryModel?.data[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: SizedBox(
                              width: 56.w,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xffF2F1EF),
                                    ),
                                    child: Image.network(
                                      '${ApiEndpoints.imageBaseurl}${feature?.photo.replaceAll('http://localhost:5005', '')}',
                                      height: 45.h,
                                      width: 45.w,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) {
                                        return Icon(
                                          Icons.error,
                                          color: Colors.grey.shade400,
                                          size: 24.h,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    feature?.categoryName ?? '',
                                    style: TextStyle(
                                      color: const Color(0xff4A4C56),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                // Fashion Products Section
                _buildFashionProductSection("Fashion Products", context),

                // Home Accessories Section
                _buildHomeProductSection("Home Accessories",context),

                // Electronics Products Section
                _buildElectronicProductSection("Electronics Products",context),

                SizedBox(height: 90.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFashionProductSection(String title, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final provider = Provider.of<CategoryBasedProductProvider>(context, listen: false);
                final categoryProvider = Provider.of<AllCategoryProvider>(context, listen: false);

                provider.setCategoryTitle('Fashion');
                await provider.getCategoryBasedProduct(categoryProvider.fashionCategoryId);
                Navigator.pushNamed(context, RouteNames.productListScreen);
              },
              child: const Text("View All", style: TextStyle(color: Colors.red)),
            ),

          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 235.h,
          child: Consumer<FashionCategoryBasedProductProvider>(
            builder: (_, provider, __) {
              final products =
                  provider.categoryBasedProductModel?.data?.products ?? [];
              if (products.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.production_quantity_limits,
                        color: Colors.grey.shade400,
                        size: 40.h,
                      ),
                      Text(
                        "No Fashion Products Found",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CustomProductCard(product: product);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomeProductSection(String title,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final provider = Provider.of<CategoryBasedProductProvider>(context, listen: false);
                final categoryProvider = Provider.of<AllCategoryProvider>(context, listen: false);

                provider.setCategoryTitle('Home');
                await provider.getCategoryBasedProduct(categoryProvider.homeCategoryId);
                Navigator.pushNamed(context, RouteNames.productListScreen);
              },
              child: const Text("View All", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 235.h,
          child: Consumer<HomeCategoryBasedProvider>(
            builder: (_, provider, __) {
              final products =
                  provider.categoryBasedProductModel?.data?.products ?? [];
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CustomProductCard(product: product);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildElectronicProductSection(String title,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final provider = Provider.of<CategoryBasedProductProvider>(context, listen: false);
                final categoryProvider = Provider.of<AllCategoryProvider>(context, listen: false);

                provider.setCategoryTitle('Electronic');
                await provider.getCategoryBasedProduct(categoryProvider.electronicsCategoryId);
                Navigator.pushNamed(context, RouteNames.productListScreen);
              },
              child: const Text("View All", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 235.h,
          child: Consumer<ElectronicCategoryBasedProvider>(
            builder: (_, provider, __) {
              final products =
                  provider.categoryBasedProductModel?.data?.products ?? [];
              if (products.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.production_quantity_limits,
                        color: Colors.grey.shade400,
                        size: 40.h,
                      ),
                      Text(
                        "No Electronic Products Found",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CustomProductCard(product: product);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
