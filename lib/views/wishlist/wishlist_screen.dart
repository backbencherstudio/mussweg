import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Wishlist'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Favourite List", style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),),
          ListView.builder(itemBuilder: (context, index) {
            return Container(

            );
          })
        ],
      ),
    );
  }
}