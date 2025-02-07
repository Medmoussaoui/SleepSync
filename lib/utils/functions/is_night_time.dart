bool isNightTime() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  return hour < 6 || hour >= 18; // Night time from 6 PM to 6 AM
}
