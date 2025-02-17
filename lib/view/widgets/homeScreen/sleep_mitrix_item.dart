import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/entitys/sleep_metric_entity.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class SleepMetricItem extends StatelessWidget {
  final SleepMetricEntity metricEntity;

  const SleepMetricItem({super.key, required this.metricEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIcon(icon: metricEntity.symbol),
          SizedBox(height: 10),
          Text(
            metricEntity.value,
            style: AppTextStyles.headline4medium.copyWith(),
          ),
          SizedBox(height: 7),
          Text(
            metricEntity.mitrixName,
            style: AppTextStyles.subtitle4Regular,
          ),
        ],
      ),
    );
  }
}
