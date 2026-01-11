import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/routes/route_names.dart';
import '../../data/model/home/category_based_product_model.dart';
import '../../view_model/bid/place_a_bid_provider.dart';
import '../../view_model/home_provider/favorite_icon_provider.dart';
import '../../view_model/language/language_provider.dart';
import '../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../view_model/whistlist/whistlist_provider_of_get_favourite_product.dart';
import '../../view_model/whistlist/wishlist_create.dart';

class CustomProductCard extends StatelessWidget {
  final ProductData product;

  const CustomProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final favoriteProvider = context.watch<FavoriteProvider>();

    final isLoading = product.title == null;
    final isEnglish = languageProvider.currentLang == 'en';

    final isFavorite =
        favoriteProvider.isFavorite(product.id) || product.isInWishlist;

    final displayTitle = _getDisplayText(
      product.title,
      product.translatedTitle,
      isEnglish,
      languageProvider.currentLang,
    );

    final displayCondition = _getDisplayText(
      product.condition,
      product.translatedCondition,
      isEnglish,
      languageProvider.currentLang,
    );

    final displaySize =
        product.size == null || product.size!.isEmpty
            ? null
            : _getDisplayText(
              product.size!,
              product.translatedSize,
              isEnglish,
              languageProvider.currentLang,
            );

    return GestureDetector(
      onTap: () => _onProductTap(context),
      child: SizedBox(
        width: 220.w,
        child: Card(
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    _buildProductImage(isLoading),
                    if (!isLoading) _buildFavoriteButton(context, isFavorite),
                  ],
                ),
                SizedBox(height: 8.h),
                if (isLoading)
                  _buildShimmerItems()
                else
                  _buildProductDetails(
                    languageProvider,
                    displayTitle!,
                    displayCondition!,
                    displaySize,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= FAVORITE =================

  Widget _buildFavoriteButton(BuildContext context, bool isFavorite) {
    return Positioned(
      top: 8.w,
      left: 8.w,
      child: GestureDetector(
        onTap: () => _onFavoriteTap(context, isFavorite),
        child: Container(
          height: 36.h,
          width: 36.w,
          padding: EdgeInsets.all(4.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffC7C8C8),
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.white,
            size: 20.h,
          ),
        ),
      ),
    );
  }

  Future<void> _onFavoriteTap(BuildContext context, bool wasFavorite) async {
    final favoriteProvider = context.read<FavoriteProvider>();
    final wishlist = context.read<WishlistCreate>();

    // Optimistic UI
    favoriteProvider.toggleFavorite(product.id, !wasFavorite);

    final result = await wishlist.createWishListProduct(product.id);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(wishlist.errorMessage)));

    if (!result) {
      favoriteProvider.toggleFavorite(product.id, wasFavorite);
      return;
    }

    //  Sync UI with actual backend result
    if (wishlist.lastAction == WishlistAction.added) {
      favoriteProvider.toggleFavorite(product.id, true);
    } else if (wishlist.lastAction == WishlistAction.removed) {
      favoriteProvider.toggleFavorite(product.id, false);
    }

    await context
        .read<WhistlistProviderOfGetFavouriteProduct>()
        .getWishlistProduct();
  }

  void _onProductTap(BuildContext context) {
    if (product.title == null) return;

    context.read<GetProductDetailsProvider>().getProductDetails(product.id);

    context.read<PlaceABidProvider>().getAllBidsForProduct(product.id);

    Navigator.pushNamed(context, RouteNames.productDetailsScreen);
  }

  // ================= IMAGE =================

  Widget _buildProductImage(bool isLoading) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 120.h,
        width: double.infinity,
        color: Colors.white,
        child: isLoading ? _buildShimmerBox(120, 39) : _buildActualImage(),
      ),
    );
  }

  Widget _buildActualImage() {
    if (product.photo == null || product.photo!.isEmpty) {
      return _buildPlaceholder();
    }

    return Image.network(
      _getImageUrl(product.photo!.first),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildPlaceholder(),
    );
  }

  // ================= DETAILS =================

  Widget _buildProductDetails(
    LanguageProvider languageProvider,
    String title,
    String condition,
    String? size,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4.h),
        Text(
          size != null
              ? '${languageProvider.translate('Size')} $size (${languageProvider.translate('Condition')}: $condition)'
              : '${languageProvider.translate('Condition')}: $condition',
          style: TextStyle(fontSize: 12.sp, color: const Color(0xff777980)),
        ),
        SizedBox(height: 4.h),
        _buildDateTexts(),
        Divider(color: Colors.grey.shade200, thickness: .7.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${product.price}',
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
    );
  }

  // ================= HELPERS =================

  Widget _buildDateTexts() {
    final widgets = <Widget>[];

    if (product.createdTime.isNotEmpty) {
      widgets.add(
        Text(
          _formatDate(product.createdTime),
          style: TextStyle(
            color: const Color(0xff777980),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (product.boostTimeLeft != null && product.boostTimeLeft!.isNotEmpty) {
      widgets.add(
        Text(
          _formatDate(product.boostTimeLeft!),
          style: TextStyle(
            color: const Color(0xff1A9882),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  String _formatDate(String date) {
    try {
      return DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(date));
    } catch (_) {
      return date;
    }
  }

  Widget _buildShimmerItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerBox(14.h, 200.w),
        SizedBox(height: 4.h),
        _buildShimmerBox(12.h, 200.w),
        SizedBox(height: 4.h),
        _buildShimmerBox(13.h, 200.w),
        Divider(color: Colors.grey.shade200, thickness: .7.h),
        _buildShimmerBox(18.h, 100.w),
      ],
    );
  }

  Widget _buildShimmerBox(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Image.asset('assets/images/placeholder.jpg', fit: BoxFit.fill),
    );
  }

  String _getImageUrl(String photoPath) {
    if (photoPath.startsWith('http')) return photoPath;
    if (photoPath.startsWith('/')) {
      return "${ApiEndpoints.baseUrl}$photoPath";
    }
    return "${ApiEndpoints.baseUrl}/$photoPath";
  }

  String _getDisplayText(
    String original,
    String? translated,
    bool isEnglish,
    String currentLang,
  ) {
    if (isEnglish ||
        translated == null ||
        translated.isEmpty ||
        translated == original) {
      return original;
    }
    return translated;
  }
}
