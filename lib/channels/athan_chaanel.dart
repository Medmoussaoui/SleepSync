import 'package:flutter/services.dart';

@pragma('vm:entry-point')
class AthanScreen {
  static const MethodChannel _channel =
      MethodChannel('com.example.sleepcyclesapp/athan');

  static Future<void> showAthanScreen() async {
    try {
      await _channel.invokeMethod('showAthanScreen');
    } on PlatformException catch (e) {
      print("-------> Failed to show overlay: ${e.message}");
    }
  }
}

class AthanScreenCopy {
  MethodChannel _channel = MethodChannel('com.example.sleepcyclesapp/athan');

  Future<void> showAthanScreen() async {
    try {
      await _channel.invokeMethod('showAthanScreen');
    } on PlatformException catch (e) {
      print("-------> Failed to show overlay: ${e.message}");
    }
  }
}
