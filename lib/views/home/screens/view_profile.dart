import 'package:flutter/material.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        title: Text("View Profile", style: TextStyle(color: Colors.black)),
        actions: [Icon(Icons.more_horiz, color: Colors.black)],
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
                  offset: Offset(0, -40),
                  child: Image.asset("assets/images/user_2.png", scale: 0.5),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cameron Williamson",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
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
                    SizedBox(height: 6),
                    Row(
                      children: [
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
                Spacer(),
                // Message Button
                GestureDetector(
                  onTap: () {
                    // Navigate to the message screen
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      "Message",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TabBar(
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
                SizedBox(height: 10),
                SizedBox(
                  height: 350,
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              padding: EdgeInsets.all(8),
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
                                      "assets/images/shirt.png", // Replace with product image
                                      width: double.infinity,
                                      height:
                                          120, // Adjust height to fit the grid
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Men Exclusive T-Shirt",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Size XL (New Condition)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "\$20.00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  // Favorite Icon and Cart Icon
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.favorite_border),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.shopping_cart),
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
                      // Reviews Tab
                      Center(child: Text("Reviews Section (Coming Soon)")),
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
