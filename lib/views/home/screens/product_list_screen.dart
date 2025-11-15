import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/view_model/product_item_list_provider/category_based_product_provider.dart';
import 'package:mussweg/view_model/product_item_list_provider/get_product_details_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_names.dart';
import '../../../view_model/bid/place_a_bid_provider.dart';
import '../../../view_model/whistlist/whistlist_provider_of_get_favourite_product.dart';
import '../../../view_model/whistlist/wishlist_create.dart';
import '../../profile/widgets/simple_apppbar.dart';
import 'filter_dopdown.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String selectedFilter = "Latest products";
  late ScrollController _scrollController;

  final List<Map<String, dynamic>> _categoryFilter = [
    {"title": "Filter"},
    {"title": "Latest products"},
    {"title": "Oldest Product"},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context
          .read<CategoryBasedProductProvider>()
          .getCategoryBasedProduct();
    });
  }

  // Detect when scrolled to bottom and load more
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final provider = context.read<CategoryBasedProductProvider>();
      if (!provider.isPaginationLoading && provider.hasNextPage) {
        provider.loadMoreCategoryBasedProduct();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryBasedProductProvider>();

    return Scaffold(
      appBar: SimpleApppbar(
        title: '${categoryProvider.categoryTitle} Products',
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: RefreshIndicator(
          onRefresh: () => categoryProvider.getCategoryBasedProduct(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top filter buttons
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryFilter.length,
                  itemBuilder: (context, index) {
                    final data = _categoryFilter[index];
                    final isSelected = selectedFilter == data["title"];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: FilterPage(),
                                );
                              },
                            );
                          } else {
                            setState(() {
                              selectedFilter = data["title"];
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: isSelected
                                ? const Color(0xffDE3526)
                                : const Color(0xffF1F0EE),
                          ),
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
                                  color: isSelected ? Colors.white : Colors.black,
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

              SizedBox(height: 10.h),

              Text(
                selectedFilter,
                style: TextStyle(
                  color: const Color(0xff4A4C56),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),

              // Main product list
              Expanded(
                child: Consumer<CategoryBasedProductProvider>(
                  builder: (context, provider, _) {
                    final products = provider.categoryBasedProductModel?.data ?? [];

                    final displayedProducts = selectedFilter == "Oldest Product"
                        ? products.reversed.toList()
                        : products;

                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (displayedProducts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/noItem.png', height: 200.h, fit: BoxFit.fitHeight,),
                            SizedBox(height: 8.h),
                            Text(
                              "No Products Found",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "You don't have any active listing yet. Create your\nfirst listing to get started!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      controller: _scrollController,
                      itemCount: displayedProducts.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final product = displayedProducts[index];
                        final imageUrl = (product.photo != null && product.photo!.isNotEmpty)
                            ? "${ApiEndpoints.baseUrl}${product.photo?.first.replaceAll('http://localhost:5005', '')}"
                            : null;

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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.network(
                                        imageUrl ?? '',
                                        fit: BoxFit.cover,
                                        height: 180.h,
                                        width: double.infinity,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return SizedBox(
                                            height: 180.h,
                                            width: double.infinity,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
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
                                    Positioned(
                                      top: 8.w,
                                      left: 8.w,
                                      child: GestureDetector(
                                        onTap: () async {
                                          final result = await context
                                              .read<WishlistCreate>()
                                              .createWishListProduct(product.id);

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                context.read<WishlistCreate>().errorMessage,
                                              ),
                                            ),
                                          );

                                          if (result) {
                                            await context
                                                .read<WhistlistProviderOfGetFavouriteProduct>()
                                                .getWishlistProduct();
                                          }
                                        },
                                        child: Container(
                                          height: 36.h,
                                          width: 36.w,
                                          padding: EdgeInsets.all(4.w),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffC7C8C8),
                                          ),
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
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 4.h,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product.title,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            "\$${product.price}",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Size ${product.size} (${product.condition} Condition)",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff777980),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time_rounded,
                                              color: const Color(0xff777980), size: 16.h),
                                          SizedBox(width: 3.w),
                                          Text(
                                            DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(product.createdTime)),
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: const Color(0xff777980),
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            product.boostTimeLeft ?? '',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: const Color(0xff1A9882),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
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
                                                context.read<GetProductDetailsProvider>().getProductDetails(product.id);
                                                context.read<PlaceABidProvider>().getAllBidsForProduct(product.id);
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteNames.productDetailsScreen,
                                                );
                                              },
                                              child: const Text(
                                                "Bid Now",
                                                style: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {
                                                context.read<GetProductDetailsProvider>().getProductDetails(product.id);
                                                context.read<PlaceABidProvider>().getAllBidsForProduct(product.id);
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteNames.productDetailsScreen,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Pagination Loader
              Consumer<CategoryBasedProductProvider>(
                builder: (_, provider, __) {
                  if (provider.isPaginationLoading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
