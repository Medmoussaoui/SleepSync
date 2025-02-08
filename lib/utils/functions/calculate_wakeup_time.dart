import 'package:intl/intl.dart';

String calculateWakeUpTime(
    int cycles, Duration averageCycleDuration, Duration sleepLatency) {
  DateTime now = DateTime.now();
  DateTime sleepStartTime =
      now.add(sleepLatency); // Add latency before starting cycles
  Duration totalSleepDuration = averageCycleDuration * cycles;
  DateTime wakeUpTime = sleepStartTime.add(totalSleepDuration);

  return DateFormat('hh:mm a').format(wakeUpTime);
}
