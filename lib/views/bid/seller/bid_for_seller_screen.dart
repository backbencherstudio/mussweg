import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/core/routes/route_names.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../view_model/bid/bid_for_seller_provider.dart';
import '../../../view_model/bid/place_a_bid_provider.dart';

class BidForSellerScreen extends StatefulWidget {
  const BidForSellerScreen({super.key});

  @override
  State<BidForSellerScreen> createState() => _BidForSellerScreenState();
}

class _BidForSellerScreenState extends State<BidForSellerScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<BidForSellerProvider>().getRequestedBidsForSeller();
      await context.read<BidForSellerProvider>().getAcceptedBidsForSeller();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Bid List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          tabs: const [Tab(text: 'Request Bid'), Tab(text: 'Accept bid')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestedBidListWithRefresh(),
          _buildAcceptedBidListWithRefresh(),
        ],
      ),
    );
  }

  /// RefreshIndicator for Requested Bids
  Widget _buildRequestedBidListWithRefresh() {
    return Consumer<BidForSellerProvider>(
      builder: (_, bidSellerProvider, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await bidSellerProvider.getRequestedBidsForSeller();
            await bidSellerProvider.getAcceptedBidsForSeller();
          },
          child: _buildRequestedBidList(),
        );
      },
    );
  }

  /// RefreshIndicator for Accepted Bids
  Widget _buildAcceptedBidListWithRefresh() {
    return Consumer<BidForSellerProvider>(
      builder: (_, bidSellerProvider, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await bidSellerProvider.getRequestedBidsForSeller();
            await bidSellerProvider.getAcceptedBidsForSeller();
          },
          child: _buildAcceptedBidList(),
        );
      },
    );
  }

  Widget _buildAcceptedBidList() {
    return Consumer<BidForSellerProvider>(
      builder: (_, bidSellerProvider, __) {
        if (bidSellerProvider.isLoading2) {
          return const Center(child: CircularProgressIndicator());
        }
        if (bidSellerProvider.acceptedBidForSellerResponseModel?.data.data.isEmpty ??
            true) {
          return const Center(child: Text('No bids found'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount:
          bidSellerProvider.acceptedBidForSellerResponseModel?.data.data.length,
          itemBuilder: (context, index) {
            final item =
            bidSellerProvider.acceptedBidForSellerResponseModel?.data.data[index];
            return BidCardForSeller(
              productId: item?.product.id ?? '',
              productTitle: item?.product.title ?? '',
              size: item?.product.size ?? '',
              condition: item?.product.condition ?? '',
              price: item?.product.price ?? '',
              photo: item?.product.photo ?? '',
              bidAmount: item?.bidAmount ?? '',
              isAccepted: true,
            );
          },
        );
      },
    );
  }

  Widget _buildRequestedBidList() {
    return Consumer<BidForSellerProvider>(
      builder: (_, bidSellerProvider, __) {
        if (bidSellerProvider.isLoading1) {
          return const Center(child: CircularProgressIndicator());
        }
        if (bidSellerProvider.requestBidForSellerResponseModel?.data.data.isEmpty ??
            true) {
          return const Center(child: Text('No bids found'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount:
          bidSellerProvider.requestBidForSellerResponseModel?.data.data.length,
          itemBuilder: (context, index) {
            final item =
            bidSellerProvider.requestBidForSellerResponseModel?.data.data[index];
            return BidCardForSeller(
              productId: item?.product.id ?? '',
              productTitle: item?.product.title ?? '',
              size: item?.product.size ?? '',
              condition: item?.product.condition ?? '',
              price: item?.product.price ?? '',
              photo: item?.product.photo ?? '',
              isAccepted: false,
            );
          },
        );
      },
    );
  }
}

class BidCardForSeller extends StatelessWidget {
  const BidCardForSeller({
    super.key,
    required this.isAccepted,
    required this.productTitle,
    required this.productId,
    required this.size,
    required this.condition,
    required this.price,
    required this.photo,
    this.bidAmount,
  });

  final String productTitle;
  final String productId;
  final String size;
  final String condition;
  final String price;
  final String photo;
  final String? bidAmount;
  final bool isAccepted;

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
                '${ApiEndpoints.baseUrl}${photo.replaceAll('http://localhost:5005', '')}',
                width: 80.w,
                height: 60.h,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 80.w,
                    height: 60.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
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
                      productTitle,
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
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      'Size $size ($condition condition)',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            // Price & Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isAccepted ? '\$$bidAmount' : '\$$price',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                isAccepted
                    ? SizedBox()
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(80, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    context.read<PlaceABidProvider>().getAllBidsForProduct(productId ?? '');
                    Navigator.pushNamed(context, RouteNames.bidList);
                  },
                  child: const Text(
                    'View Bid',
                    style: TextStyle(color: Colors.white, fontSize: 13),
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
