import 'package:flutter/services.dart';

// com.example.sleepcyclesapp/alarm_schedule
class AlarmScheduleService {
  static const MethodChannel _channel = MethodChannel('com.example.sleepcyclesapp/alarm_schedule');

  static Future<void> scheduleService(DateTime dateTime) async {
    try {
      final timeInMillis = dateTime.millisecondsSinceEpoch;
      await _channel.invokeMethod('setAlarm', {"timeInMillis": timeInMillis});
    } catch (e) {
      print("Error scheduling service: $e");
    }
  }
}
