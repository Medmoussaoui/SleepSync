import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/controllers/begin_cycles_screen_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/format_total_sleep_duration.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/begin_cycles_screen_title_and_hint.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/select_sleep_cycles_widget.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/settings.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/total_sleep_duration_widget.dart';

class BeginCyclesScreen extends StatelessWidget {
  const BeginCyclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BeginCyclesScreenController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              BeginCyclesScreenTitleAndHint(),
              SizedBox(height: 25),
              SelectSleepCycles().animate(delay: 350.ms).scale(
                    curve: Curves.fastEaseInToSlowEaseOut,
                    duration: 850.ms,
                  ).fade(duration: 400.ms).shader(),
              GetBuilder<BeginCyclesScreenController>(
                builder: (con) {
                  return TotalSleepDurationWidget(
                    value: formatTotalSleepDuration(
                      controller.cycles,
                      controller.cyclesDuration,
                    ),
                  ).animate(delay: 750.ms).fade();
                },
              ),
              Spacer(),
              BeginSleepCylesSetting().animate(delay: 250.ms).fade(),
              SizedBox(height: 25),
              PrimaryButton(
                text: "Sleep Now",
                onPressed: () {
                  controller.startSleep();

                },
              ).animate(delay: 120.ms).moveY(begin: 50, end: 0).fade(),
            ],
          ),
        ),
      ),
    );
  }
}
