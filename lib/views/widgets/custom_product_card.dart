import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/routes/route_names.dart';
import '../../data/model/home/category_based_product_model.dart';
import '../../view_model/bid/place_a_bid_provider.dart';
import '../../view_model/home_provider/favorite_icon_provider.dart';
import '../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../view_model/whistlist/whistlist_provider_of_get_favourite_product.dart';
import '../../view_model/whistlist/wishlist_create.dart';

class CustomProductCard extends StatelessWidget {
  final ProductData product;

  const CustomProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isLoading = product.title == null;

    return GestureDetector(
      onTap: () {
        context.read<GetProductDetailsProvider>().getProductDetails(product.id);
        context.read<PlaceABidProvider>().getAllBidsForProduct(product.id);
        Navigator.pushNamed(context, RouteNames.productDetailsScreen);
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
                        child:
                            isLoading
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
                                : (product.photo != null &&
                                    product.photo!.isNotEmpty)
                                ? Image.network(
                                  '${ApiEndpoints.baseUrl}${product.photo?.first.replaceAll('http://localhost:5005', '')}',
                                  fit: BoxFit.cover,
                                  height: 120.h,
                                  width: double.infinity,
                                  loadingBuilder: (
                                    BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return SizedBox(
                                      height: 120.h,
                                      width: double.infinity,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder:
                                      (_, __, ___) => Container(
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
                      child:
                          isLoading
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
                                onTap: () async {
                                  final provider = context.read<FavoriteProvider>();

                                  provider.toggleFavorite(product.id, !provider.isFavorite(product.id));

                                  final result = await context.read<WishlistCreate>().createWishListProduct(product.id);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(context.read<WishlistCreate>().errorMessage),
                                    ),
                                  );

                                  if (!result) {
                                    provider.toggleFavorite(product.id, !provider.isFavorite(product.id));
                                  } else {
                                    await context.read<WhistlistProviderOfGetFavouriteProduct>().getWishlistProduct();
                                  }
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
                                      context.watch<FavoriteProvider>().isFavorite(product.id) || product.isInWishlist

                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                      context.watch<FavoriteProvider>().isFavorite(product.id) || product.isInWishlist
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
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
                            text:
                                DateFormat(
                                  "dd MMM, yy h:mm a",
                                ).format(DateTime.parse(product.createdTime)) ??
                                '',
                            style: TextStyle(
                              color: const Color(0xff777980),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text:
                                product.boostTimeLeft == '' ||
                                        product.boostTimeLeft == null
                                    ? '\n'
                                    : '\n${DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(product.boostTimeLeft ?? ''))}',
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
