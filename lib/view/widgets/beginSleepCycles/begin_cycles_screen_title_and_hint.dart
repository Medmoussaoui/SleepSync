import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class BeginCyclesScreenTitleAndHint extends StatelessWidget {
  const BeginCyclesScreenTitleAndHint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Set Your Cycles",
          style: AppTextStyles.headline3medium,
        ),
        SizedBox(height: 3),
        Text(
          "Move the clock left or right to set cycles",
          style: AppTextStyles.subtitle4Light,
        ),
      ],
    );
  }
}
