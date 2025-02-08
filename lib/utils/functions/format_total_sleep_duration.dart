String formatTotalSleepDuration(int cycles, Duration cycleDuration) {
  Duration totalDuration = cycleDuration * cycles;
  int hours = totalDuration.inHours;
  int minutes = totalDuration.inMinutes.remainder(60);

  return "$hours hrs, $minutes min";
}
