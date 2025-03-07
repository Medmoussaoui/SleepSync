import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/channels/alarm_schedule_service.dart';
import 'package:sleepcyclesapp/channels/app_closer.dart';
import 'package:sleepcyclesapp/channels/overlay_lock_screen.dart';
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
    final fiveMinutes = DateTime.now().add(Duration(minutes: 5));
    AlarmScheduleService.setAlarm(fiveMinutes);
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
      await AlarmScheduleService.cancelAlarm();
    }
    AppCloser.closeApp();
  }

  void onInit() {
    OverlayLockScreen.showOverlay();
    WakelockPlus.enable();
    maxVolume();
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
