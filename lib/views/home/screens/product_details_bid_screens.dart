import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/user_id_storage.dart';
import 'package:mussweg/view_model/bid/place_a_bid_provider.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/view_model/product_item_list_provider/get_product_details_provider.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:mussweg/views/inbox/view_model/inbox_screen_provider.dart';
import 'package:mussweg/views/widgets/custom_text_field.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_names.dart';
import '../../../view_model/client_dashboard/client_dashboard_details_provider.dart';
import '../../widgets/custom_main_button.dart';

import '../widgets/bider_list_card.dart';
import '../widgets/custom_page_indicator.dart';

class ProductDetailsBidScreens extends StatefulWidget {
  const ProductDetailsBidScreens({super.key});

  @override
  State<ProductDetailsBidScreens> createState() =>
      _ProductDetailsBidScreensState();
}

class _ProductDetailsBidScreensState extends State<ProductDetailsBidScreens> {
  final PageController _pageController = PageController();

  final _bidController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _bidController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<GetProductDetailsProvider>();
    final product = productProvider.productDetailsResponse?.data;

    final isBidingProvider = context.watch<PlaceABidProvider>();

    if (productProvider.loading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (_, __) async {
        await context.read<PlaceABidProvider>().setIsBidding(false);
      },
      child: Scaffold(
        appBar: SimpleApppbar(
          title: 'Product Details',
          onBack: () async {
            await context.read<PlaceABidProvider>().setIsBidding(false);
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // PageView for images
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    height: 200.h,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount:
                          (product?.productPhoto?.isNotEmpty ?? false)
                              ? product!.productPhoto!.length
                              : 1,
                      itemBuilder: (context, index) {
                        if (product?.productPhoto == null ||
                            product!.productPhoto!.isEmpty) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          return Image.network(
                            "${ApiEndpoints.baseUrl}${product.productPhoto?[index].replaceAll('http://localhost:5005', '')}",
                            fit: BoxFit.cover,
                            loadingBuilder: (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                          : null,
                                ),
                              );
                            },
                            errorBuilder: (_, __, ___) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(
                                    'assets/images/placeholder.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),

              // Page Indicator (optional)
              SizedBox(height: 8),
              CustomPageIndicator(
                controller: _pageController,
                count: product?.productPhoto?.length ?? 0,
                activeColor: Colors.red,
                inactiveColor: Colors.grey.shade300,
                activeSize: 10,
                inactiveSize: 10,
                spacing: 8,
              ),

              SizedBox(height: 16),

              // Seller Info Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final userId = await UserIdStorage().getUserId();
                        if (userId == product?.sellerInfo?.userId) {
                          Navigator.pushNamed(
                            context,
                            RouteNames.sellerProfilePage,
                          );
                        } else {
                          context
                              .read<ClientDashboardDetailsProvider>()
                              .setClientId(product?.sellerInfo?.userId ?? '');
                          Navigator.pushNamed(
                            context,
                            RouteNames.viewProfileScreen,
                          );
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(90.r),
                              child: Image.network(
                                "${ApiEndpoints.baseUrl}${product?.sellerInfo?.profilePhoto?.replaceAll('http://localhost:5005', '')}",
                                height: 60.w,
                                width: 60.w,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.asset(
                                        'assets/icons/user.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product?.sellerInfo?.name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${product?.sellerInfo?.totalItems} items",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Consumer<InboxScreenProvider>(
                      builder: (context, inboxProvider, child) {
                        return GestureDetector(
                          onTap: () async {
                            await inboxProvider.createConversation(
                              product?.sellerInfo?.userId ?? '',
                            );
                            Navigator.pushNamed(context, RouteNames.chatScreen);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              "Message",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Category
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    SizedBox(width: 15.w),
                    Container(
                      height: 22.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: Color(0xffEEFAF6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          product?.category?.categoryName ?? '',
                          style: TextStyle(
                            color: Color(0xff3A9B7A),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              // Product Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.title ?? 'Unknown',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      spacing: 2,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xffA5A5AB),
                          size: 20,
                        ),
                        Text(
                          product?.location ?? 'unknown',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xffA5A5AB),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${product?.price ?? '0.00'}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 4.h),
                    isBidingProvider.isBidding == false
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              product?.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 16),
                            // Condition, Size, Color, etc.
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFDF3F2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    spacing: 4,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Condition",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Size",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Color",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Uploaded",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Remaining Time",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 140.w,
                                    child: Column(
                                      spacing: 4,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ": ${product?.condition ?? ''}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          ": ${product?.size ?? ''}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          ": ${product?.color ?? ''}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          ": ${DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(product?.uploaded ?? '')) ?? ''}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          product?.remainingTime == null ||
                                                  product?.remainingTime == ''
                                              ? ": 00h : 00m : 00s"
                                              : ": ${DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(product?.remainingTime ?? '')) ?? ''}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff1A9882),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Container(
                                width: 320.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: Color(0xffF4FCF8),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 12),
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Color(0Xff1DBF73),
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      "If a scam occurs, their money is protected.",
                                      style: TextStyle(
                                        color: Color(0xff1DBF73),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              'Market Price: \$${product?.price ?? '0.00'} ',
                              style: TextStyle(
                                color: Color(0xff4A4C56),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Last bid Price: \$${product?.minimumBid ?? '0.00'}  ",
                              style: TextStyle(
                                color: Color(0xff4A4C56),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 36.h),
                            SizedBox(
                              height: 60.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Consumer<PlaceABidProvider>(
                                      builder: (_, provider, __) {
                                        return CustomMainButton(
                                          onTap: () async {
                                            context
                                                .read<PlaceABidProvider>()
                                                .getAllBidsForProduct(
                                                  product?.productId ?? '',
                                                );
                                            await provider.setIsBidding(true);
                                          },
                                          title: 'Place a Bid',
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: CustomMainButton(
                                      onTap: () {
                                        context
                                            .read<ParentScreensProvider>()
                                            .onSelectedIndex(2);
                                        Navigator.pushNamed(
                                          context,
                                          RouteNames.parentScreen,
                                        );
                                      },
                                      title: 'Buy Now',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total bid",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Consumer<PlaceABidProvider>(
                              builder: (_, bidListProvider, __) {
                                print(
                                  "Bids count: ${bidListProvider.bidsResponse?.bids.length}",
                                );
                                final bids =
                                    bidListProvider.bidsResponse?.bids ?? [];
                                if (bids.isEmpty) {
                                  return const Text("No bids yet");
                                }
                                return Column(
                                  spacing: 16.h,
                                  children:
                                      bids
                                          .map((bid) => BiderListCard(bid: bid))
                                          .toList(),
                                );
                              },
                            ),
                            CustomTextField(
                              title: '',
                              hintText: 'Enter your bid price',
                              controller: _bidController,
                            ),
                            Consumer<PlaceABidProvider>(
                              builder: (_, pro, __) {
                                return Visibility(
                                  visible: !pro.isCreateBidLoading,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: PrimaryButton(
                                    onTap: () async {
                                      if (_bidController.text.isNotEmpty) {
                                        final bidAmount =
                                            double.tryParse(
                                              _bidController.text.trim(),
                                            ) ??
                                            0.0;
                                        final productPrice =
                                            double.tryParse(
                                              product?.price.toString() ?? '0',
                                            ) ??
                                            0.0;

                                        if (bidAmount >= productPrice) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Bid amount must be less than product price',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        final result = await pro
                                            .createBidByProductId(
                                              product?.productId ?? '',
                                              _bidController.text,
                                            );

                                        if (result) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(pro.message),
                                            ),
                                          );
                                          Navigator.pushReplacementNamed(
                                            context,
                                            RouteNames.bidSuccessScreen,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(pro.message),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    title: 'Bid Now',
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    SizedBox(height: 60.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
