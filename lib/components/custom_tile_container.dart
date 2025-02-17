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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1)
                const CustomDivider(), // Add separator except for the last item
            ],
          ],
        ));
  }
}

// ListView.separated(
//         primary: false,
//         shrinkWrap: true,
//         itemCount: children.length,
//         itemBuilder: (_, index) {
//           return children[index];
//         },
//         separatorBuilder: (_, index) {
//           return CustomDivider();
//         },
//       ),
