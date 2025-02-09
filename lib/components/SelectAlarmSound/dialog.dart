import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sleepcyclesapp/components/SelectAlarmSound/controller.dart';
import 'package:sleepcyclesapp/components/custom_dialog.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/custom_tile.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/models/alarm_sound_model.dart';
import 'package:sleepcyclesapp/utils/animations.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/truncate_text.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';

class SelectAlarmSound extends StatelessWidget {
  final Function(AlarmSoundModel sound) onSave;
  const SelectAlarmSound({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectAlarmSoundController());
    return CustomDialog(
      title: "Alarm Sounds",
      content: Material(
        color: Colors.transparent,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: controller.alarmSounds.length,
          separatorBuilder: (_, index) => SizedBox(height: 10),
          itemBuilder: (_, index) {
            if (index == controller.alarmSounds.length - 1) {
              // controller.selectCustomSound();
              return GetX<SelectAlarmSoundController>(
                builder: (con) {
                  bool isSelected = controller.selectedSound.value == index;
                  return CustomSoundWidget(
                    isPlaying: isSelected && controller.musicPlaying.value,
                    musicName: controller.alarmSounds[index].name,
                    onTap: () {
                      controller.selectCustomSound();
                    },
                  );
                },
              );
            }
            return GetX<SelectAlarmSoundController>(
              builder: (con) {
                bool isSelected = controller.selectedSound.value == index;
                return MusicListTile(
                  id: index,
                  isPlaying: controller.musicPlaying.value && isSelected,
                  musicName: controller.alarmSounds[index].name,
                  isSelected: isSelected,
                  onTap: (index) => controller.selectAlarmSound(index),
                );
              },
            );
          },
        ),
      ),
      action: PrimaryButton(
        text: "Apply",
        onPressed: () async {
          final sound = await controller.saveSound();
          onSave(sound);
        },
      ),
    );
  }
}

class CustomSoundWidget extends StatelessWidget {
  final String musicName;
  final bool isPlaying;
  final Function() onTap;

  const CustomSoundWidget({
    super.key,
    required this.isPlaying,
    required this.onTap,
    required this.musicName,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      title: "Custom Sounds",
      subtitle: truncateWithEllipsis(musicName, maxLength: 24),
      borderColor: AppColors.white.withOpacity(0.07),
      leadingIcon: AnimatedSwitcher(
        duration: 300.ms,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isPlaying
            ? Lottie.asset(
                AppAnimatedIcons.music,
                height: 40,
                width: 40,
              )
            : CustomIcon(background: true, icon: AppIcons.musiccollection),
      ),
      trailingWidget: CustomIcon(
        icon: AppIcons.arrow,
        color: AppColors.secondaryTextColor.withOpacity(0.4),
      ),
      onTap: () => onTap(),
    );
  }
}

class MusicListTile extends StatelessWidget {
  final String musicName;
  final bool isSelected;
  final bool isPlaying;
  final int id;
  final Function(int id) onTap;

  const MusicListTile({
    super.key,
    required this.musicName,
    required this.isSelected,
    required this.id,
    required this.onTap,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      title: musicName,
      borderColor: AppColors.white.withOpacity(0.07),
      leadingIcon: AnimatedSwitcher(
        duration: 300.ms,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isPlaying
            ? Lottie.asset(
                AppAnimatedIcons.music,
                height: 40,
                width: 40,
              )
            : CustomIcon(background: true, icon: AppIcons.music),
      ),
      trailingWidget: CustomIcon(
        icon: AppIcons.done,
        color: isSelected
            ? AppColors.primaryBtnColor
            : AppColors.secondaryTextColor.withOpacity(0.4),
      ),
      onTap: () => onTap(id),
    );
  }
}
