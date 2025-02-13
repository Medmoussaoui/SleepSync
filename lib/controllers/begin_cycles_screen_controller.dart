import 'package:get/get.dart';
import 'package:sleepcyclesapp/services/enable_desible_noise_tracking.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class BeginCyclesScreenController extends GetxController {
  int cycles = 1;
  Duration cyclesDuration = Duration(minutes: Settings.cycleMinute);
  Duration expectedSleepAfter = Duration(minutes: 25);

  late bool noiseTracking;
  late String alarmSoundName;

  startSleep() async {
    Vibration.vibrate(preset: VibrationPreset.rapidTapFeedback);
    Get.offAllNamed(
      AppRoutes.introSleepScreen,
      arguments: {"cycles": cycles},
    );
  }

  enableDisableNoiseTracking(bool active) {
    noiseTracking = active;
    EnableDesibleNoiseTrackingService().excute(active);
    update(["noiseTracking"]);
  }

  setCycles(int selectedCycles) {
    cycles = selectedCycles;
    update();
  }

  onAlarmSoundChange(String soundName) {
    alarmSoundName = soundName;
    update(["alarmSound"]);
  }

  @override
  void onInit() {
    alarmSoundName = Settings.alarmSound.name;
    noiseTracking = Settings.noiseTracking;
    super.onInit();
  }
}
