import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/functions/is_night_time.dart';
import 'package:sleepcyclesapp/utils/images.dart';

class BackgroundImageTimeState extends StatelessWidget {
  const BackgroundImageTimeState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            isNightTime() ? AppImages.nightScreen : AppImages.morningScreen,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
