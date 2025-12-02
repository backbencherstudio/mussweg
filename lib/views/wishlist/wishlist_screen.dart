// lib/views/screens/wishlist_screen.dart
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
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Initial load
    Future.microtask(() {
      final provider = context.read<WhistlistProviderOfGetFavouriteProduct>();
      final languageProvider = context.read<LanguageProvider>();

      // Sync language with provider
      provider.changeLanguage(languageProvider.currentLang);

      // Load wishlist
      provider.getWishlistProduct();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (!context.read<WhistlistProviderOfGetFavouriteProduct>().isPaginationLoading) {
        context.read<WhistlistProviderOfGetFavouriteProduct>().loadMoreWishlistProduct();
      }
    }
  }

  String _getTranslatedText(String text, BuildContext context) {
    final langCode = context.read<LanguageProvider>().currentLang;

    // Simple translation dictionary for UI texts
    final translations = {
      'en': {
        'Wishlist': 'Wishlist',
        'Favourite List': 'Favourite List',
        'No Favourite Product Found': 'No Favourite Product Found',
        'Size': 'Size',
        'condition': 'condition',

      },
      'de': {
        'Wishlist': 'Wunschliste',
        'Favourite List': 'Favoritenliste',
        'No Favourite Product Found': 'Kein Favoritenprodukt gefunden',
        'Size': 'Größe',
        'condition': 'Zustand',

      },
      'fr': {
        'Wishlist': 'Liste de souhaits',
        'Favourite List': 'Liste des favoris',
        'No Favourite Product Found': 'Aucun produit favori trouvé',
        'Size': 'Taille',
        'condition': 'état',

      },
      'bn': {
        'Wishlist': 'ইচ্ছেতালিকা',
        'Favourite List': 'প্রিয় তালিকা',
        'No Favourite Product Found': 'কোন প্রিয় পণ্য পাওয়া যায়নি',
        'Size': 'আকার',
        'condition': 'অবস্থা',

      },
    };

    return translations[langCode]?[text] ?? text;
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
          title: _getTranslatedText('Wishlist', context),
          onBack: () => context.read<ParentScreensProvider>().onSelectedIndex(0),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Selector
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_getTranslatedText('Language', context)}:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DropdownButton<String>(
                      value: languageProvider.currentLang,
                      underline: const SizedBox(),
                      icon: Icon(Icons.arrow_drop_down, size: 24.w),
                      items: [
                        DropdownMenuItem(
                          value: "en",
                          child: Text(_getTranslatedText('English', context)),
                        ),
                        DropdownMenuItem(
                          value: "de",
                          child: Text(_getTranslatedText('German', context)),
                        ),
                        DropdownMenuItem(
                          value: "fr",
                          child: Text(_getTranslatedText('French', context)),
                        ),
                        DropdownMenuItem(
                          value: "bn",
                          child: Text(_getTranslatedText('Bangla', context)),
                        ),
                      ],
                      onChanged: (value) async {
                        if (value == null) return;

                        // Show loading indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                        try {
                          // Change language
                          await languageProvider.changeLanguage(value);

                          // Update wishlist provider language
                          await wishlistProvider.changeLanguage(value);

                          // Reload wishlist with new language
                          await wishlistProvider.getWishlistProduct();
                        } finally {
                          // Hide loading indicator
                          if (mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Title
              Text(
                _getTranslatedText('Favourite List', context),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16.h),

              // Wishlist Items
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await wishlistProvider.getWishlistProduct();
                  },
                  child: _buildWishlistContent(context, wishlistProvider),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWishlistContent(BuildContext context, WhistlistProviderOfGetFavouriteProduct provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.isTranslating) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text(
            'Translating content...',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        ],
      );
    }

    final favouriteProduct = provider.wishlistModel?.data;

    if (favouriteProduct?.isEmpty ?? true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64.w, color: Colors.grey[300]),
            SizedBox(height: 16.h),
            Text(
              _getTranslatedText('No Favourite Product Found', context),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: favouriteProduct!.length + (provider.isPaginationLoading ? 1 : 0),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        // Loading indicator for pagination
        if (index == favouriteProduct.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final product = favouriteProduct[index];

        return _buildProductCard(context, product);
      },
    );
  }

  Widget _buildProductCard(BuildContext context, WishlistItem product) {
    return GestureDetector(
      onTap: () {
        context.read<GetProductDetailsProvider>().getProductDetails(product.productId);
        context.read<PlaceABidProvider>().getAllBidsForProduct(product.productId);
        Navigator.pushNamed(context, RouteNames.productDetailsScreen);
      },
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
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  height: 180.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: product.productPhoto != null &&
                      product.productPhoto!.isNotEmpty
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
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 48.w,
                        color: Colors.grey[400],
                      ),
                    ),
                  )
                      : Center(
                    child: Icon(
                      Icons.image,
                      size: 48.w,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Product Title
              Text(
                product.translatedTitle ?? product.productTitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 8.h),

              // Product Details
              Row(
                children: [
                  Icon(Icons.straighten, size: 16.w, color: Colors.grey[600]),
                  SizedBox(width: 4.w),
                  Text(
                    '${_getTranslatedText('Size', context)}: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    product.translatedSize ?? product.productSize,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              Row(
                children: [
                  Icon(Icons.assignment_turned_in_outlined, size: 16.w, color: Colors.grey[600]),
                  SizedBox(width: 4.w),
                  Text(
                    '${_getTranslatedText('condition', context)}: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    product.translatedCondition ?? product.productCondition,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // Price and Stock
              Row(
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

                  if (product.productStock > 0)
                    Container(
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