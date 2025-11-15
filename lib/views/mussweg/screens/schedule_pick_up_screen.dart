import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../../view_model/mussweg/mussweg_product_screen_provider.dart';
import '../../auth/sign_up/widgets/buttons.dart';
import '../../profile/widgets/custom_dropdown_field.dart';
import '../../profile/widgets/custom_text_field.dart';
import '../../profile/widgets/simple_apppbar.dart';

class SchedulePickUpScreen extends StatefulWidget {
  const SchedulePickUpScreen({super.key});

  @override
  State<SchedulePickUpScreen> createState() => _SchedulePickUpScreenState();
}

class _SchedulePickUpScreenState extends State<SchedulePickUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  List<String> _conditions = const ["Zurich", "Schwyz"];

  bool hasAddressNotFound = false;

  @override
  void initState() {
    super.initState();
    // Initialize the address controller with provider's current address
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MusswegProductScreenProvider>(
        context,
        listen: false,
      );
      if (provider.currentAddress.isNotEmpty && provider.currentAddress != "Address not found") {
        _addressController.text = provider.currentAddress;
        setState(() {
          hasAddressNotFound = false;
        });
      } else {
        if (provider.currentAddress == "Address not found") {
          setState(() {
            hasAddressNotFound = true;
          });
        } else {
          setState(() {
            hasAddressNotFound = false;
          });
        }
        _addressController.clear();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MusswegProductScreenProvider>(
      builder: (context, provider, _) {
        // Update address controller whenever currentAddress changes
        if (_addressController.text.isEmpty &&
            provider.currentAddress.isNotEmpty) {
          _addressController.text = provider.currentAddress;
        }

        return Scaffold(
          appBar: SimpleApppbar(title: 'Schedule Pickup'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup Information',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
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
                          CustomDropdownField(
                            title: 'Place Name',
                            hintText: 'Select Place',
                            items: _conditions,
                            value: provider.placeName,
                            onChanged: (value) {
                              if (value != null) {
                                provider.setPlaceName(value);
                              }
                            },
                          ),
                          CustomTextField(
                            controller: _addressController,
                            title: 'Place Address',
                            hintText: 'Enter place address',
                            maxLine: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: 'Pick on map',
                          color: Colors.red,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.locationPickScreen,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Visibility(
                          visible: !provider.isLoading,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: PrimaryButton(
                            title: 'Submit',
                            color: Colors.red,
                            onTap: () async {
                              debugPrint("Name: ${_nameController.text}");
                              debugPrint("Address: ${_addressController.text}");

                              if (_addressController.text.isEmpty) {
                                if (hasAddressNotFound) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Something Went Wrong!!! Please Input Address Manually',
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please fill all the fields',
                                      ),
                                    ),
                                  );
                                }
                                return;
                              }

                              final res = await provider.createMusswegForPickup(
                                placeAddress: _addressController.text,
                              );

                              if (res) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteNames.wegSuccessScreen,
                                );

                                _addressController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      provider.message ??
                                          'Mussweg Disposal Failed',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
