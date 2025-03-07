import 'package:flutter/services.dart';

class AppCloser {
  static const MethodChannel _channel = MethodChannel('com.example.sleepcyclesapp/app_closer');

  static Future<void> closeApp() async {
    try {
      await _channel.invokeMethod('closeApp');
    } on PlatformException catch (e) {
      print("Failed to close app: ${e.message}");
    }
  }
}

