import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../views/bought_items/viewModel/bought_product/review_provider.dart';
import '../../../views/widgets/custom_primary_button.dart';

class ReviewDialog {
  showReviewDialog(
    BuildContext context,
    String productOwnerId,
    String orderId,
  ) {
    double rating = 0.0;
    final TextEditingController reviewController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        final reviewProvider = Provider.of<ReviewProvider>(
          context,
          listen: false,
        ); // ✅ moved here

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: const Text(
                'How is Your Order?',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Please take a moment to rate and review your experience.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          iconSize: 32.w,
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              rating = (index + 1).toDouble();
                            });
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 16.h),

                    TextField(
                      controller: reviewController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Write your review...',
                        contentPadding: EdgeInsets.all(12.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    SizedBox(
                      width: double.infinity,
                      child: CustomPrimaryButton(
                        title: 'Submit',
                        onTap: () {
                          final reviewText = reviewController.text.trim();

                          if (rating == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a star rating.'),
                              ),
                            );
                            return;
                          }

                          if (reviewText.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please write a review.'),
                              ),
                            );
                            return;
                          }

                          reviewProvider.reviewCreate(
                            ownerId: productOwnerId,
                            rating: rating,
                            comment: reviewText,
                            orderId: orderId,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                reviewProvider.message ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
