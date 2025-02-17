import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/channels/alarm_schedule_service.dart';
import 'package:sleepcyclesapp/services/add_sleep_cycle_service.dart';
import 'package:sleepcyclesapp/utils/functions/max_volume.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class WakeUpScreenController extends GetxController {
  late final AudioPlayer player;

  void playSound() {
    final sound = Settings.alarmSound;
    final soundSource = sound.isCustomSound
        ? DeviceFileSource(sound.path)
        : AssetSource(sound.path);
    player.setReleaseMode(ReleaseMode.loop);
    player.play(soundSource);
  }

  void snoozeFor5Min() async {
    player.stop();
    WakelockPlus.disable();
    final fiveMinutes = DateTime.now().add(Duration(minutes: 1));
    await AlarmScheduleService.scheduleService(fiveMinutes);
    // naigate to sleep tracking screen
    Get.offAllNamed(
      AppRoutes.sleepTrackerScreen,
      arguments: {"session": Settings.currentSleepSession},
    );
  }

  Future<void> wakeUp() async {
    player.stop();
    WakelockPlus.disable();
    final model = Settings.currentSleepSession;
    if (model != null) {
      model.endTime = DateTime.now();
      await AddSleepCycleService().addSleepCycle(model);
    }
    exit(0);
  }

  void onInit() {
    maxVolume();
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
