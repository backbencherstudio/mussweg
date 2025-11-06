import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/boost_product/boost_product_create_provider.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:mussweg/views/profile/widgets/pickup_option_widget.dart';
import 'package:provider/provider.dart';
import '../../../view_model/bid/place_a_bid_provider.dart';
import '../../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../../view_model/profile/user_all_products/user_all_products_provider.dart';
import '../screens/view_profile/edit_product_page.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String productId;
  final String productName;
  final String price;
  final String productDate;
  final String productBoostTime;
  final bool isBoosted;

  const ProductCard({
    super.key,
    this.imageUrl,
    required this.productName,
    required this.price,
    this.isBoosted = false,
    required this.productId,
    required this.productDate,
    required this.productBoostTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GetProductDetailsProvider>().getProductDetails(productId);
        context.read<PlaceABidProvider>().getAllBidsForProduct(productId);
        Navigator.pushNamed(
          context,
          RouteNames.productDetailsScreen,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: imageUrl != null || imageUrl != '' ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        "${ApiEndpoints.baseUrl}${imageUrl?.replaceAll('http://localhost:5005', '')}",
                        height: 110.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 110.h,
                          color: Colors.grey[300],
                          child: Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ) : Container(
                      height: 110.h,
                      color: Colors.grey[300],
                      child: Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60.h,
                  right: 10.w,
                  child: PopupMenuButton<String>(
                    icon: Image.asset(
                      'assets/icons/more_options.png',
                      scale: 1.8,
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        context.read<GetProductDetailsProvider>().getProductDetails(productId);
                        context.read<PlaceABidProvider>().getAllBidsForProduct(productId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductPage(),
                          ),
                        );
                      } else if (value == 'boost_products') {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text("Boost Products"),
                              content: const Text(
                                "Do you want to boost this product?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text("Cancel"),
                                ),
                                Consumer<BoostProductCreateProvider>(
                                  builder: (_, boostProductCreateProvider, __) {
                                    return ElevatedButton(
                                      onPressed:
                                          boostProductCreateProvider.isLoading
                                          ? null
                                          : () async {
                                              bool success =
                                                  await boostProductCreateProvider
                                                      .createBoostProduct(
                                                        productId,
                                                      );

                                              if (success) {
                                                Navigator.pop(ctx);

                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "Product Boosted Successfully",
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      boostProductCreateProvider
                                                              .errorMessage
                                                              .isNotEmpty
                                                          ? boostProductCreateProvider
                                                                .errorMessage
                                                          : "Failed to boost product",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                      child: boostProductCreateProvider.isLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text("Boost"),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Delete Product"),
                            content: const Text(
                              "Are you sure you want to delete this product?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Product Deleted"),
                                    ),
                                  );
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'boost_products',
                            child: Text('Boost Products'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                  ),
                ),
                if (isBoosted)
                  Positioned(
                    top: 10.h,
                    left: 18.w,
                    child: Image.asset('assets/icons/boost.png', scale: 1.8),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Color(0xff4A4C56),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    productDate,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777980),
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    productBoostTime,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1A9882),
                    ),
                  ),
                  Divider(color: Color(0xffE9E9EA)),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: Color(0xffDE3526),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Spacer(),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.boostProductPage,
                          );
                        },
                        child: SizedBox(
                          height: 30.w,
                          width: 70.w,
                          child: PrimaryButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: PickupOptionWidget(),
                                  );
                                },
                              );
                            },
                            title: 'Muss Weg',
                            textSize: 12.sp,
                            color: Colors.red,
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
  }
}
