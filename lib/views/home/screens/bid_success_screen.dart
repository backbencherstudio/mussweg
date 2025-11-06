import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/view_model/bid/place_a_bid_provider.dart';
import 'package:mussweg/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class BidSuccessScreen extends StatelessWidget {
  const BidSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Image.asset('assets/icons/success-icon.png'),
                    SizedBox(height: 10.h),
                    Text(
                      'Your bid request\nhas been placed!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A4C56),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'when the seller approves your request, you can\nproceed with the payment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4A4C56),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      text: 'Back to Home',
                      textColor: Colors.white,
                      buttonColor: Colors.red,
                      onPressed: () async {
                        await context.read<PlaceABidProvider>().setIsBidding(false);
                        Navigator.pushReplacementNamed(context, RouteNames.productDetailsScreen);
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
