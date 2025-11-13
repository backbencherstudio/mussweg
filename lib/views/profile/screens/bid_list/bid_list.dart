import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/view_model/bid/place_a_bid_provider.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/api_end_points.dart';
import '../../../../view_model/bid/bid_for_seller_provider.dart';

class BidList extends StatefulWidget {
  const BidList({super.key});

  @override
  State<BidList> createState() => _BidListState();
}

class _BidListState extends State<BidList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Bid Request'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Consumer<PlaceABidProvider>(
          builder: (_, provider, __) {
            if (provider.isGetBidLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.bidsResponse?.bids.isEmpty ?? false) {
              return const Center(child: Text('No bids found'));
            }

            final product = provider.bidsResponse?.product;

            final imageUrl = (product?.photo != null && product!.photo!.isNotEmpty)
                ? "${ApiEndpoints.baseUrl}${product.photo!.first.replaceAll('http://localhost:5005', '')}"
                : null;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Info Card
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: imageUrl != null
                              ? Image.network(
                            imageUrl,
                            width: 80.w,
                            height: 60.h,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _placeholderImage(),
                          )
                              : _placeholderImage(),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 140.w,
                                child: Text(
                                  product?.productTitle ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff4A4C56),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Size ${product?.size}\n(${product?.condition} Condition)',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff777980),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${product?.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: const Color(0xffDE3526),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              product?.boostUntil == '' ||
                                  product?.boostUntil == null
                                  ? ''
                                  : '(${DateFormat("dd MMM, yy h:mm a").format(DateTime.parse(product?.boostUntil ?? ''))})',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff1A9882),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Total Bid Title
                  Text(
                    'Total Bid',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff4A4C56),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  provider.pendingBids.isEmpty
                      ? const Center(child: Text('No bids Found'))
                      : ListView.builder(
                    itemCount: provider.pendingBids.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final bid = provider.pendingBids[index];

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                        leading: ClipOval(
                          child: Image.network(
                            "${ApiEndpoints.baseUrl}${bid.biderAvatar.replaceAll('http://localhost:5005', '')}",
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          bid.biderName ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff4A4C56),
                          ),
                        ),
                        subtitle: Text(
                          bid.bidAmount ?? '0.00',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Consumer<PlaceABidProvider>(
                              builder: (_, pro, __) {
                                return Visibility(
                                  visible: !pro.isUpdating1,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await pro.updateBidStatusByProductId(bid.id, 'ACCEPTED');

                                      if (!mounted) return; // ✅ safety check

                                      final bidForSeller = context.read<BidForSellerProvider>();
                                      final productId = provider.bidsResponse?.product?.id ?? '';

                                      await pro.getAllBidsForProduct(productId);
                                      await bidForSeller.getRequestedBidsForSeller();
                                      await bidForSeller.getAcceptedBidsForSeller();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffDE3526),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 8.w),
                            Consumer<PlaceABidProvider>(
                              builder: (_, pro, __) {
                                return Visibility(
                                  visible: !pro.isUpdating2,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await pro.updateBidStatusByProductId(bid.id, 'REJECTED');

                                      if (!mounted) return; // ✅ safety check

                                      final bidForSeller = context.read<BidForSellerProvider>();
                                      final productId = provider.bidsResponse?.product?.id ?? '';

                                      await pro.getAllBidsForProduct(productId);
                                      await bidForSeller.getRequestedBidsForSeller();
                                      await bidForSeller.getAcceptedBidsForSeller();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color(0xffDE3526),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                        color: const Color(0xffDE3526),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 60.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Image.asset(
          'assets/images/placeholder.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}
