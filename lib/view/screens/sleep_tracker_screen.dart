import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/sleep_stages.dart';
import 'package:sleepcyclesapp/components/CustomTouchScreenLisener/widget.dart';
import 'package:sleepcyclesapp/components/current_time_widget.dart';
import 'package:sleepcyclesapp/components/screen_lifecycle_state.dart';
import 'package:sleepcyclesapp/components/swipe_up_widget.dart';
import 'package:sleepcyclesapp/controllers/sleep_tracker_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';
import 'package:sleepcyclesapp/view/widgets/SleepTruckingScreen/expected_wake_up_time.dart';
import 'package:sleepcyclesapp/view/widgets/SleepTruckingScreen/lisening_mode.dart';
import 'package:sleepcyclesapp/view/widgets/SleepTruckingScreen/sleep_progress.dart';

class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SleepTrackerScreenController());
    return CustomTouchScreenLisener(
      child: ScreenLifeCycleState(
        controller: controller.screenLifeState,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: WillPopScope(
            onWillPop: () async => false,
            child: SwipeUp(
              textColor: AppColors.relaxGrey,
              text: "Swipe up to end",
              onSwipe: () {
                controller.stopTracking();
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
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
                              color: AppColors.relaxWhite.withOpacity(0.6),
                            ),
                          ).animate().fade(duration: 700.ms),
                          SizedBox(height: 4.5),
                          ExpectedWakeupTime(
                            cycles: controller.sleepCycleModel.cycles,
                            bedTime: controller.sleepCycleModel.date,
                            avgSleepAfter: 25,
                            iconColor: AppColors.relaxGrey.withOpacity(0.6),
                            style: AppTextStyles.subtitle3Light.copyWith(
                              fontSize: 15.0,
                              color: AppColors.relaxGrey.withOpacity(0.6),
                            ),
                          )
                              .animate(delay: 400.ms)
                              .fade()
                              .moveY(begin: 8, end: 0),
                          SizedBox(height: 30),
                          GetBuilder<SleepTrackerScreenController>(
                              builder: (context) {
                            return AnimatedSwitcher(
                              duration: 400.ms,
                              child: Builder(
                                builder: (_) {
                                  final stage = controller
                                      .trackerService.sleepStage.value;
                                  if (stage == SleepStages.asleep) {
                                    return SleepProgress(
                                      controller: controller,
                                    );
                                  }
                                  return LiseningMode();
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
