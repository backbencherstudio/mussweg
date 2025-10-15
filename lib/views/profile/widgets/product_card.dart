import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:mussweg/views/profile/widgets/pickup_option_widget.dart';
import '../screens/view_profile/edit_product_page.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final bool isBoosted;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.isBoosted = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: SizedBox(
          height: 250.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 150.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.r),
                          ),
                          child: Image.asset(
                            imageUrl,
                            height: 110.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProductPage(),
                              ),
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
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
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
                        child: Image.asset(
                          'assets/icons/boost.png',
                          scale: 1.8,
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Row(
                        children: [
                          Text(
                            'Aug 6,13:55',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff777980),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '(12h:12m:30s)',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1A9882),
                            ),
                          ),
                        ],
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
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: PickupOptionWidget(),
                                    );
                                  });
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
        ),
      ),
    );
  }
}
