import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/get_formated_time.dart';
import 'package:sleepcyclesapp/utils/functions/is_night_time.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class SayGoodMorningOrNightWithTime extends StatelessWidget {
  const SayGoodMorningOrNightWithTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isNight = isNightTime();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isNight ? "Good Night," : "Good Morning,",
          style: AppTextStyles.headline2medium,
        ),
        SizedBox(height: 2),
        Text(
          getFormattedTime(),
          style: AppTextStyles.subtitle3Light.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
