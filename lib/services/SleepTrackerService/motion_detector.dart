import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class MotionDetector {
  Future<bool> detectScreenTouch() async {
    Completer<bool> touchDetected = Completer();
    GyroscopeEvent? lastGyroEvent;

    final subscription = gyroscopeEventStream().listen((GyroscopeEvent event) {
      if (!touchDetected.isCompleted) {
        if (lastGyroEvent != null &&
            ((event.x - lastGyroEvent!.x).abs() > 0.1 ||
                (event.y - lastGyroEvent!.y).abs() > 0.1)) {
          touchDetected.complete(true);
        }
      }
      lastGyroEvent = event;
    });

    return touchDetected.future.timeout(Duration(seconds: 15), onTimeout: () {
      subscription.cancel();
      return false;
    });
  }
}
