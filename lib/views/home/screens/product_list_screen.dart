import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/view_model/product_item_list_provider/category_based_product_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_names.dart';
import '../../../view_model/home_provider/home_nav/fashion_category_based_product_provider.dart';
import '../../../view_model/home_provider/home_nav/home_category_based_provider.dart';
import '../../profile/widgets/simple_apppbar.dart';
import 'filter_dopdown.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _categoryFilter = [
      {"title": "Filter"},
      {"title": "Latest products"},
      {"title": "Oldest Product"},
    ];

    return Scaffold(
      appBar: SimpleApppbar(title: '${context.watch<CategoryBasedProductProvider>().categoryTitle} Products'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CategoryBasedProductProvider>(
          builder: (context, provider, _) {
            final products = provider.categoryBasedProductModel?.data?.products ?? [];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categoryFilter.length,
                      itemBuilder: (context, index) {
                        final data = _categoryFilter[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffF1F0EE),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (data["title"] == "Filter") {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Dialog(
                                        backgroundColor: Colors.white,
                                        insetPadding: EdgeInsets.all(16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                        ),
                                        child: FilterPage(),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  if (data["title"] == "Filter")
                                    Image.asset("assets/icons/filter.png", height: 20.h),
                                  const SizedBox(width: 10),
                                  Text(
                                    data["title"],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Latest Products",
                    style: TextStyle(
                      color: const Color(0xff4A4C56),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (provider.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (products.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.production_quantity_limits,
                              color: Colors.grey.shade400, size: 40.h),
                          SizedBox(height: 5.h),
                          Text(
                            "No Fashion Products Found",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.builder(
                      itemCount: products.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final imageUrl = (product.photo != null && product.photo!.isNotEmpty)
                            ? "${ApiEndpoints.imageBaseurl}${product.photo}"
                            : null;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: imageUrl != null
                                          ? Image.network(
                                        imageUrl,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Image.asset(
                                          "assets/images/shirt.png",
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                          : Image.asset(
                                        "assets/images/shirt.png",
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffADA8A5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffADA8A5),
                                          shape: BoxShape.circle,
                                        ),
                                        child:  Icon(
                                         product.isInWishlist ? Icons.favorite : Icons.favorite_border,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.title ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff4A4C56)
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${product.price ?? ''}",
                                        style: const TextStyle(
                                          color: Color(0xffDE3526),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                       "Size ${product.size ?? 'Size not specified'}",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff777980),
                                        ),
                                      ), Text(
                                       " (${product.condition ?? 'Size not specified'} Condition)",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff777980),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,color: Color(0xff777980),),
                                      SizedBox(width: 3.w,),
                                      Text(
                                         "8 Km",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff777980),
                                        ),
                                      ),
                                      SizedBox(width: 8.w,),
                                      Icon(Icons.access_time_rounded,color: Color(0xff777980),),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        product.createdTime != null
                                            ? product.createdTime!
                                            : "Unknown Date",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff777980),
                                        ),
                                      ),
                                      SizedBox(width: 25.w,),
                                      Text(
                                        " ${product.boostTimeLeft ?? '(12h :12m :30s)'}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff1A9882),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(color: Colors.red),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteNames.productDetailsBidScreens,
                                            arguments: product,
                                          );
                                        },
                                        child: const Text(
                                          "Bid Now",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 13.w),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          side: const BorderSide(color: Colors.red),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteNames.productDetailsBuyScreens,
                                            arguments: product,
                                          );
                                        },
                                        child: const Text(
                                          "Buy Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}