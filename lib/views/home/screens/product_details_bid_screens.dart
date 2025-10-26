import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/view_model/parent_provider/parent_screen_provider.dart';
import 'package:mussweg/view_model/product_item_list_provider/get_product_details_provider.dart';
import 'package:mussweg/views/widgets/custom_primary_button.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/route_names.dart';
import '../../widgets/custom_main_button.dart';

class ProductDetailsBidScreens extends StatefulWidget {
  const ProductDetailsBidScreens({super.key});

  @override
  State<ProductDetailsBidScreens> createState() =>
      _ProductDetailsBidScreensState();
}

class _ProductDetailsBidScreensState extends State<ProductDetailsBidScreens> {
  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<GetProductDetailsProvider>();
    final product = productProvider.productDetailsResponse?.data;
    if (productProvider.loading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: SimpleApppbar(title: 'Product Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  "${ApiEndpoints.baseUrl}${product?.productPhoto?.replaceAll('http://localhost:5005', '')}",
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      height: 200.h,
                      width: double.infinity,
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
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(90.r),
                    child: Image.network(
                      "${ApiEndpoints.baseUrl}${product?.sellerInfo?.profilePhoto?.replaceAll('http://localhost:5005', '')}",
                      height: 60.w,
                      width: 60.w,
                      fit: BoxFit.cover,
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
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
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
                        "Message seller",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
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
                  Text(
                    "Description Product",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    product?.description ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffFDF3F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                ": ${product?.uploaded ?? ''}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                ": ${product?.remainingTime ?? ''}",
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
                            style: TextStyle(color: Color(0xff1DBF73)),
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
                          child: CustomMainButton(
                            onTap: () {},
                            title: 'Place a Bid',
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
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
