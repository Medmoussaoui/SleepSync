import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/adjustCycleDuration/controller.dart';
import 'package:sleepcyclesapp/components/clock.dart';
import 'package:sleepcyclesapp/components/custom_dialog.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class AdjustCycleMinutesDialog extends StatelessWidget {
  final Function(int duration) onSave;

  const AdjustCycleMinutesDialog({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdjustCycleMinutesController());
    return CustomDialog(
      title: "Set Sleep Cycle Duration",
      subtitle: "Move the clock left or right to change",
      content: AdjustCycleMinutesContent()
          .animate(delay: 350.ms)
          .scale(
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: 850.ms,
          )
          .fade(duration: 400.ms)
          .shader(),
      action: PrimaryButton(
        text: "Apply",
        onPressed: () {
          controller.applyChange(onSave);
        },
      ),
    );
  }
}

class AdjustCycleMinutesContent extends GetView<AdjustCycleMinutesController> {
  const AdjustCycleMinutesContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClockCounter(
          max: 90,
          min: 10,
          onMoving: (value) {},
          onChange: (value) {
            controller.setCycleDuration(value);
          },
          initialValue: controller.cycleDuration,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Minutes",
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              style: AppTextStyles.subtitle4Light.copyWith(height: 1),
            ).animate(delay:900.ms).fade(duration: 750.ms),
            GetBuilder<AdjustCycleMinutesController>(
              id: "duration",
              builder: (_) {
                return AnimatedSwitcher(
                  duration: 500.ms,
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Text(
                    key: ValueKey("${controller.cycleDuration}"),
                    controller.cycleDuration.toString(),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    style: AppTextStyles.headline2bold.copyWith(
                      fontSize: 65,
                      height: 1,
                      color: AppColors.relaxWhite,
                    ),
                  ),
                ).animate(delay: 1150.ms).fade(duration: 750.ms);
              },
            ),
          ],
        ),
      ],
    );
  }
}
