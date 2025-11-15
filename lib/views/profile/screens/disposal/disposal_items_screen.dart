import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/data/model/disposal/disposal_item.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/api_end_points.dart';
import '../../../auth/disposal/get_disposal_items_provider.dart';

class DisposalItemsScreen extends StatefulWidget {
  const DisposalItemsScreen({super.key});

  @override
  State<DisposalItemsScreen> createState() => _DisposalItemsScreenState();
}

class _DisposalItemsScreenState extends State<DisposalItemsScreen> {
  final List<String> _tabs = [
    'Current Pickup',
    'Pending',
    'Approved',
    'Completed',
    'Penalty',
  ];

  final List<String> statusFilters = [
    "PICKUP",
    "PENDING",
    "APPROVED",
    "COMPLETED",
    "PENALTY",
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetDisposalItemsProvider>(context, listen: false)
          .getDisposalItems(status: "PICKUP");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Disposal'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  itemCount: _tabs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedIndex == index;
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          _selectedIndex = index;
                        });

                        final status = statusFilters[index];

                        Provider.of<GetDisposalItemsProvider>(
                          context,
                          listen: false,
                        ).getDisposalItems(status: status);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.red.shade100
                                  : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: Text(
                            _tabs[index],
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.red.shade600
                                      : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: Consumer<GetDisposalItemsProvider>(
                  builder: (_, provider, __) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.disposalItems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/noItem.png'),
                            SizedBox(
                              width: 180.w,
                              child: Text(
                                provider.message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: provider.disposalItems.length,
                      itemBuilder: (context, index) {
                        final item = provider.disposalItems[index];
                        return DisposalItemCard(
                          selectedIndex: _selectedIndex,
                          item: item,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisposalItemCard extends StatelessWidget {
  const DisposalItemCard({
    super.key,
    required this.item, required this.selectedIndex
  });

  final DisposalItem item;
  final int selectedIndex;

  Color _getTagColor(int index) {
    switch (index) {
      case 0:
        return Colors.red.shade100;
      case 1:
        return Colors.grey.shade200;
      case 2:
        return Colors.red;
      case 3:
        return Colors.red.shade100;
      case 4:
        return Colors.red.shade100;
      default:
        return Colors.grey;
    }
  }

  Color _getTextColor(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.grey.shade700;
      case 2:
        return Colors.white;
      case 3:
        return Colors.red;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getText(int index) {
    switch (index) {
      case 0:
        return 'Pickup';
      case 1:
        return 'Requesting';
      case 2:
        return 'Go to Payment';
      case 3:
        return 'Complete';
      case 4:
        return 'go to payment';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${ApiEndpoints.baseUrl}${item.photoUrl?.replaceAll('http://localhost:5005', '')}',
                width: 80.w,
                height: 60.h,
                fit: BoxFit.cover,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 80.w,
                    height: 60.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        value:
                            loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    'assets/images/placeholder.jpg',
                    width: 80.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      item.productname,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Text(
                      selectedIndex == 4 ? item.comment ?? '' : 'Size ${item.productsize}\n(${item.condition} condition)',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Qty: ${item.productquantity}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Price & Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  selectedIndex == 4 ? item.penaltyAmount ?? '' : '\$${item.finalTotalAmount} (${item.paymentStatus})',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getTagColor(selectedIndex),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        _getText(selectedIndex),
                        style: TextStyle(
                          color: _getTextColor(selectedIndex),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
