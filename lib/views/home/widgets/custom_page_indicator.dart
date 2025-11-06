import 'package:flutter/material.dart';

class CustomPageIndicator extends StatefulWidget {
  final PageController controller;
  final int count;
  final Color activeColor;
  final Color inactiveColor;
  final double activeSize;
  final double inactiveSize;
  final double spacing;

  const CustomPageIndicator({
    super.key,
    required this.controller,
    required this.count,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.activeSize = 12,
    this.inactiveSize = 8,
    this.spacing = 8,
  });

  @override
  State<CustomPageIndicator> createState() => _CustomPageIndicatorState();
}

class _CustomPageIndicatorState extends State<CustomPageIndicator> {
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _currentPage = widget.controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.count, (index) {
        bool isActive = (_currentPage.round() == index);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          width: isActive ? widget.activeSize : widget.inactiveSize,
          height: isActive ? widget.activeSize : widget.inactiveSize,
          decoration: BoxDecoration(
            color: isActive ? widget.activeColor : widget.inactiveColor,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}
