import 'package:flutter/services.dart';

// com.example.sleepcyclesapp/alarm_schedule

@pragma('vm:entry-point')
class AlarmScheduleService {
  // static const MethodChannel _channel = MethodChannel('com.example.sleepcyclesapp/alarm_schedule');
  static const MethodChannel _channel = MethodChannel('newAlarmScheduleChannel');

  static Future<void> setAlarm(DateTime dateTime) async {
    try {
      final timeInMillis = dateTime.millisecondsSinceEpoch;
      await _channel.invokeMethod('setAlarm', {"timeInMillis": timeInMillis});
    } catch (e) {
      print("Error scheduling service: $e");
    }
  }

  static Future<void> cancelAlarm() async {
    try {
      await _channel.invokeMethod('cancelAlarm');
    } catch (e) {
      print("Error scheduling service: $e");
    }
  }
}
