import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class CustomIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color;
  final bool background;

  const CustomIcon({
    super.key,
    required this.icon,
    this.size = 20,
    this.background = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Image iconWidget = Image.asset(
      icon,
      width: size,
      height: size,
      color: color ?? AppColors.secondaryTextColor,
    );
    if (background) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondaryTextColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: iconWidget),
      );
    }
    return iconWidget;
  }
}
