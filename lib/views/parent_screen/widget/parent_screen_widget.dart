import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/parent_provider/parent_screen_provider.dart';

class ParentScreenWidget extends StatelessWidget {
  const ParentScreenWidget({super.key});

  static const _tabs = [
    {'iconPath': 'assets/icons/home.png'},
    {'iconPath': 'assets/icons/favorite.png'},
    {'iconPath': 'assets/icons/foller.png'},
    {'iconPath': 'assets/icons/chat.png'},
    {'iconPath': 'assets/icons/profile.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 70.h,
      width: double.infinity,
      // padding: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: Color(0xffDE3526),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          _tabs.length,
          (index) => Expanded(
            child: _TabButton(
              index: index,
              iconPath: _tabs[index]['iconPath']!,
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final int index;
  final String iconPath;

  const _TabButton({required this.index, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentScreensProvider>(
      builder: (_, provider, __) {
        final isSelected = provider.selectedIndex == index;

        return GestureDetector(
          onTap: () =>
              context.read<ParentScreensProvider>().onSelectedIndex(index),
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: index == 2 ? Colors.white : Colors.transparent, width: 5.w)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  width: (index == 2) ? 32.w : 24.w,
                  height: (index == 2) ? 32.h : 24.h,
                  color: (index == 2)
                      ? null
                      : isSelected
                      ? Color(0xffFFFFFF)
                      : Color(0xffF5C0BC),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
