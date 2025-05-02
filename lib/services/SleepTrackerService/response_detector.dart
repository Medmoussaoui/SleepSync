import 'dart:async';
import 'package:sleepcyclesapp/services/SleepTrackerService/motion_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/sound_detector.dart';

abstract class IResponseDetector {
  Future<bool> waitForResponse();
}

class ResponseDetector implements IResponseDetector {
  final MotionDetector motionDetector;
  final DetectUserSoundResponce soundDetector;

  ResponseDetector({
    required this.motionDetector,
    required this.soundDetector,
  });
  @override
  Future<bool> waitForResponse() async {
    Completer<bool> responseDetected = Completer();

    _listenForTouch(responseDetected);
    _listenForSound(responseDetected);

    return responseDetected.future.timeout(Duration(seconds: 10),
        onTimeout: () {
      return false;
    });
  }

  Future _listenForTouch(Completer<bool> responseDetected) async {
    bool touchDetected = await motionDetector.detectScreenTouch();
    if (touchDetected && !responseDetected.isCompleted) {
      responseDetected.complete(true);
    }
  }

  Future _listenForSound(Completer<bool> responseDetected) async {
    bool soundDetected = await soundDetector.detectSound();
    if (soundDetected && !responseDetected.isCompleted) {
      responseDetected.complete(true);
    }
  }
}
