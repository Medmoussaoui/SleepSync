import 'dart:async';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/sleep_stages.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/response_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';
import 'package:sleepcyclesapp/utils/music_player.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';

class SleepTrackerService {
  final IResponseDetector responseDetector;
  final VibrationNotifier vibrationNotifier;

  Rx<SleepStages> sleepStage = Rx(SleepStages.stillAwake);
  RxBool isTracking = false.obs;
  DateTime? sleepStartTime;
  Timer? checkTimer;
  int checkInterval = 1; // Start with 3 minute

  /// TODO: implement this feature ti set near expected sleep at time
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

  void _checkingSoon(int checkInterval) {
    int closeToChecking = (checkInterval * 60 / 2).round();
    late Timer timer;
    timer = Timer(Duration(seconds: closeToChecking), () {
      sleepStage.value = SleepStages.checking;
      timer.cancel();
    });
  }

  __detectNotSleepYet() {
    lastCheckTime = DateTime.now();
    AppAudioPlayer.playFromAsset(AppSounds.confirm, volume: 0.32);
    sleepStage.value = SleepStages.stillAwake;
    return _scheduleCheck();
  }

  void _scheduleCheck() {
    checkTimer?.cancel();
    _checkingSoon(checkInterval);
    checkTimer = Timer(Duration(minutes: checkInterval), () async {
      if (!isTracking.value) return;
      int trys = 1;
      while (trys <= 3) {
        sleepStage.value = SleepStages.areYouThere;
        var responded = responseDetector.waitForResponse();
        vibrationNotifier.sendVibration();
        if (await responded) {
          lastCheckTime = DateTime.now();
          return __detectNotSleepYet();
        }
        if (trys == 3) return _detectSleep();
        trys++;
      }
    });
  }

  void _detectSleep() {
    print("-----------> User sleep ");
    checkTimer?.cancel();
    sleepStartTime = DateTime.now();
    sleepStage.value = SleepStages.asleep;
    // if (lastCheckTime != null) {
    //   final difference = sleepStartTime!.difference(lastCheckTime!);
    //   final sleepPeriod = difference.inSeconds * 0.35; // 35% of the time elapsed
    //   // expected sleep at time
    //   sleepStartTime = sleepStartTime!.subtract(Duration(seconds: sleepPeriod.toInt()));
    // }
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
