// lib/views/screens/wishlist_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/constants/api_end_points.dart';
import '../../data/model/whistlist/favourite_product_model.dart';
import '../../view_model/language/language_provider.dart';
import '../../view_model/whistlist/whistlist_provider_of_get_favourite_product.dart';
import '../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../view_model/bid/place_a_bid_provider.dart';
import '../../core/routes/route_names.dart';
import '../../view_model/parent_provider/parent_screen_provider.dart';
import '../../views/widgets/simple_apppbar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _initializeScreen();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeScreen() {
    Future.microtask(() {
      final provider = context.read<WhistlistProviderOfGetFavouriteProduct>();
      final languageProvider = context.read<LanguageProvider>();

      // Sync language with provider
      provider.changeLanguage(languageProvider.currentLang);
      provider.getWishlistProduct();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final provider = context.read<WhistlistProviderOfGetFavouriteProduct>();
      if (!provider.isPaginationLoading) {
        provider.loadMoreWishlistProduct();
      }
    }
  }

  Future<void> _handleLanguageChange(String newLang) async {
    final languageProvider = context.read<LanguageProvider>();
    final wishlistProvider = context.read<WhistlistProviderOfGetFavouriteProduct>();

    if (languageProvider.currentLang == newLang) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(),
    );

    try {
      await languageProvider.changeLanguage(newLang);
      await wishlistProvider.changeLanguage(newLang);
      await wishlistProvider.getWishlistProduct();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(languageProvider.translate('Failed to change language')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _onProductTap(WishlistItem product) {
    context.read<GetProductDetailsProvider>().getProductDetails(product.productId);
    context.read<PlaceABidProvider>().getAllBidsForProduct(product.productId);
    Navigator.pushNamed(context, RouteNames.productDetailsScreen);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final wishlistProvider = context.watch<WhistlistProviderOfGetFavouriteProduct>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(
          title: languageProvider.translate('Wishlist'),
          onBack: () => context.read<ParentScreensProvider>().onSelectedIndex(0),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLanguageSelector(languageProvider),
              SizedBox(height: 20.h),
              _buildTitle(languageProvider),
              SizedBox(height: 16.h),
              _buildWishlistContent(wishlistProvider, languageProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(LanguageProvider languageProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.language, size: 20.w, color: Colors.grey[700]),
              SizedBox(width: 8.w),
              Text(
                languageProvider.translate('Language'),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: DropdownButton<String>(
              value: languageProvider.currentLang,
              underline: const SizedBox(),
              icon: Icon(Icons.arrow_drop_down, size: 24.w, color: Colors.grey[700]),
              dropdownColor: Colors.white,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
              items: _buildLanguageDropdownItems(languageProvider),
              onChanged: (value) {
                if (value != null) {
                  _handleLanguageChange(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildLanguageDropdownItems(
      LanguageProvider languageProvider,
      ) {
    return languageProvider.getSupportedLanguages().map((lang) {
      return DropdownMenuItem(
        value: lang['code'],
        child: Row(
          children: [
            Text(lang['flag']!),
            SizedBox(width: 8.w),
            Text(lang['name']!),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildTitle(LanguageProvider languageProvider) {
    return Text(
      languageProvider.translate('Favourite List'),
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildWishlistContent(
      WhistlistProviderOfGetFavouriteProduct provider,
      LanguageProvider languageProvider,
      ) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => provider.getWishlistProduct(),
        child: _buildWishlistBody(provider, languageProvider),
      ),
    );
  }

  Widget _buildWishlistBody(
      WhistlistProviderOfGetFavouriteProduct provider,
      LanguageProvider languageProvider,
      ) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.isTranslating) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: 16.h),
            Text(
              languageProvider.translate('Translating content...'),
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final favouriteProduct = provider.wishlistModel?.data;

    if (favouriteProduct?.isEmpty ?? true) {
      return _buildEmptyState(languageProvider);
    }

    return _buildWishlistList(provider, favouriteProduct!, languageProvider);
  }

  Widget _buildEmptyState(LanguageProvider languageProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80.w, color: Colors.grey[300]),
          SizedBox(height: 24.h),
          Text(
            languageProvider.translate('No Favourite Product Found'),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Add products to your wishlist to see them here',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistList(
      WhistlistProviderOfGetFavouriteProduct provider,
      List<WishlistItem> favouriteProduct,
      LanguageProvider languageProvider,
      ) {
    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: favouriteProduct.length + (provider.isPaginationLoading ? 1 : 0),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        if (index == favouriteProduct.length) {
          return _buildLoadingIndicator();
        }

        final product = favouriteProduct[index];
        return WishlistItemCard(
          product: product,
          onTap: () => _onProductTap(product),
          languageProvider: languageProvider,
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              SizedBox(height: 16.h),
              Text(
                'Changing language...',
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WishlistItemCard extends StatelessWidget {
  final WishlistItem product;
  final VoidCallback onTap;
  final LanguageProvider languageProvider;

  const WishlistItemCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.languageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              SizedBox(height: 12.h),
              _buildProductTitle(),
              SizedBox(height: 8.h),
              _buildProductDetails(),
              SizedBox(height: 8.h),
              _buildPriceAndStock(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: product.productPhoto != null && product.productPhoto!.isNotEmpty
            ? Image.network(
          "${ApiEndpoints.baseUrl}${product.productPhoto!.first.replaceAll('http://localhost:5005', '')}",
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (_, __, ___) => _buildPlaceholderIcon(),
        )
            : _buildPlaceholderIcon(),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Center(
      child: Icon(
        product.productPhoto?.isNotEmpty ?? false
            ? Icons.image_not_supported
            : Icons.image,
        size: 48.w,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildProductTitle() {
    return Text(
      product.translatedTitle ?? product.productTitle,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          icon: Icons.straighten,
          label: languageProvider.translate('Size'),
          value: product.translatedSize ?? product.productSize,
        ),
        SizedBox(height: 4.h),
        _buildDetailRow(
          icon: Icons.assignment_turned_in_outlined,
          label: languageProvider.translate('condition'),
          value: product.translatedCondition ?? product.productCondition,
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16.w, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndStock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (product.productPrice.isNotEmpty)
          Text(
            '\$${product.productPrice}',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
        if (product.productStock > 0) _buildStockIndicator(),
      ],
    );
  }

  Widget _buildStockIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Text(
        '${product.productStock} in stock',
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.green[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}