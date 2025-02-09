import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/sleep_progress_ndicator.dart';
import 'package:sleepcyclesapp/components/text_with_icon.dart';
import 'package:sleepcyclesapp/controllers/background_image.dart';
import 'package:sleepcyclesapp/controllers/sleep_tracker_controller.dart';
import 'package:sleepcyclesapp/utils/animations.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
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
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          BackgroundImageTimeState()
              .animate(delay: 200.ms)
              .fade(duration: 1000.ms, curve: Curves.easeInOut),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                    child: CurrentTimeWidget(),
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        "Relax and sleep well",
                        textStyle: AppTextStyles.subtitle1Regular,
                        speed: 50.ms,
                      ),
                    ],
                  ).animate().fade(duration: 700.ms),

                  SizedBox(height: 3),
                  ExpectedWakeupTime(),
                  SizedBox(height: 30),
                  SemiCircularProgressBar(
                    progress: controller.sleepCycleModel.progress,
                    completedCycles: controller.sleepCycleModel.completedCycles,
                    totalCycles: controller.sleepCycleModel.cycles,
                  ),
                  SizedBox(height: 45),
                  TotalSleepDurationWidget(
                    value: formatDuration(Duration.zero),
                  ),
                  Spacer(),
                  SwipeUpWidget(
                    text: "Swipe up to stop tracking",
                    onSwipe: () {},
                  ),
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
    );
  }
}

class SwipeUpWidget extends StatelessWidget {
  final String text;
  final Function onSwipe;

  const SwipeUpWidget({
    super.key,
    required this.text,
    required this.onSwipe,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, 40),
      child: Column(
        children: [
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                text,
                textStyle: AppTextStyles.subtitle2Regular.copyWith(
                  color: AppColors.secondaryTextColor.withOpacity(0.2),
                  fontSize: 14.0,
                ),
                colors: [
                  AppColors.secondaryTextColor.withOpacity(0.5),
                  AppColors.secondaryTextColor.withOpacity(0.1),
                ],
              )
            ],
          ),
          Lottie.asset(
            AppAnimatedIcons.swipeup,
            height: 90,
          ),
        ],
      ),
    );
  }
}

class ExpectedWakeupTime extends StatelessWidget {
  const ExpectedWakeupTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextWithIcon(
      style: AppTextStyles.subtitle3Light.copyWith(
        color: AppColors.secondaryTextColor.withOpacity(0.8),
      ),
      text: "6:30 -7:00 AM",
      icon: CustomIcon(
        size: 13,
        icon: AppIcons.timer,
        color: AppColors.secondaryTextColor.withOpacity(0.8),
      ),
    );
  }
}

class CurrentTimeWidget extends StatelessWidget {
  const CurrentTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "10:25",
      style: AppTextStyles.subtitle3Light.copyWith(
        fontSize: 40,
        color: AppColors.white.withOpacity(0.4),
      ),
    );
  }
}
