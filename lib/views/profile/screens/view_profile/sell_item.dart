import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:mussweg/views/profile/model/category_name_id_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/home/category_model.dart';
import '../../../../view_model/home_provider/all_category_provider.dart';
import '../../../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
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
      appBar: const SimpleApppbar(title: 'Sell an Item'),
      body: Consumer<SellItemService>(
        builder: (_, sellItemProvider, __) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    sellItemProvider.pickImage();
                  },
                  child: Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: sellItemProvider.image == null
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
                            sellItemProvider.pickImage();
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
                        : Image.file(sellItemProvider.image!, fit: BoxFit.cover),
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
                          value: sellItemProvider.categoryName,
                          onChanged: (value) {
                            if (value != null) {
                              final selectedCategory = _categories.firstWhere(
                                      (category) => category.categoryName == value);
                              sellItemProvider.setCategoryId(selectedCategory.categoryId);
                              sellItemProvider.setCategoryName(selectedCategory.categoryName);
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
                          hintText: 'Enter stock',
                        ),
                        CustomTimeField(title: 'Price', controller: _priceController),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
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
                    final message = sellItemProvider.message ?? 'Product Create Failed';

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
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
