import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            index: vm.index, // Shows the screen corresponding to the index
            children: [
              HomeScreen(), // tab 0
              HomeScreen(), // tab 0
              HomeScreen(), // tab 0
              HomeScreen(), // tab 0
              HomeScreen(), // tab 0
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
    const bg = Color(0xFF131C24);
    const active = Color(0xFFE33632);
    const inactive = Color(0xFF8A96A3);

    final vm = context.watch<ParentScreenProvider>();

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 84,
          decoration: BoxDecoration(
            color: bg,
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

  const _Item({
    required this.label,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const active = Color(0xFFE33632);
    const inactive = Color(0xFF8A96A3);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adjusted for better icon sizing
            Image.asset(
              activeIcon,
              height: 22.h, // Ensure these are responsive with ScreenUtil
              width: 22.w,
              color: isActive
                  ? active
                  : inactive, // Color change on active/inactive
            ),
            const SizedBox(height: 6),
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
        ),
      ),
    );
  }
}
