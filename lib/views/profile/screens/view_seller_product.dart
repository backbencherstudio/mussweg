import 'dart:ui'; //
import 'package:flutter/material.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final bool isBoosted; // show boost icon in stack
  final bool showBoostBottom; // show boost icon at bottom

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.isBoosted = false,
    this.showBoostBottom = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 10),
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 170,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // More options icon
              Positioned(
                top: 7,
                right: 15,
                child: PopupMenuButton<String>(
                  icon: Image.asset(
                    'assets/icons/more_option.png',
                    scale: 2.4,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      print('Edit tapped');
                    } else if (value == 'delete') {
                      print('Delete tapped');
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ),


              // Boost icon (dynamic)
              if (isBoosted)
                Positioned(
                  top: 10,
                  left: 18,
                  child: GestureDetector(
                    onTap: (){},
                    child: Image.asset(
                      'assets/icons/boost.png',
                      scale: 2.4,
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
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xff4A4C56),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Text(
                      'Size XL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff777980),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '(New Condition)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff777980),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Text(
                      'Aug 6 ,13:55',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff777980),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '(12h :12m :30s)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1A9882),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: Color(0xffE9E9EA)),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Color(0xffDE3526),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 25),
                    if (showBoostBottom)
                      Image.asset(
                        'assets/icons/boost_product.png',
                        scale: 3, // works fine here
                      ),
                  ],
                ),
                const SizedBox(height: 4),
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
            labelColor: Colors.red,
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
                        isBoosted: true,
                      ),
                      ProductCard(
                        imageUrl: 'assets/images/card.png',
                        productName: 'Man Exclusive T-Shirt',
                        price: '\$20.00',
                        isBoosted: true,
                      ),
                      ProductCard(
                        imageUrl: 'assets/images/card.png',
                        productName: 'Man Exclusive T-Shirt',
                        price: '\$20.00',
                        showBoostBottom: true,
                      ),
                      ProductCard(
                        imageUrl: 'assets/images/card.png',
                        productName: 'Man Exclusive T-Shirt',
                        price: '\$20.00',
                        showBoostBottom: true,
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
