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

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final List<String> _conditions = const [
    "New",
    "Used",
    "Refurbished",
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
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _colorController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<SellItemService>();
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
      body: Consumer<SellItemService>(
        builder: (_, sellItemProvider, __) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
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
                        AnimatedBuilder(
                          animation: service,
                          builder: (context, _) => Column(
                            children: [
                              CustomTextField(
                                controller: _locationController,
                                title: 'Location',
                                hintText: 'Enter Location',
                              ),
                              CustomDropdownField(
                                title: 'Category',
                                hintText: 'Select category',
                                items: _categories.map((category) => category.categoryName).toList(),
                                value: service.categoryName,
                                onChanged: (value) {
                                  final selectedCategory = _categories.firstWhere((category) => category.categoryName == value);
                                  service.setCategoryId(selectedCategory.categoryId);
                                  service.setCategoryName(selectedCategory.categoryName);
                                },
                              ),
                              CustomDropdownField(
                                title: 'Size',
                                hintText: 'Select size',
                                items: _size,
                                value: service.size,
                                onChanged: (value) {
                                  service.setSize(value ?? '');
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
                                value: service.condition,
                                onChanged: (value) {
                                  service.setCondition(value ?? '');
                                },
                              ),
                            ],
                          ),
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
                    final price = _priceController.text;
                    final res = await service.createPost(
                      title,
                      description,
                      location,
                      color,
                      9.toString(),
                      price,
                    );
                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Item Added Successfully')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Item Create Failed')),
                      );
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
                    'Update',
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

