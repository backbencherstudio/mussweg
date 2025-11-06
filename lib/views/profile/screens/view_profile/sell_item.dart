import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/model/category_name_id_model.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/home_provider/all_category_provider.dart';
import '../../../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import '../../../../view_model/profile/user_all_products/user_all_products_provider.dart';
import '../../../widgets/simple_apppbar.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_time_text_field.dart';

class SellItemPage extends StatefulWidget {
  const SellItemPage({super.key});

  @override
  State<SellItemPage> createState() => _SellItemPageState();
}

class _SellItemPageState extends State<SellItemPage> {
  final List<String> _conditions = const ["NEW", "OLD"];
  final List<String> _size = const ["SMALL", "MEDIUM", "LARGE", "EXTRA_LARGE"];

  late List<CategoryNameIdModel> _categories = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
    final categoriesData = context.read<AllCategoryProvider>().categoryModel?.data;

    if (categoriesData != null) {
      _categories = categoriesData.map<CategoryNameIdModel>((category) {
        return CategoryNameIdModel(
          categoryId: category.categoryId,
          categoryName: category.categoryName,
        );
      }).toList();
    }

    return Scaffold(
      appBar: const SimpleApppbar(title: 'Sell an Item'),
      body: Consumer<SellItemService>(
        builder: (_, sellItemProvider, __) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ------------------ IMAGE PICKER SECTION ------------------
                GestureDetector(
                  onTap: () {
                    sellItemProvider.pickMultipleImages();
                  },
                  child: Container(
                    height: 220.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: sellItemProvider.images.isEmpty
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
                            style: TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                          onPressed: () {
                            sellItemProvider.pickMultipleImages();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red, width: 1.w),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 8.h,
                        ),
                        itemCount: sellItemProvider.images.length,
                        itemBuilder: (context, index) {
                          final image = sellItemProvider.images[index];
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  File(image.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sellItemProvider.images.removeAt(index);
                                    });
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

                // ------------------ FORM SECTION ------------------
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(color: const Color(0xffE9E9EA), width: 1.5.w),
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
                          title: 'Descriptions',
                          hintText: 'Describe your product',
                        ),
                        CustomTextField(
                          controller: _locationController,
                          title: 'Location',
                          hintText: 'Enter Location',
                        ),
                        CustomDropdownField(
                          title: 'Category',
                          hintText: 'Select category',
                          items: _categories.map((c) => c.categoryName).toList(),
                          value: sellItemProvider.categoryName,
                          onChanged: (value) {
                            if (value != null) {
                              final selected = _categories.firstWhere(
                                      (c) => c.categoryName == value);
                              sellItemProvider.setCategoryId(selected.categoryId);
                              sellItemProvider.setCategoryName(selected.categoryName);
                            }
                          },
                        ),
                        CustomDropdownField(
                          title: 'Size',
                          hintText: 'Select size',
                          items: _size,
                          value: sellItemProvider.size,
                          onChanged: (value) {
                            if (value != null) {
                              sellItemProvider.setSize(value);
                            }
                          },
                        ),
                        CustomTextField(
                          controller: _colorController,
                          title: 'Color',
                          hintText: 'Enter Color',
                        ),
                        CustomDropdownField(
                          title: 'Condition',
                          hintText: 'Select condition',
                          items: _conditions,
                          value: sellItemProvider.condition,
                          onChanged: (value) {
                            if (value != null) {
                              sellItemProvider.setCondition(value);
                            }
                          },
                        ),
                        CustomTextField(
                          controller: _stockController,
                          title: 'Stock',
                          hintText: 'Enter stock quantity',
                        ),
                        CustomTimeField(
                          title: 'Price',
                          controller: _priceController,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // ------------------ SUBMIT BUTTON ------------------
                Visibility(
                  visible: !sellItemProvider.isLoading,
                  replacement: const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final title = _titleController.text;
                      final description = _descriptionController.text;
                      final location = _locationController.text;
                      final color = _colorController.text;
                      final stock = _stockController.text;
                      final price = _priceController.text;

                      final res = await sellItemProvider.createPost(
                        title,
                        description,
                        location,
                        color,
                        stock,
                        price,
                      );

                      final message =
                          sellItemProvider.message ?? 'Product creation failed';
                      await context
                          .read<UserAllProductsProvider>()
                          .getAllUserProduct();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );

                      if (res) {
                        _titleController.clear();
                        _descriptionController.clear();
                        _locationController.clear();
                        _colorController.clear();
                        _stockController.clear();
                        _priceController.clear();
                        sellItemProvider.images.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Sell',
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
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
