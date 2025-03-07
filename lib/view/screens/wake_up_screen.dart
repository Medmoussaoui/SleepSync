import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/current_time_widget.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/custom_rounded_button.dart';
import 'package:sleepcyclesapp/components/swipe_up_widget.dart';
import 'package:sleepcyclesapp/controllers/background_image.dart';
import 'package:sleepcyclesapp/controllers/wake_up_screen_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class WakeUpScreen extends StatelessWidget {
  const WakeUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WakeUpScreenController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SwipeUp(
          text: "Swipe up to wake up",
          onSwipe: () {
            controller.wakeUp();
          },
          child: Stack(
            children: [
              BackgroundImageTimeState()
                  .animate(delay: 200.ms)
                  .fade(duration: 1000.ms, curve: Curves.easeInOut),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 30),
                        child: CurrentTimeWidget(),
                      ),
                      Spacer(),
                      Text(
                        "Wake up!",
                        style: AppTextStyles.headline2medium
                            .copyWith(fontSize: 30),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "A great day awaits you",
                        style: AppTextStyles.subtitle1Regular,
                      ),
                      SizedBox(height: 40),
                      CustomRoundedButton(
                        onPressed: () {
                          controller.snoozeFor5Min();
                        },
                        text: "Snooze for 5 min ",
                        icon: CustomIcon(
                          icon: AppIcons.timer,
                          size: 15,
                          color: AppColors.white.withOpacity(0.8),
                        ),
                      ),
                      Spacer(flex: 2),
       
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
