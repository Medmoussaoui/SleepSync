import 'package:get/get.dart';
import 'package:sleepcyclesapp/utils/settings.dart';

class BeginCyclesScreenController extends GetxController {
  int cycles = 1;
  Duration cyclesDuration = Duration(minutes: Settings.cycleMinute);
  Duration expectedSleepAfter = Duration(minutes: 25);

  bool noiseTracking = false;

  enableDisableNoiseTracking(bool active) {
    noiseTracking = active;
    update(["noiseTracking"]);
  }

  setCycles(int selectedCycles) {
    cycles = selectedCycles;
    update();
  }
}
