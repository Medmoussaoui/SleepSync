import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/controllers/begin_cycles_screen_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/format_total_sleep_duration.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BeginCyclesScreenTitleAndHint(),
              SizedBox(height: 30),
              SelectSleepCycles(),
              GetBuilder<BeginCyclesScreenController>(
                builder: (con) {
                  return TotalSleepDurationWidget(
                    value: formatTotalSleepDuration(
                      controller.cycles,
                      controller.cyclesDuration,
                    ),
                  );
                },
              ),
              Spacer(),
              BeginSleepCylesSetting(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PrimaryButton(
                  text: "Sleep Now",
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.introSleepScreen,
                      arguments: {"cycles": controller.cycles},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
