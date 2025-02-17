import 'dart:async';
import 'package:sleepcyclesapp/components/CustomTouchScreenLisener/controller.dart';

class MotionDetector {

  Future<bool> detectScreenTouch() async {
    Completer<bool> touchDetected = Completer();

    StreamSubscription? subscription;

    subscription = TouchScreenLisener.screenEvent.listen((value) {
      print("-----> Touch event : ${value == ScreenTouchEvents.tap}");
      if (value == ScreenTouchEvents.tap) {
        touchDetected.complete(true);
        subscription?.cancel();
      }
    });

    return touchDetected.future.timeout(Duration(seconds: 8), onTimeout: () {
      subscription?.cancel();
      return false;
    });
  }

}
