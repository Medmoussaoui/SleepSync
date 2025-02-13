import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/channels/alarm_schedule_service.dart';
import 'package:sleepcyclesapp/services/add_sleep_cycle_service.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class WakeUpScreenController extends GetxController {
  late final AudioPlayer player;

  void playSound() {
    final sound = Settings.alarmSound;
    final soundSource = sound.isCustomSound
        ? DeviceFileSource(sound.path)
        : AssetSource(sound.path);
    player.play(soundSource);
  }

  void snoozeFor10Min() async {
    player.stop();
    WakelockPlus.disable();
    final thenMunite = DateTime.now().add(Duration(minutes: 10));
    await AlarmScheduleService.scheduleService(thenMunite);
    // Get.back();
    exit(0);
  }

  wakeUp() async {
    player.stop();
    WakelockPlus.disable();
    // save sleep info cyles session

    final model = Settings.currentSleepSession;

    if (model != null) {
      model.endTime = DateTime.now();
      await AddSleepCycleService().addSleepCycle(model);
    }
    exit(0);
  }

  @override
  void onInit() {
    WakelockPlus.enable();
    player = AudioPlayer();
    playSound();
    super.onInit();
  }

  @override
  void onClose() {
    WakelockPlus.disable();
    super.onClose();
  }
}
