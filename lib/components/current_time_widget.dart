import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/hour_and_minutes.dart';
import 'package:sleepcyclesapp/utils/functions/hour_and_minutes_and_day.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class CurrentTimeWidget extends StatefulWidget {
  final TextStyle? style;
  final bool? includeDayName;

  const CurrentTimeWidget({
    super.key,
    this.style,
    this.includeDayName,
  });

  @override
  CurrentTimeWidgetState createState() => CurrentTimeWidgetState();
}

class CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  DateTime _currentTime = DateTime.now();
  late StreamSubscription _timeSubscription;

  @override
  void initState() {
    super.initState();
    _startListeningToTimeChanges();
  }

  void _startListeningToTimeChanges() {
    _timeSubscription = Stream.periodic(const Duration(seconds: 5)).listen((_) {
      DateTime newTime = DateTime.now();

      if (_currentTime.minute != newTime.minute) {
        setState(() {
          _currentTime = newTime; // Update UI when the minute changes
        });
      }
    });
  }

  @override
  void dispose() {
    _timeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.includeDayName == true
          ? hourAndMinuteAndDay(_currentTime)
          : hourAndMinute(_currentTime),
      style: widget.style ??
          AppTextStyles.subtitle3Light.copyWith(
            fontSize: 40,
            color: AppColors.white.withOpacity(0.4),
          ),
    );
  }
}
