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
    final isLoading = product.title == null;
    final isEnglish = languageProvider.currentLang == 'en';

    // Get display texts with proper fallback
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
                // Product Image with Favorite Button
                Stack(
                  children: [
                    _buildProductImage(isLoading),
                    if (!isLoading) _buildFavoriteButton(context),
                  ],
                ),
                SizedBox(height: 8.h),

                // Product Details
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

  // Helper Methods
  String _getDisplayText(
    String original,
    String? translated,
    bool isEnglish,
    String currentLang,
  ) {
    // If English or translation is null/empty, use original
    if (isEnglish ||
        translated == null ||
        translated.isEmpty ||
        translated == original) {
      return original;
    }

    // Check if translation is in a different language
    // This is a simple check - you might need a more sophisticated approach
    if (_isValidTranslation(translated)) {
      return translated;
    }

    return original;
  }

  bool _isValidTranslation(String text) {
    // Add logic to validate if text is a proper translation
    // This could check for common issues like:
    // - Translation equals original
    // - Translation is too short/long
    // - Contains placeholder text
    return text.isNotEmpty &&
        text.length >= 2 &&
        !text.contains('Error') &&
        !text.contains('null');
  }

  void _onProductTap(BuildContext context) {
    if (product.title == null) return;

    context.read<GetProductDetailsProvider>().getProductDetails(product.id);
    context.read<PlaceABidProvider>().getAllBidsForProduct(product.id);
    Navigator.pushNamed(context, RouteNames.productDetailsScreen);
  }

  Widget _buildProductImage(bool isLoading) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 120.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
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
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value:
                progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                    : null,
          ),
        );
      },
      errorBuilder: (_, __, ___) => _buildPlaceholder(),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return Positioned(
      top: 8.w,
      left: 8.w,
      child: GestureDetector(
        onTap: () => _onFavoriteTap(context),
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
              _isFavorite(context) ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite(context) ? Colors.red : Colors.white,
              size: 20.h,
            ),
          ),
        ),
      ),
    );
  }

  bool _isFavorite(BuildContext context) {
    return context.watch<FavoriteProvider>().isFavorite(product.id) ||
        product.isInWishlist;
  }

  Future<void> _onFavoriteTap(BuildContext context) async {
    final favoriteProvider = context.read<FavoriteProvider>();
    final wasFavorite = _isFavorite(context);

    favoriteProvider.toggleFavorite(product.id, !wasFavorite);

    final wishlistCreate = context.read<WishlistCreate>();
    final result = await wishlistCreate.createWishListProduct(product.id);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(wishlistCreate.errorMessage)));

    if (!result) {
      favoriteProvider.toggleFavorite(product.id, wasFavorite);
    } else {
      await context
          .read<WhistlistProviderOfGetFavouriteProduct>()
          .getWishlistProduct();
    }
  }

  Widget _buildProductDetails(
    LanguageProvider languageProvider,
    String title,
    String condition,
    String? size,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4.h),

        // Size & Condition
        Text(
          size != null
              ? '${languageProvider.translate('Size')} $size (${languageProvider.translate('Condition')}: $condition)'
              : '${languageProvider.translate('Condition')}: $condition',
          style: TextStyle(fontSize: 12.sp, color: const Color(0xff777980)),
        ),
        SizedBox(height: 4.h),

        // Dates
        _buildDateTexts(),
        Divider(color: Colors.grey.shade200, thickness: .7.h),

        // Price
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

  Widget _buildDateTexts() {
    final widgets = <Widget>[];

    if (product.createdTime.isNotEmpty) {
      try {
        final formatted = DateFormat(
          "dd MMM, yy h:mm a",
        ).format(DateTime.parse(product.createdTime));
        widgets.add(
          Text(
            formatted,
            style: TextStyle(
              color: const Color(0xff777980),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } catch (e) {
        widgets.add(
          Text(
            product.createdTime,
            style: TextStyle(
              color: const Color(0xff777980),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }
    }

    if (product.boostTimeLeft != null && product.boostTimeLeft!.isNotEmpty) {
      try {
        final formatted = DateFormat(
          "dd MMM, yy h:mm a",
        ).format(DateTime.parse(product.boostTimeLeft!));
        widgets.add(
          Text(
            formatted,
            style: TextStyle(
              color: const Color(0xff1A9882),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } catch (e) {
        widgets.add(
          Text(
            product.boostTimeLeft!,
            style: TextStyle(
              color: const Color(0xff1A9882),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
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
    if (photoPath.startsWith('/')) return "${ApiEndpoints.baseUrl}$photoPath";
    return "${ApiEndpoints.baseUrl}/$photoPath";
  }
}
