// lib/views/widgets/product_card.dart
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/boost_product/boost_product_create_provider.dart';
import 'package:mussweg/view_model/mussweg/mussweg_product_screen_provider.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:provider/provider.dart';
import '../../../view_model/bid/place_a_bid_provider.dart';
import '../../../view_model/language/language_provider.dart';
import '../../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../screens/view_profile/edit_product_page.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String productId;
  final String productName;
  final String price;
  final String productDate;
  final String productSize;
  final String condition;
  final String productBoostTime;
  final bool isBoosted;
  final LanguageProvider? languageProvider;

  const ProductCard({
    super.key,
    this.imageUrl,
    required this.productName,
    required this.price,
    this.isBoosted = false,
    required this.productId,
    required this.productDate,
    required this.productBoostTime,
    required this.productSize,
    required this.condition,
    this.languageProvider,
  });

  @override
  Widget build(BuildContext context) {
    final langProvider = languageProvider ?? context.read<LanguageProvider>();

    return GestureDetector(
      onTap: () {
        context.read<GetProductDetailsProvider>().getProductDetails(productId);
        context.read<PlaceABidProvider>().getAllBidsForProduct(productId);
        Navigator.pushNamed(context, RouteNames.productDetailsScreen);
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
                    child: imageUrl != null && imageUrl!.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        "${ApiEndpoints.baseUrl}${imageUrl?.replaceAll('http://localhost:5005', '')}",
                        height: 110.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            height: 110.h,
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
                          height: 110.h,
                          color: Colors.grey[300],
                          child: Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                        : Container(
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
                        context.read<BoostProductCreateProvider>().setProductId(productId);
                        context.read<BoostProductCreateProvider>().setImage(imageUrl ?? '');
                        context.read<BoostProductCreateProvider>().setTitle(productName);
                        context.read<BoostProductCreateProvider>().setSize(productSize);
                        context.read<BoostProductCreateProvider>().setCondition(condition);
                        context.read<BoostProductCreateProvider>().setPrice(price);
                        context.read<BoostProductCreateProvider>().setTime(productDate);
                        context.read<BoostProductCreateProvider>().setBoostTime(productBoostTime);
                        Navigator.pushNamed(context, RouteNames.boostProductPage);
                      } else if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(langProvider.translate('Delete Product')),
                            content: Text(langProvider.translate('Are you sure you want to delete this product?')),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text(langProvider.translate('Cancel')),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(langProvider.translate('Product Deleted')),
                                    ),
                                  );
                                },
                                child: Text(langProvider.translate('Delete')),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Text(langProvider.translate('Edit')),
                      ),
                      PopupMenuItem<String>(
                        value: 'boost_products',
                        child: Text(langProvider.translate('Boost')),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(langProvider.translate('Delete')),
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
                      color: const Color(0xff4A4C56),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(productDate)),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff777980),
                    ),
                  ),
                  SizedBox(height: 5.w),
                  if (productBoostTime.isNotEmpty)
                    Text(
                      DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(productBoostTime)),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff1A9882),
                      ),
                    ),
                  Divider(color: const Color(0xffE9E9EA)),
                  Row(
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyle(
                          color: const Color(0xffDE3526),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30.w,
                        width: 70.w,
                        child: PrimaryButton(
                          onTap: () {
                            context.read<MusswegProductScreenProvider>().setProductId(productId);
                            Navigator.pushNamed(context, RouteNames.musswegGuidelineScreen);
                          },
                          title: langProvider.translate('Muss Weg'),
                          textSize: 12.sp,
                          color: Colors.red,
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