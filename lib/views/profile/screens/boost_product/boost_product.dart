import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/profile/widgets/custom_dropdown_field.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/api_end_points.dart';
import '../../../../view_model/boost_product/boost_product_create_provider.dart';
import '../../../../view_model/profile/boost_product_service_provider/boost_product_service.dart';
import '../../widgets/custom_text_field.dart';

class BoostProductPage extends StatefulWidget {
  BoostProductPage({super.key});

  @override
  State<BoostProductPage> createState() => _BoostProductPageState();
}

class _BoostProductPageState extends State<BoostProductPage> {
  final List<Map<String, String>> tiers = [
    {"type": "Muss Schnell Weg", "duration": '3 Days', 'tier': 'TIER_1'},
    {"type": "Muss Zackig Weg", "duration": '5 Days', 'tier': 'TIER_2'},
    {"type": "Muss Sofort Weg", "duration": '7 Days', 'tier': 'TIER_3'},
  ];

  final TextEditingController _boostDurationController =
  TextEditingController();

  @override
  void dispose() {
    _boostDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = GetIt.instance<BoostProductService>();

    final boostProductProvider = context.watch<BoostProductCreateProvider>();
    final imageUrl = boostProductProvider.image;

    return Scaffold(
      appBar: const SimpleApppbar(title: 'Boost Product'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            /// ---------------- PRODUCT INFO ----------------
            Text(
              'Product Info',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: imageUrl != null || imageUrl != '' ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        "${ApiEndpoints.baseUrl}${imageUrl.replaceAll('http://localhost:5005', '')}",
                        height: 200.h,
                        width: double.infinity,
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
                        errorBuilder: (_, __, ___) => Container(
                          height: 200.h,
                          color: Colors.grey[300],
                          child: Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ) : Container(
                      height: 110.h,
                      color: Colors.grey[300],
                      child: Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          boostProductProvider.title,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4A4C56)),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Text(
                              'Size ${boostProductProvider.size}',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Color(0xff777980)),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '(${boostProductProvider.condition} Condition)',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Color(0xff777980)),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Text(
                              DateFormat(
                                "dd MMM, yy h:mm a",
                              ).format(DateTime.parse(boostProductProvider.time)),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Color(0xff777980)),
                            ),
                            Spacer(),
                            boostProductProvider.boostTime == '' ? SizedBox() : Text(
                              'Till ${DateFormat(
                                "dd MMM, yy h:mm a",
                              ).format(DateTime.parse(boostProductProvider.boostTime))}',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Color(0xff1A9882)),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              '\$${boostProductProvider.price}',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffDE3526)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// ---------------- BOOST SECTION ----------------
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Color(0xffE9E9EA)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  children: [
                    /// Dropdown
                    AnimatedBuilder(
                      animation: service,
                      builder: (context, _) {
                        return CustomDropdownField(
                          title: 'Boosting Type',
                          hintText: 'Boosting Type',
                          items: tiers.map((e) => e['type']!).toList(),
                          value: service.selectedCondition,
                          onChanged: (value) {
                            service.setSelectedCondition(value);
                            final selectedTier = tiers.firstWhere(
                                    (e) => e['type'] == value,
                                orElse: () => {"duration": ""}
                            );

                            _boostDurationController.text = selectedTier["duration"]!;
                            setState(() {});

                            context.read<BoostProductCreateProvider>().setBoostTier(selectedTier["tier"]!);
                          },
                        );
                      },
                    ),

                    CustomTextField(
                      readOnly: true,
                      controller: _boostDurationController,
                      title: 'Boosting Duration',
                      hintText: 'Boosting Duration',
                      icon: Icons.access_time,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 35.h),

            /// ---------------- BUTTONS ----------------
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Consumer<BoostProductCreateProvider>(
                    builder: (_, provider, __) {
                      return Visibility(
                        visible: !provider.isLoading,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await provider.createBoostProduct();
                            if (result) {
                              Navigator.pushReplacementNamed(
                                context,
                                RouteNames.boostSuccessPage,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(provider.errorMessage),
                                ),
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
                          child: Text('Boost',
                              style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
