import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/controllers/background_image.dart';
import 'package:sleepcyclesapp/controllers/home_screen_controller.dart';
import 'package:sleepcyclesapp/utils/functions/fill_mobile_screen.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/build_sleep_metrics.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/say_good_night_or_morning.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/sleep_information.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreeController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackgroundImageTimeState().animate(delay: 200.ms).fade(
                duration: 1000.ms,
                curve: Curves.easeInOut,
                begin: 0.7,
                end: 1.0,
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SayGoodMorningOrNightWithTime(),
                SizedBox(height: Get.height * 0.1),
                SleepInformation().animate(delay: 250.ms).fade(),
                SizedBox(height: 20),
                BuildSleepMetrics(),
                Spacer(),
                PrimaryButton(
                  text: "Begin Sleep Cycles",
                  onPressed: () async {
                    await Future.delayed(100.ms);
                    Get.toNamed(AppRoutes.beginCyclesScreen);
                  },
                ).animate(delay: 120.ms).moveY(begin: 50, end: 0).fade(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
