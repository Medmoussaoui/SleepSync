import 'dart:async';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/sleep_stages.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/response_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';
import 'package:sleepcyclesapp/services/new_sleep_delay_persontage.dart';
import 'package:sleepcyclesapp/usecases/sleep_time_estimator.dart';
import 'package:sleepcyclesapp/utils/music_player.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';

class SleepTrackerService {
  final sleepTimeEstimator =
      SleepTimeEstimator(sleepDelayStorage: NewsleepDelayPercentage());
  final IResponseDetector responseDetector;
  final VibrationNotifier vibrationNotifier;

  Rx<SleepStages> sleepStage = Rx(SleepStages.stillAwake);
  RxBool isTracking = false.obs;
  DateTime? sleepStartTime;
  Timer? checkTimer;
  // CheckSleepInterval checkInterval = CheckSleepInterval();
  int checkInterval = 5;

  final int _max_check_sleep_trys = 2;

  DateTime? lastCheckTime;

  SleepTrackerService({
    required this.responseDetector,
    required this.vibrationNotifier,
  });

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
    if (checkInterval != 2) checkInterval = 2;
  }

  __detectNotSleepYet() {
    downCheckInterval();
    // openSpeech(AppSounds.keepRelax);
    AppAudioPlayer.playFromAsset(AppSounds.confirm, volume: 0.14);
    sleepStage.value = SleepStages.stillAwake;
    return _scheduleCheck();
  }

  void _scheduleCheck() {
    checkTimer?.cancel();
    _checkingSoon();
    checkTimer = Timer(Duration(minutes: checkInterval), () async {
      lastCheckTime = DateTime.now();
      if (!isTracking.value) return;
      int trys = 1;
      while (trys <= _max_check_sleep_trys) {
        sleepStage.value = SleepStages.areYouThere;
        var responded = responseDetector.waitForResponse();
        vibrationNotifier.sendVibration();
        if (await responded) {
          return __detectNotSleepYet();
        }
        if (trys == _max_check_sleep_trys) return _detectSleep();
        trys++;
      }
    });
  }

  _detectSleep() async {
    print("-----------> User sleep ");
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
