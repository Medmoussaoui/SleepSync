String getExpectedWakeUpTime(DateTime bedtime, int cycles, Duration sleepOnset) {
  const int cycleDurationMinutes = 90; // One sleep cycle duration
  Duration totalSleepDuration = Duration(minutes: cycles * cycleDurationMinutes);
  
  // Calculate expected wake-up range
  DateTime minWakeUp = bedtime.add(sleepOnset).add(totalSleepDuration);
  DateTime maxWakeUp = minWakeUp.add(Duration(minutes: 30)); // 30-minute buffer
  
  // Format the time
  String formatTime(DateTime time) {
    return "${time.hour % 12 == 0 ? 12 : time.hour % 12}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";
  }

  return "${formatTime(minWakeUp)} - ${formatTime(maxWakeUp)}";
}
