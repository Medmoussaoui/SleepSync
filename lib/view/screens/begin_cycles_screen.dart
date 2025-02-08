import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/components/SelectAlarmSound/dialog.dart';
import 'package:sleepcyclesapp/components/text_with_icon.dart';
import 'package:sleepcyclesapp/controllers/begin_cycles_screen_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/custom_show_dialog.dart';
import 'package:sleepcyclesapp/utils/functions/format_total_sleep_duration.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/begin_cycles_screen_title_and_hint.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/select_sleep_cycles_widget.dart';
import 'package:sleepcyclesapp/view/widgets/beginSleepCycles/settings.dart';

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
              GetBuilder<BeginCyclesScreenController>(builder: (con) {
                return TextWithIcon(
                  text: formatTotalSleepDuration(
                    controller.cycles,
                    controller.cyclesDuration,
                  ),
                  style: AppTextStyles.headline3medium
                      .copyWith(color: AppColors.blue),
                  icon: CustomIcon(icon: AppIcons.sleep, color: AppColors.blue),
                );
              }),
              Spacer(),
              BeginSleepCylesSetting(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PrimaryButton(
                  text: "Sleep Now",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
