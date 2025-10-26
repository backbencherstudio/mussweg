import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/view_model/profile/update_item_service.dart';
import 'package:mussweg/views/profile/model/category_name_id_model.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/home_provider/all_category_provider.dart';
import '../../../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
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
  final List<String> _conditions = const [
    "NEW",
    "OLD",
  ];
  final List<String> _size = const [
    "SMALL",
    "MEDIUM",
    "LARGE",
    "EXTRA_LARGE"
  ];

  late List<CategoryNameIdModel> _categories = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _colorController.dispose();
    _stockController.dispose();
    _priceController.dispose();
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
      appBar: const SimpleApppbar(title: 'Update an Item'),
      body: Consumer<UpdateItemService>(
        builder: (_, updateItemProvider, __) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    updateItemProvider.pickImage();
                  },
                  child: Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: updateItemProvider.image == null
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
                            updateItemProvider.pickImage();
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
                        : Image.file(updateItemProvider.image!, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 24.h),
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
                          hintText: 'e.g. Blue Pottery Vase',
                        ),
                        CustomTextField(
                          controller: _locationController,
                          title: 'Location',
                          hintText: 'Enter Location',
                        ),
                        CustomDropdownField(
                          title: 'Category',
                          hintText: 'Select category',
                          items: _categories.map((category) => category.categoryName).toList(),
                          value: updateItemProvider.categoryName,
                          onChanged: (value) {
                            if (value != null) {
                              final selectedCategory = _categories.firstWhere(
                                      (category) => category.categoryName == value);
                              updateItemProvider.setCategoryId(selectedCategory.categoryId);
                              updateItemProvider.setCategoryName(selectedCategory.categoryName);
                            }
                          },
                        ),
                        CustomDropdownField(
                          title: 'Size',
                          hintText: 'Select size',
                          items: _size,
                          value: updateItemProvider.size,
                          onChanged: (value) {
                            if (value != null) {
                              updateItemProvider.setSize(value);
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
                          value: updateItemProvider.condition,
                          onChanged: (value) {
                            if (value != null) {
                              updateItemProvider.setCondition(value);
                            }
                          },
                        ),
                        CustomTextField(
                          controller: _stockController,
                          title: 'Stock',
                          hintText: 'Enter stock',
                        ),
                        CustomTimeField(title: 'Price', controller: _priceController),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Visibility(
                  visible: !updateItemProvider.isLoading,
                  replacement: Center(
                    child: CircularProgressIndicator(color: Colors.red,),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final title = _titleController.text;
                      final description = _descriptionController.text;
                      final location = _locationController.text;
                      final color = _colorController.text;
                      final stock = _stockController.text;
                      final price = _priceController.text;

                      final res = await updateItemProvider.updatePost(
                        title,
                        description,
                        location,
                        color,
                        stock,
                        price,
                      );
                      final message = updateItemProvider.message ?? 'Product Create Failed';
                      await context.read<UserAllProductsProvider>().getAllUserProduct();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
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
