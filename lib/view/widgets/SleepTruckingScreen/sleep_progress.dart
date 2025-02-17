import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sleepcyclesapp/controllers/sleep_tracker_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/format_sleep_duration.dart';
import 'package:sleepcyclesapp/view/widgets/SleepTruckingScreen/cycles_simi_progress.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/total_sleep_duration_widget.dart';

class SleepProgress extends StatelessWidget {
  const SleepProgress({
    super.key,
    required this.controller,
  });

  final SleepTrackerScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<SleepTrackerScreenController>(
          builder: (con) {
            return SemiCircularProgressBar(
              progress: controller.sleepCycleModel.progress,
              completedCycles: controller.sleepCycleModel.completedCycles,
              totalCycles: controller.sleepCycleModel.cycles,
            ).animate(delay: 650.ms).fade();
          },
        ),
        SizedBox(height: 50),
        GetBuilder<SleepTrackerScreenController>(
          builder: (con) {
            return TotalSleepDurationWidget(
              color: AppColors.relaxBlue,
              value:
                  formatDuration(controller.sleepCycleModel.totalSleepDuration),
            );
          },
        ).animate(delay: 800.ms).fade(),
      ],
    );
  }
}
