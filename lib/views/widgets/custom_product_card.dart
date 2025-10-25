import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:provider/provider.dart';
import '../../data/model/home/category_based_product_model.dart';
import '../../view_model/home_provider/favorite_icon_provider.dart';

class CustomProductCard extends StatelessWidget {
  final ProductData product;

  const CustomProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return SizedBox(
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
                      child:
                          (product.photo != null && product.photo!.isNotEmpty)
                          ? Image.network(
                              '${ApiEndpoints.baseUrl}${product.photo}',
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

                  Positioned(
                    top: 8.w,
                    left: 8.w,
                    child: GestureDetector(
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
              Text(
                product.title ?? '',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                "Size ${product.size ?? ''} (${product.condition ?? ''} Condition)",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xff777980),
                ),
              ),
              RichText(
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
              Row(
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
    );
  }
}
