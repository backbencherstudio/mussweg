import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/profile/screen.dart';
import 'package:mussweg/views/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import '../../../view_model/parent_provider/parent_screen_provider.dart';
import '../../home/screen/home_screen.dart';

class ParentScreen extends StatelessWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ParentScreenProvider>(
        builder: (_, vm, __) {
          return IndexedStack(
            index: vm.index,
            children: [
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
              WishlistScreen(),
              ProfileScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    const active = Color(0xFFFFFFFF);
    const inactive = Color(0xFF8A96A3);

    final vm = context.watch<ParentScreenProvider>();

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          clipBehavior:Clip.none,
          height: 84,
          decoration: BoxDecoration(
            color: Color(0xffDE3526),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                color: active.withOpacity(0.4),
              ), // top red line
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Item(
                      label: 'Home',
                      activeIcon: 'assets/icons/home.png',
                      isActive: vm.index == 0,
                      onTap: () => vm.setIndex(0),
                    ),
                    _Item(
                      label: 'Wishlist',
                      activeIcon: 'assets/icons/favorite.png',
                      isActive: vm.index == 1,
                      onTap: () => vm.setIndex(1),
                    ),
                    _Item(
                      label: 'Dollar',
                      activeIcon: 'assets/icons/foller.png',
                      isActive: vm.index == 2,
                      onTap: () => vm.setIndex(2),
                      isDollar: true,
                    ),
                    _Item(
                      label: 'Chat',
                      activeIcon: 'assets/icons/chat.png',
                      isActive: vm.index == 3,
                      onTap: () => vm.setIndex(3),
                    ),
                    _Item(
                      label: 'Profile',
                      activeIcon: 'assets/icons/profile.png',
                      isActive: vm.index == 4,
                      onTap: () => vm.setIndex(4),
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
}

class _Item extends StatelessWidget {
  final String label;
  final String activeIcon;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDollar;

  const _Item({
    required this.label,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
    this.isDollar = false,
  });

  @override
  Widget build(BuildContext context) {
    const active = Color(0xFFFFFFFF);
    const inactive = Color(0xFF8A96A3);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isDollar)
              Transform.translate(
                offset: Offset(0, -30),
                child: Container(
                  width: 55.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 7),
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),

                  child: Center(
                    child: Image.asset(
                      activeIcon,
                      width: 30.w,
                      height: 30.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (!isDollar) ...[
              Image.asset(
                activeIcon,
                height: 22.h,
                width: 22.w,
                color: isActive ? active : inactive,
              ),
              SizedBox(height: 6.h),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive ? active : inactive,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
