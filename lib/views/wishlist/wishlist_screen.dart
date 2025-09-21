import 'package:flutter/material.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Wishlist'),
      body: Column(
        children: [
          Text("Wishlist")
        ],
      ),
    );
  }
}