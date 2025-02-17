import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sleepcyclesapp/Data/sleep_stages.dart';
import 'package:sleepcyclesapp/controllers/sleep_tracker_controller.dart';
import 'package:sleepcyclesapp/utils/animations.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class LiseningMode extends GetView<SleepTrackerScreenController> {
  const LiseningMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 250,
          child: Opacity(
            opacity: 0.6,
            child: Lottie.asset(
              AppAnimatedIcons.threeBollets,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    ['**'],
                    value: AppColors.relaxWhite,
                  )
                ],
              ),
            ),
          ),
        ).animate(delay: 650.ms).fade(),
        Obx(
          () {
            final stage = controller.trackerService.sleepStage.value;
            return Text(
              key: ValueKey(stage.name),
              sleepStageDescriptions[stage]!,
              style: AppTextStyles.headline3medium.copyWith(
                color: AppColors.relaxBlue,
              ),
            ).animate(delay: 300.ms).fade().scale(
                  begin: Offset(0.8, 0.8), // Start at 80% size
                  end: Offset(1, 1), // Scale to 100% size
                  duration: 500.ms, // Animation duration
                );
          },
        ),
      ],
    );
  }
}
