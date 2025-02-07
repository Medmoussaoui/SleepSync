import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class SleepInformation extends StatelessWidget {
  const SleepInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Sleep Information",
          style: AppTextStyles.headline3regular,
        ),
        SizedBox(width: 5.0),
        Text(
          "(during 24h)",
          style: AppTextStyles.subtitle4Regular,
        ),
      ],
    );
  }
}
