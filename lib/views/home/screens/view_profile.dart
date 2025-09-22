import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/widgets/seller_profile_refresh.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        title: const Text(
          "View Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [Icon(Icons.more_horiz, color: Colors.black)],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/banner.png", width: double.infinity),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Image.asset("assets/images/user_2.png", scale: 0.5),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Cameron Williamson",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 4),
                        Text("5.0", style: TextStyle(fontSize: 14)),
                        SizedBox(width: 6),
                        Text(
                          "(86 Reviews)",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.grey, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "Switzerland",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Navigate to the message screen
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: const Text(
                      "Message",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tabs
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.red,
                    tabs: [
                      Tab(text: 'Closet'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 350, // fixed height for TabBarView
                  child: TabBarView(
                    children: [
                      // Closet Tab
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.56,
                            ),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      "assets/images/shirt.png",
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Men Exclusive T-Shirt",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Size XL (New Condition)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "\$20.00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.favorite_border),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.shopping_cart),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // Reviews Tab → Use your SellerProfileRefresh widget
                      ListView(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        children: const [
                          SellerProfileRefresh(
                            title: 'Floyd Miles',
                            time: '2hr ago',
                            avatarUrl: 'assets/icons/user_profile.png',
                            message: 'Fast shipping! Thank you!!',
                          ),
                          SellerProfileRefresh(
                            title: 'Esther Howard',
                            time: '5hr ago',
                            avatarUrl: 'assets/icons/user_profile.png',
                            message: 'Shipped very fast, great communication. Only wish the material was listed because I’m not sure I would have bought it',
                          ),
                          SellerProfileRefresh(
                            title: 'Jacob Jones',
                            time: '1 day ago',
                            avatarUrl: 'assets/icons/user_profile.png',
                            message: 'Shipped very fast, great communication. Only wish the material was listed because I’m not sure I would have bought it',
                          ),
                          SellerProfileRefresh(
                            title: 'Kristin Watson',
                            time: '2 days ago',
                            avatarUrl: 'assets/icons/user_profile.png',
                            message: 'Fast shipping! Thank you!!',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
