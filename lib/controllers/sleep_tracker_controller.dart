import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/sleep_stages.dart';
import 'package:sleepcyclesapp/channels/alarm_schedule_service.dart';
import 'package:sleepcyclesapp/channels/overlay_lock_screen.dart';
import 'package:sleepcyclesapp/components/screen_lifecycle_state.dart';
import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/motion_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/response_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/service.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/sound_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';
import 'package:sleepcyclesapp/services/add_sleep_cycle_service.dart';
import 'package:sleepcyclesapp/services/set_sleep_cycle_temporary.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SleepTrackerScreenController extends GetxController {
  late final ScreenLifeCycleStateController screenLifeState;
  late SleepCycleModel sleepCycleModel;
  late SleepTrackerService trackerService;
  Timer? sleepTimer; // Store periodic timer

  bool get isAsleep => trackerService.sleepStage.value == SleepStages.asleep;

  stopTracking() async {
    trackerService.stopTracking();

    // sleep for a while
    if (sleepCycleModel.startTime != null) {
      sleepCycleModel.endTime = DateTime.now();
      await AddSleepCycleService().addSleepCycle(sleepCycleModel);
      await AlarmScheduleService.cancelAlarm();
    }
    exit(1);
  }

  void startTrackingSleep() {
    WakelockPlus.enable();
    trackerService.sleepStage.listen((stage) {
      if (stage == SleepStages.asleep) _userSleep();
    });
    trackerService.startTracking();
  }

  void _userSleep() {
    WakelockPlus.disable();
    sleepCycleModel.startTime = trackerService.sleepStartTime;
    SetSleepCycleTemporaryService().add(sleepCycleModel);
    // final fakeTime = Duration(minutes: 1);
    // final alarmWakeUpTime = trackerService.sleepStartTime!.add(fakeTime);
    final alarmWakeUpTime =
        sleepCycleModel.startTime!.add(sleepCycleModel.cyclesDuration);
    // final time = DateTime(2025,2,18,12,50,0);
    AlarmScheduleService.setAlarm(alarmWakeUpTime);
    Future.delayed(2.seconds, () => update());
    // Update UI every minute while sleeping
    _updateProgressEveryMinute();
  }

  _updateProgressEveryMinute() {
    sleepTimer?.cancel();
    sleepTimer = Timer.periodic(Duration(minutes: 1), (_) {
      update();
    });
  }

  void _userAwake() => sleepTimer?.cancel();

  void initial() {
    final model = Get.arguments["session"];
    if (model == null) return Get.back();
    sleepCycleModel = model;
    // resume current session
    if (model.startTime != null) {
      sleepCycleModel = model;
      trackerService.sleepStage.value = SleepStages.asleep;
      _updateProgressEveryMinute();
      return;
    }
    // start the current new session tracking
    startTrackingSleep();
  }

  void _onScreenLifeStateChange() {
    screenLifeState.screenState.stream.listen((state) {
      if (state == AppLifecycleState.resumed) {
        print("----------------------> start Update Ui every 1 minute");
        update();
        _updateProgressEveryMinute();
      } else if (state == AppLifecycleState.paused) {
        print("----------------------> Stop Update UI every 1 minute");
        sleepTimer?.cancel();
      }
    });
  }

  @override
  void onInit() {
    screenLifeState = ScreenLifeCycleStateController();
    _onScreenLifeStateChange();
    OverlayLockScreen.showOverlay();
    trackerService = SleepTrackerService(
      responseDetector: ResponseDetector(
        motionDetector: MotionDetector(),
        soundDetector: DetectUserSoundResponce(),
      ),
      vibrationNotifier: VibrationNotifier(),
    );
    initial();
    super.onInit();
  }

  @override
  void onClose() {
    OverlayLockScreen.hideOverlay();
    sleepTimer?.cancel(); // Clean up when the controller is destroyed
    trackerService.destroy();
    super.onClose();
  }
}
