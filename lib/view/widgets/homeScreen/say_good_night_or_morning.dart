import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/current_time_widget.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/is_night_time.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class SayGoodMorningOrNightWithTime extends StatelessWidget {
  const SayGoodMorningOrNightWithTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isNight = isNightTime();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isNight ? "Good Night," : "Good Morning,",
              style: AppTextStyles.headline2medium,
            ),
            SizedBox(height: 2),
            CurrentTimeWidget(
              style: AppTextStyles.subtitle3Light.copyWith(
                color: AppColors.white,
              ),
              includeDayName: true,
            ),
          ],
        ),
        Spacer(),
        // Settings Symbol
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.settingsScreen);
          },
          icon: CustomIcon(
            icon: AppIcons.settings,
            size: 24,
          ),
        )
      ],
    );
  }
}
