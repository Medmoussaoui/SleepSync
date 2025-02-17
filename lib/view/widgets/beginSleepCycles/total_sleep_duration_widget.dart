import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/text_with_icon.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class TotalSleepDurationWidget extends StatelessWidget {
  final String value;
  final Color? color;

  const TotalSleepDurationWidget({
    super.key,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextWithIcon(
      text: value,
      style: AppTextStyles.headline3medium
          .copyWith(color: color ?? AppColors.blue),
      icon: CustomIcon(icon: AppIcons.sleep, color: color ?? AppColors.blue),
    );
  }
}
