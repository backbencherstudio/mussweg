import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/view_model/home_provider/all_category_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/route_names.dart';
import '../../../view_model/home_provider/home_screen_provider.dart';
import '../../../view_model/product_item_list_provider/category_based_product_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          "Categories",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: Colors.black, size: 24.w),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Divider(),
            Consumer<AllCategoryProvider>(
              builder: (_, provider, __) {
                final feature = provider.categoryModel?.data;
                if (feature == null) {
                  return const Center(child: Text('No category founded'));
                }
                return Wrap(
                  spacing: 1.0,
                  runSpacing: 1.0,
                  children: feature.map((category) {
                    return SizedBox(
                      width: 85.w,
                      height: 135.h,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () async {
                              context
                                  .read<CategoryBasedProductProvider>()
                                  .setCategoryTitle(category.categoryName);
                              await context
                                  .read<CategoryBasedProductProvider>()
                                  .getCategoryBasedProduct(category.categoryId);
                              Navigator.pushNamed(
                                context,
                                RouteNames.productListScreen,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffF2F1EF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                '${ApiEndpoints.baseUrl}${category.photo.replaceAll('http://localhost:5005', '')}',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error, color: Colors.grey.shade300, size: 16.h,);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            category.categoryName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4A4C56),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
