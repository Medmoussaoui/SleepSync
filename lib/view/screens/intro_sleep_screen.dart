import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class IntroSleepScreen extends StatelessWidget {
  const IntroSleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                onNextBeforePause: (index, state) async {
                  if (index == 1) {
                    await Future.delayed(120.ms);
                    Get.offAllNamed(
                      AppRoutes.sleepTrackerScreen,
                      arguments: {"cycles": Get.arguments["cycles"]},
                    );
                  }
                },
                animatedTexts: [
                  TyperAnimatedText(
                    curve: Curves.easeIn,
                    // "Drift into rest",
                    "Let go",
                    speed: 200.ms,
                    textStyle: AppTextStyles.headline2bold.copyWith(
                      color: AppColors.relaxWhite,
                      fontSize: 35,
                    ),
                  ),
                  RotateAnimatedText(
                    "we’re here to track",
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: AppColors.relaxGrey,
                      fontSize: 25,
                    ),
                  ),
                ],
              ).animate(delay: 100.ms).fade(),
            ],
          ),
        ),
      ),
    );
  }
}
