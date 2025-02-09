import 'package:flutter/material.dart';
import 'package:sleepcyclesapp/utils/functions/is_night_time.dart';
import 'package:sleepcyclesapp/utils/images.dart';

class BackgroundImageTimeState extends StatelessWidget {
  final String? screenImage;

  const BackgroundImageTimeState({
    super.key,
    this.screenImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            screenImage ??
                (isNightTime()
                    ? AppImages.nightScreen
                    : AppImages.morningScreen),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
