import 'package:flutter/services.dart';

class AdminControl {
  static const MethodChannel _channel = MethodChannel('com.example.sleepcyclesapp/screenWakeupAdmin');

  /// Request device admin permission
  static Future<void> requestAdminPermission() async {
    try {
      await _channel.invokeMethod('requestAdminPermission');
    } on PlatformException catch (e) {
      print("Error requesting admin permission: ${e.message}");
    }
  }

  /// Lock the screen
  static Future<void> lockScreen() async {
    try {
      await _channel.invokeMethod('lockScreen');
    } on PlatformException catch (e) {
      print("Error locking screen: ${e.message}");
    }
  }

  /// Wake up the screen
  static Future<void> wakeUpScreen() async {
    try {
      await _channel.invokeMethod('wakeUpScreen');
    } on PlatformException catch (e) {
      print("Error waking up screen: ${e.message}");
    }
  }
}
