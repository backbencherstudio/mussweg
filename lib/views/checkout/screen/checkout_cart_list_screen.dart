import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mussweg/views/cart/view_model/payment_screen_provider.dart';
import 'package:mussweg/core/routes/route_names.dart';
import '../../profile/widgets/simple_apppbar.dart';
import '../widgets/checkout_card_widget.dart';
import '../widgets/custom_drop_down_field.dart';
import '../widgets/label_text.dart';
import '../widgets/text_form_field.dart';
import '../widgets/checkout_form.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  final List<String> _countries = [
    'USA',
    'Canada',
    'India',
    'Germany',
    'Australia',
  ];
  final List<String> _states = ['State 1', 'State 2', 'State 3'];
  final List<String> _cities = ['City 1', 'City 2', 'City 3'];

  final _nameController = TextEditingController();
  final _zipController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _zipController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentScreenProvider>();
    final selectedItems = provider.selectedCartItems;

    // Calculate subtotal of selected items
    final subtotal = selectedItems.fold<double>(
      0.0,
      (sum, item) => sum + ((item.price ?? 0) * (item.quantity ?? 0)),
    );

    final shippingCharge = 10.0; // Example flat shipping
    final total = subtotal + shippingCharge;

    return Scaffold(
      appBar: SimpleApppbar(title: 'Checkout'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            children: [
              // Selected cart items
              if (selectedItems.isNotEmpty)
                CheckoutCartWidget(selectedItems: selectedItems)
              else
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: Text("No items selected")),
                ),

              // Shipping form
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Shipping Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),

                      RequiredLabel(labelText: 'Full Name'),
                      SizedBox(height: 6.h),
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: 'Enter Your Name',
                      ),

                      SizedBox(height: 10.h),
                      RequiredLabel(labelText: 'Country'),
                      SizedBox(height: 6.h),
                      CustomDropdownFormField(
                        hintText: 'Select your country',
                        items: _countries,
                        selectedValue: _selectedCountry,
                        onChanged: (String? newValue) {
                          setState(() => _selectedCountry = newValue);
                        },
                      ),

                      SizedBox(height: 10.h),
                      RequiredLabel(labelText: 'State'),
                      SizedBox(height: 6.h),
                      CustomDropdownFormField(
                        hintText: 'Select your state',
                        items: _states,
                        selectedValue: _selectedState,
                        onChanged: (String? newValue) {
                          setState(() => _selectedState = newValue);
                        },
                      ),

                      SizedBox(height: 10.h),
                      RequiredLabel(labelText: 'City'),
                      SizedBox(height: 6.h),
                      CustomDropdownFormField(
                        hintText: 'Select your city',
                        items: _cities,
                        selectedValue: _selectedCity,
                        onChanged: (String? newValue) {
                          setState(() => _selectedCity = newValue);
                        },
                      ),

                      SizedBox(height: 10.h),
                      RequiredLabel(labelText: 'ZIP Code'),
                      SizedBox(height: 6.h),
                      CustomTextFormField(
                        controller: _zipController,
                        hintText: 'Enter ZIP Code',
                      ),

                      SizedBox(height: 10.h),
                      RequiredLabel(labelText: 'Address'),
                      SizedBox(height: 6.h),
                      CustomTextFormField(
                        controller: _addressController,
                        hintText: 'Enter Your Address',
                      ),
                    ],
                  ),
                ),
              ),


              // Place Order Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed:
                        selectedItems.isEmpty
                            ? null
                            : () async {
                              final shippingData = {
                                "shipping_name": _nameController.text,
                                "email": "johndoe@example.com",
                                "shipping_country": _selectedCountry,
                                "shipping_state": _selectedState,
                                "shipping_city": _selectedCity,
                                "shipping_zip_code": _zipController.text,
                                "shipping_address": _addressController.text,
                              };

                              await provider.createOrder(shippingData);
                              provider.clearSelectedItems();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Order placed successfully!"),
                                ),
                              );

                              if (shippingData.isNotEmpty) {
                                await provider.getMyOrder();

                                Navigator.pushNamed(
                                  context,
                                  RouteNames.orderIdWithPayment,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("some thing wrong")),
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
