import 'package:intl/intl.dart';

String getFormattedTime() {
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('hh:mm a - EEEE').format(now);
  return formattedTime;
}
