import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../../view_model/mussweg/mussweg_product_screen_provider.dart';
import '../../../view_model/pickup/pickup_option_provider.dart';
import '../../auth/sign_up/widgets/buttons.dart';

class PickupOptionWidget extends StatelessWidget {
  const PickupOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PickupOptionProvider>(context);
    final selected = provider.selectedOption;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "Choose Your Option",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(height: 8.h),

        Divider(thickness: 1, color: Colors.grey.shade300),

        _optionTile(
          context,
          title: "Send the Item to us",
          value: PickupOption.sendToUs,
          selected: selected == PickupOption.sendToUs,
          onTap: () {
            provider.selectOption(PickupOption.sendToUs);
            context.read<MusswegProductScreenProvider>().setType('SEND_IN');
          },
        ),
        SizedBox(height: 10.h),
        _optionTile(
          context,
          title: "Arrange a pickup at home",
          value: PickupOption.pickupAtHome,
          selected: selected == PickupOption.pickupAtHome,
          onTap: () {
            provider.selectOption(PickupOption.pickupAtHome);
            context.read<MusswegProductScreenProvider>().setType('PICKUP');
          },
        ),
        SizedBox(height: 10.h),
        Consumer<MusswegProductScreenProvider>(
          builder: (_, pro, __) {
            return PrimaryButton(
              onTap: () async {
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.musswegProductScreen,
                );
              },
              title: "Continue",
              textSize: 16.sp,
              color: Colors.red,
            );
          },
        ),
      ],
    );
  }

  Widget _optionTile(
    BuildContext context, {
    required String title,
    required PickupOption value,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: selected ? Colors.red.withOpacity(0.01) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: selected ? Colors.red : Colors.grey.shade400,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off_outlined,
              color: selected ? Colors.red : Colors.grey,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
