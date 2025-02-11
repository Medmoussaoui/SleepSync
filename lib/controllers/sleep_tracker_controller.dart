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
    trackerService.isSleeping.listen((sleep) {
      if (sleep) _userSleep();
    });
    trackerService.startTracking();
  }

  void _userSleep() {
    print("--------> User Sleep");
    print(
        "-----------> Track Service Sleep Start ${trackerService.sleepStartTime}");
    sleepCycleModel.startTime = trackerService.sleepStartTime;
    // Update UI every minute while sleeping
    sleepTimer?.cancel();
    sleepTimer = Timer.periodic(Duration(minutes: 1), (_) {
      print("----> Timer.periodic callbak run");
      print("----> Progress : ${sleepCycleModel.progress}");
      print("----> Cycles : ${sleepCycleModel.cycles}");
      print("----> completed cycles : ${sleepCycleModel.completedCycles}");
      print("----> Start Time : ${sleepCycleModel.startTime}");
      update();
    });
  }

  void _userAwake() {
    sleepTimer?.cancel(); // Stop the periodic updates when the user wakes up
  }

  @override
  void onInit() {
    sleepCycleModel = SleepCycleModel(
      cycles: Get.arguments["cycles"],
      date: DateTime.now(),
    );
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
