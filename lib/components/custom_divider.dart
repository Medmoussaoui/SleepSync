import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class CustomDivider extends StatelessWidget {
  final double vertialPadding;

  const CustomDivider({
    super.key,
    this.vertialPadding = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: vertialPadding,
      color: AppColors.secondaryTextColor.withOpacity(0.15),
    );
  }
}
