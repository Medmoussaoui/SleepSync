import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/clock.dart';
import 'package:sleepcyclesapp/controllers/begin_cycles_screen_controller.dart';
import 'package:sleepcyclesapp/utils/functions/calculate_wakeup_time.dart';
import 'package:sleepcyclesapp/utils/functions/format_cycle_number.dart';
import 'package:sleepcyclesapp/utils/music_player.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class SelectSleepCycles extends GetView<BeginCyclesScreenController> {
  const SelectSleepCycles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClockCounter(
          max: 12,
          min: 1,
          onMoving: (v) {},
          onDone: (v) {
            AppAudioPlayer.playFromAsset(AppSounds.tick,volume: 0.1);
          },
          onChange: (v) => controller.setCycles(v),
          initialValue: controller.cycles,
        ),
        GetBuilder<BeginCyclesScreenController>(
          builder: (con) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cycles",
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  style: AppTextStyles.subtitle4Light.copyWith(height: 1),
                ),
                AnimatedSwitcher(
                  duration: 300.ms,
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Text(
                    key: ValueKey(controller.cycles),
                    formatCycleNumber(controller.cycles),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    style: AppTextStyles.headline2bold
                        .copyWith(fontSize: 65, height: 1),
                  ),
                ),
                Text(
                  calculateWakeUpTime(
                    controller.cycles,
                    controller.cyclesDuration,
                    controller.expectedSleepAfter,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  style: AppTextStyles.subtitle4Light.copyWith(
                    fontSize: 14,
                    height: 1,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
