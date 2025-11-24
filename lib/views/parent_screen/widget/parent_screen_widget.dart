import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/parent_provider/parent_screen_provider.dart';

class ParentScreenWidget extends StatelessWidget {
  const ParentScreenWidget({super.key});

  static const _tabs = [
    {'iconPath': 'assets/icons/home.png', 'label': 'Home'},
    {'iconPath': 'assets/icons/favorite.png', 'label': 'Wishlist'},
    {'iconPath': 'assets/icons/dollar.png', 'label': ''},
    {'iconPath': 'assets/icons/chat.png', 'label': 'Inbox'},
    {'iconPath': 'assets/icons/profile.png', 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom navigation container
          Container(
            height: 70.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: const Color(0xffDE3526),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _tabs.length,
                    (index) => index == 2
                    ? const SizedBox(width: 60)
                    : Expanded(
                  child: _TabButton(
                    index: index,
                    iconPath: _tabs[index]['iconPath']!,
                    text: _tabs[index]['label']!,
                  ),
                ),
              ),
            ),
          ),

          // Center floating tab
          Positioned(
            bottom: 24.h,
            child: _CenterTabButton(
              index: 2,
              iconPath: _tabs[2]['iconPath']!,
              text: _tabs[2]['label']!,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final int index;
  final String text;
  final String iconPath;

  const _TabButton({
    required this.index,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentScreensProvider>(
      builder: (_, provider, __) {
        final isSelected = provider.selectedIndex == index;

        return GestureDetector(
          onTap: () =>
              context.read<ParentScreensProvider>().onSelectedIndex(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 24.w,
                height: 24.h,
                color:
                isSelected ? const Color(0xffFFFFFF) : const Color(0xffF5C0BC),
              ),
              SizedBox(height: 4.h),
              Text(
                text,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: isSelected ? Colors.white : const Color(0xffF5C0BC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CenterTabButton extends StatelessWidget {
  final int index;
  final String iconPath;
  final String text;

  const _CenterTabButton({
    required this.index,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentScreensProvider>(
      builder: (_, provider, __) {
        final isSelected = provider.selectedIndex == index;

        return GestureDetector(
          onTap: () =>
              context.read<ParentScreensProvider>().onSelectedIndex(index),
          child: Container(
            height: 70.w,
            width: 70.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffDE3526),
              border: Border.all(color: Colors.white, width: 5.w),
            ),
            child: Icon(Icons.add, size: 32.h, color: Colors.white,),
          ),
        );
      },
    );
  }
}
