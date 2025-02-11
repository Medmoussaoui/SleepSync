import 'package:intl/intl.dart';

String hourAndMinute(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}
