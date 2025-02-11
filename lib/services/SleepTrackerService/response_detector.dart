import 'dart:async';
import 'package:sleepcyclesapp/services/SleepTrackerService/motion_detector.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/sound_detector.dart';

abstract class IResponseDetector {
  Future<bool> waitForResponse();
}

class ResponseDetector implements IResponseDetector {
  final MotionDetector motionDetector;
  final SoundDetector soundDetector;

  ResponseDetector({required this.motionDetector, required this.soundDetector});

  @override
  Future<bool> waitForResponse() async {
    Completer<bool> responseDetected = Completer();

    // Timeout mechanism
    Timer(Duration(seconds: 10), () {
      if (!responseDetected.isCompleted) responseDetected.complete(false);
    });

    _listenForTouch(responseDetected);
    // _listenForSound(responseDetected);

    return responseDetected.future;
  }

  void _listenForTouch(Completer<bool> responseDetected) async {
    bool touchDetected = await motionDetector.detectScreenTouch();
    if (touchDetected && !responseDetected.isCompleted) {
      responseDetected.complete(true);
    }
  }

  void _listenForSound(Completer<bool> responseDetected) async {
    bool soundDetected = await soundDetector.detectSound();
    if (soundDetected && !responseDetected.isCompleted) {
      responseDetected.complete(true);
    }
  }
}
