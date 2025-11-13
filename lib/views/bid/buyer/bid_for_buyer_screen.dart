import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/routes/route_names.dart';
import '../../../view_model/bid/bid_for_buyer_provider.dart';

class BidForBuyerScreen extends StatefulWidget {
  const BidForBuyerScreen({super.key});

  @override
  State<BidForBuyerScreen> createState() => _BidForBuyerScreenState();
}

class _BidForBuyerScreenState extends State<BidForBuyerScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<BidForBuyerProvider>();
      await provider.getAcceptedBidsForBuyer();
      await provider.getOnProgressBidsForBuyer();
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
          onPressed: () => Navigator.pop(context),
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
          tabs: const [
            Tab(text: 'Accepted Bids'),
            Tab(text: 'On Process Bids'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAcceptedBidListWithRefresh(),
          _buildOnProcessBidListWithRefresh(),
        ],
      ),
    );
  }

  /// Refresh for Accepted Bids
  Widget _buildAcceptedBidListWithRefresh() {
    return Consumer<BidForBuyerProvider>(
      builder: (_, provider, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getAcceptedBidsForBuyer();
            await provider.getOnProgressBidsForBuyer();
          },
          child: _buildAcceptedBidList(provider),
        );
      },
    );
  }

  /// Refresh for On Progress Bids
  Widget _buildOnProcessBidListWithRefresh() {
    return Consumer<BidForBuyerProvider>(
      builder: (_, provider, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getAcceptedBidsForBuyer();
            await provider.getOnProgressBidsForBuyer();
          },
          child: _buildOnProgressBidList(provider),
        );
      },
    );
  }

  Widget _buildAcceptedBidList(BidForBuyerProvider provider) {
    if (provider.isLoadingAccepted) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.acceptedBidsForBuyerModel?.data.bids.isEmpty ?? true) {
      return const Center(child: Text('No accepted bids found'));
    }

    final items = provider.acceptedBidsForBuyerModel!.data.bids;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return BidCardForBuyer(
          isAccepted: true,
          productTitle: item.product.productTitle,
          size: item.product.size,
          condition: item.product.condition,
          price: item.bidAmount,
          photo: item.product.photo ?? '',
        );
      },
    );
  }

  Widget _buildOnProgressBidList(BidForBuyerProvider provider) {
    if (provider.isLoadingOnProgress) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.onProgressBidsForBuyerModel?.data.bids.isEmpty ?? true) {
      return const Center(child: Text('No bids in process'));
    }

    final items = provider.onProgressBidsForBuyerModel!.data.bids;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return BidCardForBuyer(
          isAccepted: false,
          productTitle: item.product.productTitle,
          size: item.product.size,
          condition: item.product.condition,
          price: item.bidAmount,
          photo: item.product.photo ?? '',
        );
      },
    );
  }
}

class BidCardForBuyer extends StatelessWidget {
  const BidCardForBuyer({
    super.key,
    required this.isAccepted,
    required this.productTitle,
    required this.size,
    required this.condition,
    required this.price,
    required this.photo,
  });

  final bool isAccepted;
  final String productTitle;
  final String size;
  final String condition;
  final String price;
  final String photo;

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.baseUrl}${photo.replaceAll('http://localhost:5005', '')}';

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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  photo.isEmpty
                      ? Image.asset(
                        'assets/images/placeholder.jpg',
                        width: 80.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      )
                      : Image.network(
                        imageUrl,
                        width: 80.w,
                        height: 60.h,
                        fit: BoxFit.cover,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Size $size ($condition condition)',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$$price',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isAccepted ? Colors.red : Colors.grey.shade200,
                    minimumSize: const Size(80, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (isAccepted) {
                      Navigator.pushNamed(context, RouteNames.cartScreen);
                    }
                  },
                  child: Text(
                    isAccepted ? 'Add to cart' : 'Requesting',
                    style: TextStyle(
                      color: isAccepted ? Colors.white : Colors.grey.shade600,
                      fontSize: 12,
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
