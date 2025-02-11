import 'dart:async';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/response_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';

class SleepTrackerService {
  final IResponseDetector responseDetector;
  final VibrationNotifier vibrationNotifier;

  RxBool isSleeping = false.obs;
  RxBool isTracking = false.obs;
  DateTime? sleepStartTime;
  Timer? checkTimer;
  int checkInterval = 1; // Start with 4 minutes

  SleepTrackerService({
    required this.responseDetector,
    required this.vibrationNotifier,
  });

  void startTracking() {
    if (isTracking.value) return; // Prevent multiple starts
    isTracking.value = true;
    _scheduleCheck();
  }

  void _scheduleCheck() {
    print("--------> Start Schedule Check");
    checkTimer?.cancel();
    checkTimer = Timer(Duration(minutes: checkInterval), () async {
      if (!isTracking.value) return;
      print("--------> sendVibration");
      int trys = 1;
      while (trys <= 3) {
        await vibrationNotifier.sendVibration();
        bool responded = await responseDetector.waitForResponse();
        if (responded) {
          print("-----------> User not sleep");
          checkInterval = 1; // Reduce interval for next checks
          return _scheduleCheck();
        } else {
          if (trys == 3) {
            return _detectSleep();
          }
          print("-----------> User Not Responde trys ($trys) ");
          trys++;
        }
      }
    });
  }

  void _detectSleep() {
    print("-----------> User sleep ");
    sleepStartTime = DateTime.now();
    print("-----------> _detectSleep() -> sleepStartTime = $sleepStartTime ");
    checkTimer?.cancel();
    isSleeping.value = true;
  }

  void stopTracking() {
    isSleeping.value = false;
    isTracking.value = false;
    checkTimer?.cancel();
  }

  destroy() {
    stopTracking();
    isSleeping.close();
    isTracking.close();
    print("SleepTrackerService disposed.");
  }
}
