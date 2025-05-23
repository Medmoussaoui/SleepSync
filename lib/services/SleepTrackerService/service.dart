import 'dart:async';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/sleep_stages.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/response_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';
import 'package:sleepcyclesapp/services/new_sleep_delay_persontage.dart';
import 'package:sleepcyclesapp/usecases/sleep_time_estimator.dart';

class SleepTrackerService {
  final sleepTimeEstimator =
      SleepTimeEstimator(sleepDelayStorage: NewsleepDelayPercentage());
  final IResponseDetector responseDetector;
  final VibrationNotifier vibrationNotifier;

  SleepTrackerService({
    required this.responseDetector,
    required this.vibrationNotifier,
  });

  Rx<SleepStages> sleepStage = Rx(SleepStages.stillAwake);
  RxBool isTracking = false.obs;
  DateTime? sleepStartTime;
  Timer? checkTimer;
  // CheckSleepInterval checkInterval = CheckSleepInterval();
  int checkInterval = 5;

  DateTime? lastCheckTime;

  void startTracking() {
    if (isTracking.value) return; // Prevent multiple starts
    isTracking.value = true;
    _scheduleCheck();
  }

  void _checkingSoon() {
    int closeToChecking = (checkInterval * 60 / 2).round();
    late Timer timer;
    timer = Timer(Duration(seconds: closeToChecking), () {
      sleepStage.value = SleepStages.checking;
      timer.cancel();
    });
  }

  downCheckInterval() {
    if (checkInterval > 2) checkInterval--;
  }

  __detectNotSleepYet() {
    vibrationNotifier.stop();
    downCheckInterval();
    sleepStage.value = SleepStages.stillAwake;
    return _scheduleCheck();
  }

  void _scheduleCheck() {
    checkTimer?.cancel();
    _checkingSoon();
    checkTimer = Timer(Duration(minutes: checkInterval), () async {
      lastCheckTime = DateTime.now();
      if (!isTracking.value) return;
      sleepStage.value = SleepStages.areYouThere;

      vibrationNotifier.play();
      var responded = responseDetector.waitForResponse();

      if (await responded) return __detectNotSleepYet();
      _detectSleep();
    });
  }

  _detectSleep() async {
    vibrationNotifier.stop(useSound: false);
    checkTimer?.cancel();
    sleepStartTime =
        (lastCheckTime ?? DateTime.now()).subtract(Duration(seconds: 12));
    sleepStage.value = SleepStages.asleep;
  }

  void stopTracking() {
    isTracking.value = false;
    sleepStage.value = SleepStages.stop;
    checkTimer?.cancel();
  }

  destroy() {
    stopTracking();
    isTracking.close();
    sleepStage.close();
  }
}
