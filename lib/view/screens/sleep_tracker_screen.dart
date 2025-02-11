import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/current_time_widget.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/sleep_progress_ndicator.dart';
import 'package:sleepcyclesapp/components/swipe_up_widget.dart';
import 'package:sleepcyclesapp/components/text_with_icon.dart';
import 'package:sleepcyclesapp/controllers/sleep_tracker_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/expected_wakeup_time.dart';
import 'package:sleepcyclesapp/utils/functions/format_sleep_duration.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/total_sleep_duration_widget.dart';

class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SleepTrackerScreenController());
    return Scaffold(
      // backgroundColor: AppColors.relaxBlack,
      backgroundColor: Colors.black,
      body: SwipeUp(
        textColor: AppColors.relaxGrey,
        text: "Swipe up to stop tracking",
        onSwipe: () {},
        child: Stack(
          children: [
            // BackgroundImageTimeState()
            //     .animate(delay: 200.ms)
            //     .fade(duration: 1000.ms, curve: Curves.easeInOut),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 30),
                      child: CurrentTimeWidget(
                        style: AppTextStyles.subtitle3Light.copyWith(
                          fontSize: 40,
                          color: AppColors.relaxGrey.withOpacity(0.4),
                        ),
                      ).animate().fade(),
                    ),
                    Text(
                      "Relax and sleep well",
                      style: AppTextStyles.subtitle1Regular.copyWith(
                        color: AppColors.relaxGrey,
                      ),
                    ).animate().fade(duration: 700.ms),

                    SizedBox(height: 3),
                    ExpectedWakeupTime(
                      cycles: controller.sleepCycleModel.cycles,
                      bedTime: controller.sleepCycleModel.date,
                      avgSleepAfter: 25,
                      iconColor: AppColors.relaxGrey.withOpacity(0.8),
                      style: AppTextStyles.subtitle3Light.copyWith(
                        color: AppColors.relaxGrey.withOpacity(0.8),
                      ),
                    ).animate(delay: 400.ms).fade().moveY(begin: 8, end: 0),
                    SizedBox(height: 30),
                    GetBuilder<SleepTrackerScreenController>(
                      builder: (con) {
                        return SemiCircularProgressBar(
                          progress: controller.sleepCycleModel.progress,
                          completedCycles:
                              controller.sleepCycleModel.completedCycles,
                          totalCycles: controller.sleepCycleModel.cycles,
                        ).animate(delay: 650.ms).fade();
                      },
                    ),
                    SizedBox(height: 45),
                    GetBuilder<SleepTrackerScreenController>(
                      builder: (con) {
                        return TotalSleepDurationWidget(
                          value: formatDuration(
                              controller.sleepCycleModel.totalSleepDuration),
                        );
                      },
                    ).animate(delay: 800.ms).fade(),
                    // SwipeUpWidget(
                    //   text: "Swipe up to stop tracking",
                    //   onSwipe: () {
                    //     print("---------> User Swipe Up");
                    //   },
                    // ),
                    // CustomIcon(
                    //   icon: AppIcons.swipeup,
                    //   color: AppColors.secondaryTextColor.withOpacity(0.2),
                    //   size: 25,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExpectedWakeupTime extends StatelessWidget {
  final int cycles;
  final int avgSleepAfter;
  final DateTime bedTime;
  final TextStyle? style;
  final Color? iconColor;

  const ExpectedWakeupTime({
    super.key,
    required this.cycles,
    required this.avgSleepAfter,
    required this.bedTime,
    this.style,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextWithIcon(
      style: style ??
          AppTextStyles.subtitle3Light.copyWith(
            color: AppColors.secondaryTextColor.withOpacity(0.8),
          ),
      text: getExpectedWakeUpTime(bedTime, cycles, Duration(minutes: 25)),
      icon: CustomIcon(
        size: 13,
        icon: AppIcons.timer,
        color: iconColor ?? AppColors.secondaryTextColor.withOpacity(0.8),
      ),
    );
  }
}
