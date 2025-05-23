import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/services/set_sleep_cycle_temporary.dart';
import 'package:sleepcyclesapp/services/enable_desible_noise_tracking.dart';
import 'package:sleepcyclesapp/utils/functions/fill_mobile_screen.dart';
import 'package:sleepcyclesapp/utils/functions/request_microphone_permission.dart';
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

  Future<SleepCycleModel> _createSleepCycleSession() async {
    final model = SleepCycleModel(cycles: cycles, date: DateTime.now());
    await SetSleepCycleTemporaryService().add(model);
    return model;
  }

  startSleep() async {
    if (!await Permission.scheduleExactAlarm.isGranted) {
      final res = await Permission.scheduleExactAlarm.request();
      if (!res.isGranted) return;
    }
    if (!await requestMicrophonePermission()) return;
    await Future.delayed(Duration(seconds: 1));
    fillMobileScreen(hideStatusBar: true);
    Vibration.vibrate(preset: VibrationPreset.singleShortBuzz);
    final model = await _createSleepCycleSession();
    Get.offAllNamed(
      AppRoutes.introSleepScreen,
      arguments: {"session": model},
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
