import 'dart:ui'; //
import 'package:flutter/material.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Aug 6, 13:55',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.red, size: 8),
                        const SizedBox(width: 4),
                        const Text(
                          'Boost product',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SellerProfilePage extends StatefulWidget {
  const SellerProfilePage({Key? key}) : super(key: key);

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'View Profile'),
      body: Column(
        children: [
          // Profile Header
          SizedBox(
            height: 280,
            child: Stack(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/cover.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 16,
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/user_profile.png',
                        fit: BoxFit.cover, // fills the box
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                ),


            Positioned(
            bottom: 120,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // blur intensity
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // semi-transparent
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Change Cover',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
                 top: 190,
                  left: 160,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cameron Williamson',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff4A4C56)
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange.shade300, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '5.0',
                            style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xff777980)),
                          ),
                          Text(
                            ' 86 Reviewers',
                            style: TextStyle(color: Color(0xff777980)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Image.asset('assets/icons/location.png',scale: 3,),
                          const SizedBox(width: 6),
                          const Text(
                            'Switzerland',
                            style: TextStyle(color: Color(0xff777980)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.red,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Closet'),
              Tab(text: 'Reviews'),
            ],
          ),

          // Tab Bar Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Closet Tab
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                    children: const [
                      ProductCard(
                        imageUrl: 'assets/images/card.png',
                        productName: 'Man Exclusive T-Shirt',
                        price: '\$20.00',
                      ),
                      ProductCard(
                        imageUrl: 'assets/images/card.png',
                        productName: 'Man Exclusive T-Shirt',
                        price: '\$20.00',
                      ),
                      ProductCard(
                        imageUrl: 'assets/images/card.png',
                        productName: 'Man Exclusive T-Shirt',
                        price: '\$20.00',
                      ),
                      ProductCard(
                        imageUrl: 'assets/images/card.png',
                        productName: 'Man Exclusive T-Shirt',
                        price: '\$20.00',
                      ),
                    ],
                  ),
                ),

                // Reviews Tab
                const Center(child: Text('Reviews Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
