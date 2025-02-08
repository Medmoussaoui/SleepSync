import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sleepcyclesapp/controllers/home_screen_controller.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/shimmer_sleep_metric_item.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/sleep_mitrix_item.dart';

class BuildSleepMetrics extends StatelessWidget {
  const BuildSleepMetrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreeController>(
      builder: (con) {
        if (!con.isLoading && con.metrics.isEmpty) {
          return Text(
            "No Data",
            style: AppTextStyles.headline1medium,
          );
        }
        return Wrap(
          spacing: 15, // Spacing between items horizontally
          runSpacing: 15, // Spacing between rows vertically
          children: List.generate(
            con.isLoading ? 4 : con.metrics.length,
            (index) => SizedBox(
              // Key change: Wrap each item in a SizedBox
              width: (MediaQuery.of(context).size.width - 40 - 15) /
                  2, // Calculate width (40 is the horisantal padding and 15 is Wrap.spacing)
              // child: SleepMetricItem(
              //   metricEntity: controller.metrics[index],
              // ),
              child: (con.isLoading
                      ? ShimmerSleepMetricItem()
                      : SleepMetricItem(
                          metricEntity: con.metrics[index],
                        ))
                  .animate(
                      key: Key("${con.isLoading}$index"),
                      delay: (150 * index).ms)
                  .fade()
                  .move(duration: 800.ms, curve: Curves.elasticOut),
            ),
          ),
        );
      },
    );
  }
}
