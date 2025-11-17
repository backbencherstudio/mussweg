import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/routes/route_names.dart';
import '../../../view_model/bid/place_a_bid_provider.dart';
import '../../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../../view_model/search_history_provider/search_history.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<SearchProvider>().loadMoreProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:SimpleApppbar(title: 'Search'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 24),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final favouriteProduct = provider.searchProductModel?.data;

                  if (favouriteProduct?.isEmpty ?? true) {
                    return Center(child: Text('No Product Found'));
                  }

                  return ListView.separated(
                    controller: _scrollController, // Attach scroll controller
                    itemCount: favouriteProduct?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product = favouriteProduct![index];
                      return GestureDetector(
                        onTap: () {
                          context.read<GetProductDetailsProvider>().getProductDetails(product.id);
                          context.read<PlaceABidProvider>().getAllBidsForProduct(product.id);
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
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        child: Image.network(
                                          product.photo != null && product.photo!.isNotEmpty
                                              ? "${ApiEndpoints.baseUrl}${product.photo!.first.replaceAll('http://localhost:5005', '')}"
                                              : 'https://via.placeholder.com/150',
                                          fit: BoxFit.cover,
                                          height: 180.h,
                                          width: double.infinity,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
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
                                  ],
                                ),
                                Text(
                                  product.title ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Size ${product.size ?? ''} (${product.condition ?? ''} condition)',
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
                                        text: DateFormat(
                                          "dd MMM, yy h:mm a",
                                        ).format(DateTime.parse(product.createdTime)) ??
                                            '' ,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff777980),
                                        ),
                                      ),
                                      TextSpan(
                                        text: product.boostTime == '' ||
                                            product.boostTime == null
                                            ? '\n'
                                            : '\n${DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(product.boostTime ?? ''))}',
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
                                        '\$ ${product.price ?? ''}',
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
            Consumer<SearchProvider>(
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Products Here.....',
                hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 11.sp),
                border: InputBorder.none,
              ),
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  await context.read<SearchProvider>().getSearchProduct(value);
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () async {
              final query = _searchController.text.trim();
              if (query.isNotEmpty) {
                await context.read<SearchProvider>().getSearchProduct(query);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('Search', style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }
}