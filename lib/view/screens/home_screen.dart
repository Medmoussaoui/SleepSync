import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/controllers/background_image.dart';
import 'package:sleepcyclesapp/controllers/home_screen_controller.dart';
import 'package:sleepcyclesapp/services/SleepTrackerService/vibration_notifier.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/build_sleep_metrics.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/say_good_night_or_morning.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/sleep_information.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  testLoadIcon() async {
    try {
      await rootBundle.load('assets/icons/sleep.png');
      print("✅ Asset exists!");
    } catch (e) {
      print("❌ Asset not found: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreeController());
    testLoadIcon();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackgroundImageTimeState()
              .animate(delay: 200.ms)
              .fade(duration: 1000.ms, curve: Curves.easeInOut),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SayGoodMorningOrNightWithTime(),
                SizedBox(height: Get.height * 0.1),
                SleepInformation().animate().fade(),
                SizedBox(height: 20),
                BuildSleepMetrics(),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: PrimaryButton(
                    text: "Begin Sleep Cycles",
                    onPressed: () {
                       Get.toNamed(AppRoutes.beginCyclesScreen);
                      // VibrationNotifier().sendVibration();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
