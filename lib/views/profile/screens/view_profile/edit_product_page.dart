import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mussweg/view_model/profile/update_item_service.dart';
import 'package:mussweg/views/profile/model/category_name_id_model.dart';
import '../../../../core/constants/api_end_points.dart';
import '../../../../data/model/product/product_details_response.dart';
import '../../../../view_model/home_provider/all_category_provider.dart';
import '../../../../view_model/product_item_list_provider/get_product_details_provider.dart';
import '../../../../view_model/profile/user_all_products/user_all_products_provider.dart';
import '../../../widgets/simple_apppbar.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_time_text_field.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final List<String> _conditions = ["NEW", "OLD"];
  final List<String> _sizes = ["SMALL", "MEDIUM", "LARGE", "EXTRA_LARGE"];
  List<CategoryNameIdModel> _categories = [];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _colorController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = context.read<GetProductDetailsProvider>();
      final updateProvider = context.read<UpdateItemService>();

      productProvider.addListener(() {
        final product = productProvider.productDetailsResponse?.data;
        if (product != null) {
          _populateControllers(product, updateProvider);
        }
      });

      final product = productProvider.productDetailsResponse?.data;
      if (product != null) {
        _populateControllers(product, updateProvider);
      }
    });
  }

  void _populateControllers(ProductData product, UpdateItemService updateProvider) {
    updateProvider.setProductId(product.productId ?? '');
    updateProvider.setCategoryId(product.category?.id ?? '');
    updateProvider.setCategoryName(product.category?.categoryName ?? '');
    updateProvider.setSize(product.size ?? '');
    updateProvider.setCondition(product.condition ?? '');
    updateProvider.setLocation(product.location ?? '');

    _titleController.text = product.title ?? '';
    _descriptionController.text = product.description ?? '';
    _locationController.text = product.location ?? '';
    _colorController.text = product.color ?? '';
    _stockController.text = '0';
    _priceController.text = product.price?.toString() ?? '';

    // ✅ Load existing images from API response if any
    if (product.productPhoto != null) {
      updateProvider.setNetworkImages(product.productPhoto?.map<String>((img) {
        return "${ApiEndpoints.baseUrl}${img.replaceAll('http://localhost:5005', '')}";
      }).toList() ?? []);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _colorController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData =
        context.read<AllCategoryProvider>().categoryModel?.data;
    if (categoriesData != null) {
      _categories = categoriesData
          .map((c) => CategoryNameIdModel(
          categoryId: c.categoryId, categoryName: c.categoryName))
          .toList();
    }

    final product =
        context.watch<GetProductDetailsProvider>().productDetailsResponse?.data;

    return Scaffold(
      appBar: const SimpleApppbar(title: 'Edit Item'),
      body: Consumer<UpdateItemService>(
        builder: (_, updateProvider, __) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🖼️ Product Image Section
                GestureDetector(
                  onTap: () {
                    updateProvider.pickMultipleImages();
                  },
                  child: Container(
                    height: 220.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: (updateProvider.images.isEmpty &&
                        updateProvider.networkImages.isEmpty)
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton.icon(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.red,
                            size: 20.w,
                          ),
                          label: Text(
                            'Upload photos',
                            style: TextStyle(
                                color: Colors.red, fontSize: 14.sp),
                          ),
                          onPressed: () {
                            updateProvider.pickMultipleImages();
                          },
                          style: OutlinedButton.styleFrom(
                            side:
                            BorderSide(color: Colors.red, width: 1.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 8.h,
                        ),
                        itemCount: updateProvider.networkImages.length +
                            updateProvider.images.length,
                        itemBuilder: (context, index) {
                          final isNetworkImage = index <
                              updateProvider.networkImages.length;
                          final image = isNetworkImage
                              ? updateProvider.networkImages[index]
                              : updateProvider
                              .images[index -
                              updateProvider.networkImages.length]
                              .path;

                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: isNetworkImage
                                    ? Image.network(
                                  image,
                                  fit: BoxFit.cover,
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
                                )
                                    : Image.file(
                                  File(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    if (isNetworkImage) {
                                      updateProvider.removeNetworkImage(image);
                                    } else {
                                      updateProvider.images.removeAt(
                                          index - updateProvider.networkImages.length);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(4.sp),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // 📝 Product Form Section
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                        color: const Color(0xffE9E9EA), width: 1.2.w),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _titleController,
                          title: 'Title',
                          hintText: 'e.g. Blue Pottery Vase',
                        ),
                        CustomTextField(
                          controller: _descriptionController,
                          title: 'Description',
                          hintText: 'e.g. A handmade vase',
                        ),
                        CustomTextField(
                          controller: _locationController,
                          title: 'Location',
                          hintText: 'Enter Location',
                        ),
                        CustomDropdownField(
                          title: 'Category',
                          hintText: 'Select Category',
                          items: _categories
                              .map((e) => e.categoryName)
                              .toList(),
                          value: updateProvider.categoryName,
                          onChanged: (value) {
                            final selected = _categories.firstWhere(
                                  (e) => e.categoryName == value,
                            );
                            updateProvider.setCategoryId(selected.categoryId);
                            updateProvider
                                .setCategoryName(selected.categoryName);
                          },
                        ),
                        CustomDropdownField(
                          title: 'Size',
                          hintText: 'Select Size',
                          items: _sizes,
                          value: updateProvider.size,
                          onChanged: (v) => updateProvider.setSize(v!),
                        ),
                        CustomTextField(
                          controller: _colorController,
                          title: 'Color',
                          hintText: 'Enter Color',
                        ),
                        CustomDropdownField(
                          title: 'Condition',
                          hintText: 'Select Condition',
                          items: _conditions,
                          value: updateProvider.condition,
                          onChanged: (v) => updateProvider.setCondition(v!),
                        ),
                        CustomTextField(
                          controller: _stockController,
                          title: 'Stock',
                          hintText: 'Enter Stock Quantity',
                        ),
                        CustomTimeField(
                            title: 'Price', controller: _priceController),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // 🔘 Submit Button
                Visibility(
                  visible: !updateProvider.isLoading,
                  replacement: const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final success = await updateProvider.updatePost(
                        _titleController.text.trim(),
                        _descriptionController.text.trim(),
                        _locationController.text.trim(),
                        _colorController.text.trim(),
                        _stockController.text.trim(),
                        _priceController.text.trim(),
                      );

                      if (success) {
                        await context
                            .read<UserAllProductsProvider>()
                            .getAllUserProduct();
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                updateProvider.message ?? 'Update Failed')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Update Product',
                      style:
                      TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
