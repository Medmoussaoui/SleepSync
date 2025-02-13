import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:isolate';

import 'package:sleepcyclesapp/channels/athan_chaanel.dart'; // Import isolate

testCode() {
  scheduleBackgroundTask(
    1,
    DateTime.now().add(Duration(seconds: 10)),
    showAdhanScreenTask,
  );
}

void scheduleBackgroundTask(int id, DateTime time, Function callback) async {
  await AndroidAlarmManager.oneShotAt(
    time,
    id,
    callback,
    wakeup: true,
    exact: true,
    alarmClock: true,
  );
}

@pragma('vm:entry-point')
void showAdhanScreenTask() {
  print("----------> Show Athan Screen Run");
  WidgetsFlutterBinding.ensureInitialized();
  // final channel = AthanScreenCopy();
  // channel.showAthanScreen();
  // MethodChannel channel = MethodChannel('com.example.sleepcyclesapp/athan');
  // channel.invokeMethod('showAthanScreen');
  AthanScreen.showAthanScreen();
  // AthanScreen.showAthanScreen();
}

void _callPlatformChannel(SendPort port) async {
  // Isolate function
  try {
    const MethodChannel channel = MethodChannel('com.example.sleepcyclesapp/athan');
    final String result = await channel.invokeMethod('testMethod'); // Or "showAthanScreen"
    port.send(result); // Send the result back to the main isolate
  } on PlatformException catch (e) {
    port.send(e); // Send the exception back
  } catch (e) {
    port.send("Error: $e");
  }
}

@pragma('vm:entry-point')
void alarmCallback() async {
  print("Alarm callback started.");

  ReceivePort port = ReceivePort(); // Create a receive port
  Isolate.spawn(_callPlatformChannel, port.sendPort); // Spawn an isolate

  port.listen((message) {
    // Listen for messages from the isolate
    if (message is String) {
      print('Result from isolate: $message');
    } else if (message is PlatformException) {
      print('Platform Exception from isolate: ${message.message}');
    } else {
      print('Unexpected message from isolate: $message');
    }
  });
}
