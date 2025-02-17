import 'package:flutter/services.dart';

// com.example.sleepcyclesapp/alarm_schedule

@pragma('vm:entry-point')
class AlarmScheduleService {
  static const MethodChannel _channel =
      MethodChannel('com.example.sleepcyclesapp/alarm_schedule');

  static Future<void> scheduleService(DateTime dateTime) async {
    try {
      final timeInMillis = dateTime.millisecondsSinceEpoch;
      await _channel.invokeMethod('setAlarm', {"timeInMillis": timeInMillis});
    } catch (e) {
      print("Error scheduling service: $e");
    }
  }

  static Future<void> cancelService() async {
    try {
      await _channel.invokeMethod('cancelAlarm');
    } catch (e) {
      print("Error scheduling service: $e");
    }
  }
}

Future<void> scheduleService(DateTime dateTime) async {
  try {
    const MethodChannel _channel =
        MethodChannel('com.example.sleepcyclesapp/alarm_schedule');

    final timeInMillis = dateTime.millisecondsSinceEpoch;
    await _channel.invokeMethod('setAlarm', {"timeInMillis": timeInMillis});
  } catch (e) {
    print("Error scheduling service: $e");
  }
}
