import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../view_model/home_provider/favorite_icon_provider.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return SizedBox(
      width: 220.w,
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Image.asset('assets/images/post_card.png'),
                    ),
                  ),
                  Positioned(
                    top: 8.w,
                    left: 8.w,
                    child: GestureDetector(
                      onTap: () {
                        favoriteProvider.toggleFavorite();
                      },
                      child: Container(
                        height: 36.h,
                        width: 36.w,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: favoriteProvider.isFavorite
                              ? const Color(0xffffd6d6)
                              : const Color(0xffC7C8C8),
                        ),
                        child: Center(
                          child: Icon(
                            favoriteProvider.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteProvider.isFavorite
                                ? Colors.red
                                : Colors.white,
                            size: 20.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Max Exclusive T-Shirt",
                style:
                TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                "Size XL (New Condition)",
                style:
                TextStyle(fontSize: 12.sp, color: const Color(0xff777980)),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Aug 6 ,13:55",
                      style: TextStyle(
                        color: const Color(0xff777980),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "  (12h :12m :30s)",
                      style: TextStyle(
                        color: const Color(0xff1A9882),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade200, thickness: .7.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$25.00',
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
            ],
          ),
        ),
      ),
    );
  }
}
