import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/custom_switch_button.dart';
import 'package:sleepcyclesapp/components/custom_tile.dart';
import 'package:sleepcyclesapp/components/custom_tile_container.dart';
import 'package:sleepcyclesapp/components/SelectAlarmSound/dialog.dart';
import 'package:sleepcyclesapp/controllers/begin_cycles_screen_controller.dart';
import 'package:sleepcyclesapp/utils/functions/custom_show_dialog.dart';
import 'package:sleepcyclesapp/utils/functions/truncate_text.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';

class BeginSleepCylesSetting extends GetView<BeginCyclesScreenController> {
  const BeginSleepCylesSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTileContainer(
      children: [
        GetBuilder<BeginCyclesScreenController>(
          id: "alarmSound",
          builder: (con) {
            return CustomTile(
              padding: false,
              title: "Wake-Up Alarm Sound",
              subtitle:  truncateWithEllipsis(controller.alarmSoundName,maxLength: 24) ,
              leadingIcon: CustomIcon(
                icon: AppIcons.music,
                background: true,
              ),
              onTap: () {
                customShowDialog(
                  SelectAlarmSound(
                    onSave: (sound) {
                      controller.onAlarmSoundChange(sound.name);
                    },
                  ),
                );
              },
            );
          },
        ),
        GetBuilder<BeginCyclesScreenController>(
          id: "noiseTracking",
          builder: (con) {
            return CustomTile(
              padding: false,
              title: "Noise Tracking",
              subtitle: "Detects ambient noise during sleep",
              leadingIcon: CustomIcon(
                icon: AppIcons.noise,
                background: true,
              ),
              trailingWidget: CustomSwitchButton(
                isChecked: con.noiseTracking,
                onChanged: con.enableDisableNoiseTracking,
              ),
              onTap: () => con.enableDisableNoiseTracking(!con.noiseTracking),
            );
          },
        ),
      ],
    );
  }
}
