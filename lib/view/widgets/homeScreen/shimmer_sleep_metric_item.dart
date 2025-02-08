import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/components/shimmer.dart';
import 'package:sleepcyclesapp/utils/colors.dart';

class ShimmerSleepMetricItem extends StatelessWidget {
  const ShimmerSleepMetricItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // CustomIcon(icon: metricEntity.symbol),
          CustomShimmerWidget.rectangle(
            height: 18,
            width: 18,
            baseColor: AppColors.white.withOpacity(0.1),
            radius: 5,
          ),
          SizedBox(height: 10),
          CustomShimmerWidget.rectangle(
            height: 20,
            baseColor: AppColors.white.withOpacity(0.15),
            radius: 5,
          ),
          SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: CustomShimmerWidget.rectangle(
              height: 10,
              baseColor: AppColors.white.withOpacity(0.1),
              radius: 5,
            ),
          ),
        ],
      ),
    );
  }
}
