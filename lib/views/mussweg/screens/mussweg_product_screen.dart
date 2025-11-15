import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/mussweg/mussweg_product_screen_provider.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../profile/widgets/custom_text_field.dart';

class MusswegProductScreen extends StatefulWidget {
  const MusswegProductScreen({super.key});

  @override
  State<MusswegProductScreen> createState() => _MusswegProductScreenState();
}

class _MusswegProductScreenState extends State<MusswegProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final musswegProductScreenProvider =
        context.read<MusswegProductScreenProvider>();
    return Scaffold(
      appBar: SimpleApppbar(title: 'Muss-weg Product'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ------------------ FORM SECTION ------------------
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                      color: const Color(0xffE9E9EA),
                      width: 1.5.w,
                    ),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          title: 'Product Name',
                          hintText: 'Enter Product name',
                        ),
                        CustomTextField(
                          controller: _typeController,
                          title: 'Product Type',
                          hintText: 'Enter Product Type',
                        ),
                        CustomTextField(
                          controller: _quantityController,
                          title: 'Quantity',
                          hintText: 'Enter Quantity',
                        ),
                        SizedBox(height: 12.h),
                        Consumer<MusswegProductScreenProvider>(
                          builder: (_, pro, __) {
                            return GestureDetector(
                              onTap: () {
                                pro.pickSingleImage();
                              },
                              child: Container(
                                height: 220.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child:
                                    pro.image == null
                                        ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            OutlinedButton.icon(
                                              icon: Icon(
                                                Icons.add_a_photo,
                                                color: Colors.red,
                                                size: 20.w,
                                              ),
                                              label: Text(
                                                'Upload Photo',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              onPressed: () {
                                                pro.pickSingleImage();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color: Colors.red,
                                                  width: 1.w,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20.r),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        : Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                10.r,
                                              ),
                                              child: Image.file(
                                                pro.image!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // ------------------ SUBMIT BUTTON ------------------
                SizedBox(
                  width: double.infinity,
                  child: Consumer<MusswegProductScreenProvider>(
                    builder: (_, provider, __) {
                      return Visibility(
                        visible: !provider.isLoading,
                        replacement: const Center(
                          child: CircularProgressIndicator(color: Colors.red),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            final title = _nameController.text;
                            final type = _typeController.text;
                            final quantity = _quantityController.text;

                            provider.setName(title);
                            provider.setProductType(type);
                            provider.setQuantity(quantity);

                            if(provider.type == 'SEND_IN') {
                              final res = await provider.createMusswegForSendIn();

                              if (res) {
                                _nameController.clear();
                                _typeController.clear();
                                _quantityController.clear();
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteNames.wegSuccessScreen,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(provider.message ?? 'Mussweg Disposal Failed'),
                                  ),
                                );
                              }
                            } else {
                              _nameController.clear();
                              _typeController.clear();
                              _quantityController.clear();
                              Navigator.pushReplacementNamed(
                                context,
                                RouteNames.schedulePickUpScreen,
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
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
