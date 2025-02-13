import 'dart:async';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/channels/alarm_schedule_service.dart';
import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/motion_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/response_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/service.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/sound_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SleepTrackerScreenController extends GetxController {
  late SleepCycleModel sleepCycleModel;
  late SleepTrackerService trackerService;
  Timer? sleepTimer; // Store periodic timer

  void startTrackingSleep() {
    WakelockPlus.enable();
    trackerService.isSleeping.listen((sleep) {
      if (sleep) _userSleep();
    });
    trackerService.startTracking();
  }

  void _userSleep() {
    print("--------------------------------> USER SLEEP NOW");
    WakelockPlus.disable();
    sleepCycleModel.startTime = trackerService.sleepStartTime;
    HiveDatabase.db.put("currentSleepSession", sleepCycleModel.toMap());
    // for test only this now
    final alarmWakeUpTime = trackerService.sleepStartTime!.add(Duration(minutes: 1));
    // final alarmWakeUpTime = trackerService.sleepStartTime!.add(sleepCycleModel.cyclesDuration);
  
    AlarmScheduleService.scheduleService(alarmWakeUpTime);

    // Update UI every minute while sleeping
    sleepTimer?.cancel();
    sleepTimer = Timer.periodic(Duration(minutes: 1), (_) {
      update();
    });
  }

  void _userAwake() {
    sleepTimer?.cancel(); // Stop the periodic updates when the user wakes up
  }

  SleepCycleModel setSleepSession() {
    final model =
        SleepCycleModel(cycles: Get.arguments["cycles"], date: DateTime.now());
    HiveDatabase.db.put("currentSleepSession", model.toMap());
    return model;
  }

  @override
  void onInit() {
    sleepCycleModel = setSleepSession();
    trackerService = SleepTrackerService(
      responseDetector: ResponseDetector(
        motionDetector: MotionDetector(),
        soundDetector: SoundDetector(),
      ),
      vibrationNotifier: VibrationNotifier(),
    );
    startTrackingSleep();
    super.onInit();
  }

  @override
  void onClose() {
    sleepTimer?.cancel(); // Clean up when the controller is destroyed
    trackerService.destroy();
    super.onClose();
  }
}
