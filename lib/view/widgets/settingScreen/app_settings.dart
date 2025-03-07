import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/custom_switch_button.dart';
import 'package:sleepcyclesapp/components/custom_tile.dart';
import 'package:sleepcyclesapp/components/custom_tile_container.dart';
import 'package:sleepcyclesapp/controllers/settings_screen_controller.dart';
import 'package:sleepcyclesapp/utils/functions/truncate_text.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';

class AppSettingContainer extends GetView<SettingsScreenController> {
  const AppSettingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTileContainer(
      children: [
        GetBuilder<SettingsScreenController>(
          id: "setCycles",
          builder: (controller) {
            return CustomTile(
              key: ValueKey("setCycles"),
              padding: false,
              title: "Set Sleep Cycle Duration",
              subtitle: "Sleep Cycle is ${Settings.cycleMinute} min",
              leadingIcon: CustomIcon(
                icon: AppIcons.timer,
                background: true,
              ),
              onTap: () {
                controller.showAdjustCycleMinutesDialog();
              },
            );
          },
        ),
        GetBuilder<SettingsScreenController>(
          id: "vibration",
          builder: (_) {
            final currentVebration = Settings.vebrationType;
            return CustomTile(
              key: ValueKey("vibration"),
              padding: false,
              title: "Vibration Sensitivity",
              subtitle: currentVebration.description,
              leadingIcon: CustomIcon(
                icon: AppIcons.vebration,
                background: true,
              ),
              onTap: () {
                controller.showVebrationsDialog();
              },
            );
          },
        ),
        GetBuilder<SettingsScreenController>(
          id: "alarmSound",
          builder: (_) {
            final currentAlarmSound = Settings.alarmSound.name;
            return CustomTile(
              key: ValueKey("alarmSound"),
              padding: false,
              title: "Wake-Up Alarm Sound",
              subtitle: truncateWithEllipsis(currentAlarmSound, maxLength: 24),
              leadingIcon: CustomIcon(
                icon: AppIcons.music,
                background: true,
              ),
              onTap: () {
                controller.showAlarmSoundDialog();
              },
            );
          },
        ),
        GetBuilder<SettingsScreenController>(
          id: "noiseTracking",
          builder: (con) {
            return CustomTile(
              key: ValueKey("noiseTracking"),
              padding: false,
              title: "Noise Tracking",
              subtitle: "Detects ambient noise during sleep",
              leadingIcon: CustomIcon(
                icon: AppIcons.noise,
                background: true,
              ),
              trailingWidget: CustomSwitchButton(
                isChecked: Settings.noiseTracking,
                onChanged: (state) => controller.enableNoiseTracking(),
              ),
              onTap: () {
                controller.enableNoiseTracking();
              },
            );
          },
        ),
      ],
    );
  }
}
