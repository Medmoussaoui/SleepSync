import 'package:get/get.dart';
import 'package:sleepcyclesapp/services/enable_desible_noise_tracking.dart';
import 'package:sleepcyclesapp/utils/settings.dart';

class BeginCyclesScreenController extends GetxController {
  int cycles = 1;
  Duration cyclesDuration = Duration(minutes: Settings.cycleMinute);
  Duration expectedSleepAfter = Duration(minutes: 25);

  late bool noiseTracking;
  late String alarmSoundName;

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
