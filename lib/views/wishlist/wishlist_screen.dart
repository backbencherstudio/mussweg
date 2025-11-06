import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_names.dart';
import '../../view_model/bid/place_a_bid_provider.dart';
import '../../view_model/product_item_list_provider/category_based_product_provider.dart';
import '../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../view_model/whistlist/whistlist_provider_of_get_favourite_product.dart';

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
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll listener to detect when we reach the bottom
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Trigger loading more items when scrolled to the bottom
      context.read<WhistlistProviderOfGetFavouriteProduct>().loadMoreWishlistProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        context.read<ParentScreensProvider>().onSelectedIndex(0);
      },
      child: Scaffold(
        appBar: SimpleApppbar(
          title: 'Wishlist',
          onBack: () =>
              context.read<ParentScreensProvider>().onSelectedIndex(0),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: RefreshIndicator(
            onRefresh: () => context.read<WhistlistProviderOfGetFavouriteProduct>().getWishlistProduct(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favourite List",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: Consumer<WhistlistProviderOfGetFavouriteProduct>(
                    builder: (_, wishlistProvider, __) {
                      if (wishlistProvider.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final favouriteProduct = wishlistProvider.wishlistModel?.data;

                      if (favouriteProduct?.isEmpty ?? true) {
                        return Center(child: Text('No Favourite Product Found'));
                      }

                      return ListView.separated(
                        controller: _scrollController, // Attach scroll controller
                        itemCount: favouriteProduct?.length ?? 0,
                        itemBuilder: (context, index) {
                          final product = favouriteProduct![index];
                          return GestureDetector(
                            onTap: () {
                              context.read<GetProductDetailsProvider>().getProductDetails(product.productId);
                              context.read<PlaceABidProvider>().getAllBidsForProduct(product.productId);
                              Navigator.pushNamed(
                                context,
                                RouteNames.productDetailsScreen,
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 1,
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
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
                                            child: Image.network(
                                              product.productPhoto != null && product.productPhoto!.isNotEmpty
                                                  ? "${ApiEndpoints.baseUrl}${product.productPhoto!.first.replaceAll('http://localhost:5005', '')}"
                                                  : 'https://via.placeholder.com/150',
                                              fit: BoxFit.cover,
                                              height: 180.h,
                                              width: double.infinity,
                                              errorBuilder: (_, __, ___) => Container(
                                                height: 180.h,
                                                width: double.infinity,
                                                color: Colors.grey.shade50,
                                                child: Image.asset(
                                                  'assets/images/placeholder.jpg',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8.w,
                                          left: 8.w,
                                          child: Container(
                                            height: 36.h,
                                            width: 36.w,
                                            padding: EdgeInsets.all(4.w),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffC7C8C8),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 20.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      product?.productTitle ?? '',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Size ${product?.productSize ?? ''} (${product?.productCondition ?? ''} condition)',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff777980),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${product?.createdAt ?? ''}  " ,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff777980),
                                            ),
                                          ),
                                          TextSpan(
                                            text: product?.boostTime ?? '',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff1A9882),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey.shade200,
                                      thickness: .7.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$ ${product?.productPrice ?? ''}',
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 8.h),
                      );
                    },
                  ),
                ),
                // Display loading indicator at the bottom when loading more data
                Consumer<WhistlistProviderOfGetFavouriteProduct>(
                  builder: (_, wishlistProvider, __) {
                    if (wishlistProvider.isPaginationLoading) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 75.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
