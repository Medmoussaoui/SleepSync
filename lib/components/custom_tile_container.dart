import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/components/custom_divider.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class CustomTileContainer extends StatelessWidget {
  final List<Widget> children;

  const CustomTileContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(13),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: children.length,
        itemBuilder: (_, index) {
          return children[index];
        },
        separatorBuilder: (_, index) {
          return CustomDivider();
        },
      ),
    );
  }
}
