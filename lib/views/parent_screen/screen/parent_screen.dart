import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mussweg/view_model/auth/login/get_me_viewmodel.dart';
import 'package:mussweg/view_model/home_provider/all_category_provider.dart';
import 'package:mussweg/view_model/home_provider/home_nav/electronic_category_based_provider.dart';
import 'package:mussweg/view_model/home_provider/home_nav/home_category_based_provider.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_provider/home_nav/fashion_category_based_product_provider.dart';
import '../../../view_model/parent_provider/parent_screen_provider.dart';

import '../../../view_model/whistlist/whistlist_provider_of_get_favourite_product.dart';
import '../widget/parent_screen_widget.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreensState();
}

class _ParentScreensState extends State<ParentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AllCategoryProvider>().getAllCategories();
      final allCategoryProvider = context.read<AllCategoryProvider>();
      context.read<FashionCategoryBasedProductProvider>().getCategoryBasedProduct(allCategoryProvider.fashionCategoryId);
      context.read<HomeCategoryBasedProvider>().getCategoryBasedProduct(allCategoryProvider.homeCategoryId);
      context.read<ElectronicCategoryBasedProvider>().getCategoryBasedProduct(allCategoryProvider.electronicsCategoryId);
      context.read<WhistlistProviderOfGetFavouriteProduct>().getWishlistProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit'),
              content: const Text('Are you sure you want to quit?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          left: false,
          right: false,
          bottom: true,
          top: false,
          child: Stack(
            children: [
              Consumer<ParentScreensProvider>(
                builder: (context, parentScreenProvider, child) {
                  if (parentScreenProvider.screens.isEmpty ||
                      parentScreenProvider.selectedIndex < 0 ||
                      parentScreenProvider.selectedIndex >=
                          parentScreenProvider.screens.length) {
                    return const Center(child: Text('No screens available'));
                  }
                  final validScreens = parentScreenProvider.screens
                      .asMap()
                      .entries
                      .where((entry) => entry.value != null)
                      .map((entry) => entry.value!)
                      .toList();

                  if (validScreens.isEmpty) {
                    return const Center(
                      child: Text('No valid screens available'),
                    );
                  }

                  final adjustedIndex = parentScreenProvider.selectedIndex.clamp(
                    0,
                    validScreens.length - 1,
                  );

                  return IndexedStack(
                    index: adjustedIndex,
                    children: validScreens,
                  );
                },
              ),
              Transform.translate(
                offset: const Offset(0, -15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const ParentScreenWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
