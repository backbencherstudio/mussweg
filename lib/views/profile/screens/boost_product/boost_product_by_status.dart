import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import '../../../../view_model/boost_product/boost_product_create_provider.dart';
import '../../model/boost_data_model.dart';

class BoostProductByStatus extends StatefulWidget {
  const BoostProductByStatus({super.key});

  @override
  State<BoostProductByStatus> createState() => _BoostProductByStatusState();
}

class _BoostProductByStatusState extends State<BoostProductByStatus> {
  final List<String> tabs = ['PENDING', 'ACTIVE', 'EXPIRED'];
  int selectedIndex = 0;
  final BoostProductCreateProvider _boostProvider =
      BoostProductCreateProvider();

  // Store data for each tab
  final Map<String, BoostDataModel?> _boostData = {
    'PENDING': null,
    'ACTIVE': null,
    'EXPIRED': null,
  };

  final Map<String, bool> _loading = {
    'PENDING': false,
    'ACTIVE': false,
    'EXPIRED': false,
  };

  final Map<String, String> _error = {
    'PENDING': '',
    'ACTIVE': '',
    'EXPIRED': '',
  };

  @override
  void initState() {
    super.initState();
    // Load initial tab data
    _loadBoostData(tabs[selectedIndex]);
  }

  Future<void> _loadBoostData(String status) async {
    // Don't reload if already loading or has data
    if (_loading[status] == true) return;

    setState(() {
      _loading[status] = true;
      _error[status] = '';
    });

    final success = await _boostProvider.getBoostProductByStatus(status);

    setState(() {
      _loading[status] = false;
      if (success) {
        _boostData[status] = _boostProvider.boostDataModel;
      } else {
        _error[status] = 'Failed to load $status boosts';
      }
    });
  }

  Widget _buildEmptyState(String status) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bolt_outlined, size: 80.sp, color: Colors.grey.shade400),
          SizedBox(height: 16.h),
          Text(
            'No $status boosts found',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your $status boosts will appear here',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String status) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60.sp, color: Colors.red.shade400),
          SizedBox(height: 16.h),
          Text(
            _error[status]!,
            style: TextStyle(fontSize: 14.sp, color: Colors.red.shade600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => _loadBoostData(status),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Data item, String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'PENDING':
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        break;
      case 'ACTIVE':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        break;
      case 'EXPIRED':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;
      default:
        bgColor = Colors.grey.shade300;
        textColor = Colors.black87;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child:
                    item.photo?.isNotEmpty == true
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            item.photo!.first,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 30.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
              ),

              SizedBox(width: 12.w),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      item.title ?? 'Untitled Product',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 6.h),

                    // Price
                    Text(
                      '\$${item.price ?? '0.00'}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.red.shade600,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    // Condition and Size
                    Row(
                      children: [
                        if (item.condition != null &&
                            item.condition!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              item.condition!,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        SizedBox(width: 6.w),
                        if (item.size != null && item.size!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              item.size!,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.purple.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    if (item.boostStartTime != null)
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              _formatDateTime(item.boostStartTime!),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),

                    SizedBox(height: 8.h),

                    // Status Badge
                    // Status Badge with Payment Button for PENDING items
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            item.boostStatus ?? status,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        SizedBox(width: 8.w),

                        if (status == "PENDING")
                          SizedBox(
                            height: 30.h,
                            child: ElevatedButton(
                              onPressed: () {
                                debugPrint("The boost Id is ${item.id}");
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.boostProductPayment,
                                  arguments: item.id,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade600,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                elevation: 0,
                              ),
                              child: Text(
                                "Go to Payment",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStatus = tabs[selectedIndex];
    final isLoading = _loading[currentStatus] == true;
    final data = _boostData[currentStatus];
    final hasError = _error[currentStatus]?.isNotEmpty == true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Boosted Products',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // ========================== TABS ==========================
            SizedBox(
              height: 35.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  final bool isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                      _loadBoostData(tabs[index]);
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
                          tabs[index],
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                isSelected
                                    ? Colors.red.shade600
                                    : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            // ======================= PRODUCT LIST ======================
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : hasError
                      ? _buildErrorState(currentStatus)
                      : data?.data == null || data!.data!.isEmpty
                      ? _buildEmptyState(currentStatus)
                      : RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            _boostData[currentStatus] = null;
                          });
                          await _loadBoostData(currentStatus);
                        },
                        child: ListView.builder(
                          itemCount: data.data!.length,
                          itemBuilder: (context, index) {
                            final item = data.data![index];
                            return _buildProductCard(item, currentStatus);
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
