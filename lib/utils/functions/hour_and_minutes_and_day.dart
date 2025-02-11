import 'package:intl/intl.dart';

String hourAndMinuteAndDay(DateTime dateTime) {
  return DateFormat('hh:mm a - EEEE').format(dateTime);
}
