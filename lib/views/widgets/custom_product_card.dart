import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/routes/route_names.dart';
import '../../data/model/home/category_based_product_model.dart';
import '../../view_model/home_provider/favorite_icon_provider.dart';
import '../../view_model/product_item_list_provider/get_product_details_provider.dart';

class CustomProductCard extends StatelessWidget {
  final ProductData product;

  const CustomProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    // Check if the product data is still loading
    bool isLoading = product.title == null; // Assuming title is a required field for validation

    return GestureDetector(
      onTap: () {
        context.read<GetProductDetailsProvider>().getProductDetails(product.id);
        Navigator.pushNamed(
          context,
          RouteNames.productDetailsScreen,
        );
      },
      child: SizedBox(
        width: 220.w,
        child: Card(
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: isLoading
                        // Shimmer effect applied here for image
                            ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 120.h,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                          ),
                        )
                            : (product.photo != null && product.photo!.isNotEmpty)
                            ? Image.network(
                          '${ApiEndpoints.baseUrl}${product.photo?.replaceAll('http://localhost:5005', '')}',
                          fit: BoxFit.cover,
                          height: 120.h,
                          width: double.infinity,
                          errorBuilder: (_, __, ___) => Container(
                            height: 120.h,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: Image.asset(
                              'assets/images/placeholder.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                            : Container(
                          height: 120.h,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    // Favorite button with redacted effect for loading
                    Positioned(
                      top: 8.w,
                      left: 8.w,
                      child: isLoading
                          ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 36.h,
                          width: 36.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
                          favoriteProvider.toggleFavorite();
                        },
                        child: Container(
                          height: 36.h,
                          width: 36.w,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffC7C8C8),
                          ),
                          child: Center(
                            child: Icon(
                              product.isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: product.isInWishlist
                                  ? Colors.red
                                  : Colors.white,
                              size: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Title text with shimmer effect for loading
                isLoading
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 14.h,
                    width: 200.w,
                    color: Colors.grey.shade200,
                  ),
                )
                    : Text(
                  product.title ?? '',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                ),
                // Size/Condition Text with shimmer effect for loading
                isLoading
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 12.h,
                    width: 200.w,
                    color: Colors.grey.shade200,
                  ),
                )
                    : Text(
                  "Size ${product.size ?? ''} (${product.condition ?? ''} Condition)",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xff777980),
                  ),
                ),
                // CreatedTime and BoostTime with shimmer effect for loading
                isLoading
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 13.h,
                    width: 200.w,
                    color: Colors.grey.shade200,
                  ),
                )
                    : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: product.createdTime ?? '',
                        style: TextStyle(
                          color: const Color(0xff777980),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: " ${product.boostTimeLeft ?? ''}",
                        style: TextStyle(
                          color: const Color(0xff1A9882),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade200, thickness: .7.h),
                // Price text with shimmer effect for loading
                isLoading
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 18.h,
                    width: 100.w,
                    color: Colors.grey.shade200,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price ?? ''}',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
