import 'dart:async';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/motion_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/response_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/service.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/sound_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';

class SleepTrackerScreenController extends GetxController {
  late SleepCycleModel sleepCycleModel;
  late SleepTrackerService trackerService;
  Timer? sleepTimer; // Store periodic timer

  void startTrackingSleep() {
    trackerService.startTracking();
    trackerService.isSleeping.listen((sleep) {
      if (sleep) _userSleep();
    });
  }

  void _userSleep() {
    print("--------> User Sleep");
    sleepCycleModel.startTime = trackerService.sleepStartTime;
    // Update UI every minute while sleeping
    sleepTimer?.cancel();
    sleepTimer = Timer.periodic(Duration(minutes: 1), (_) => update());
  }

  void _userAwake() {
    sleepTimer?.cancel(); // Stop the periodic updates when the user wakes up
  }

  @override
  void onInit() {
    sleepCycleModel = SleepCycleModel(cycles: 5, date: DateTime.now());
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
    super.onClose();
  }
}
