import 'package:flutter/services.dart';

class WakeUpService {
  static const MethodChannel _channel =
      MethodChannel('com.example.lightsheet/foreground');

  static Future<void> wakeUpScreen() async {
    await _channel.invokeMethod('startForegroundService');
  }
}