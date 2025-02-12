import 'package:flutter/services.dart';

class ScreenWakeup {
  static const platform = MethodChannel('com.example.your_app/screen_wakeup');

  static Future<void> wakeUpScreen() async {
    try {
      await platform.invokeMethod('wakeUpScreen');
    } on PlatformException catch (e) {
      print("Failed to wake up screen: ${e.message}");
    }
  }
}