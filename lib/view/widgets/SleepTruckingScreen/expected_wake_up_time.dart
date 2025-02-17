import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/text_with_icon.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/expected_wakeup_time.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class ExpectedWakeupTime extends StatelessWidget {
  final int cycles;
  final int avgSleepAfter;
  final DateTime bedTime;
  final TextStyle? style;
  final Color? iconColor;

  const ExpectedWakeupTime({
    super.key,
    required this.cycles,
    required this.avgSleepAfter,
    required this.bedTime,
    this.style,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextWithIcon(
      style: style ??
          AppTextStyles.subtitle3Light.copyWith(
            color: AppColors.secondaryTextColor.withOpacity(0.8),
          ),
      text: getExpectedWakeUpTime(bedTime, cycles, Duration(minutes: 25)),
      icon: CustomIcon(
        size: 13,
        icon: AppIcons.notification,
        color: iconColor ?? AppColors.secondaryTextColor.withOpacity(0.8),
      ),
    );
  }
}
