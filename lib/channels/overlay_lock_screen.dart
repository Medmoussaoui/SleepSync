import 'package:flutter/services.dart';

class OverlayLockScreen {
  static const MethodChannel _channel = MethodChannel('com.example.sleepcyclesapp/overlay_lock_screen');

  static Future<void> showOverlay() async {
    try {
      await _channel.invokeMethod('enableOverlayScreen');
    } on PlatformException catch (e) {
      print("-------> Failed to show overlay: ${e.message}");
    }
  }

  static Future<void> hideOverlay() async {
    try {
      await _channel.invokeMethod('disableOverlayScreen');
    } on PlatformException catch (e) {
      print("-------> Failed to hide overlay: ${e.message}");
    }
  }
}
