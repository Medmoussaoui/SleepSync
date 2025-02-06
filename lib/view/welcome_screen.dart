import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleepcyclesapp/components/clock.dart';
import 'package:sleepcyclesapp/components/custom_bottom_sheet.dart';
import 'package:sleepcyclesapp/components/custom_dialog.dart';
import 'package:sleepcyclesapp/components/custom_divider.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/custom_rounded_button.dart';
import 'package:sleepcyclesapp/components/custom_switch_button.dart';
import 'package:sleepcyclesapp/components/custom_tile.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/components/text_with_icon.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/custom_show_dialog.dart';
import 'package:sleepcyclesapp/utils/icons.dart';
import 'package:sleepcyclesapp/utils/images.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';
import 'package:sleepcyclesapp/view/onBoarding/onboarding_content.dart';
import 'package:sleepcyclesapp/view/onBoarding/see_the_sience.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // AnimatedClock(),
          // Clock(),
          ClockCounter(
            max: 10,
            min: 1,
            initialValue: 1,
            onMoving: (value) {},
            onChange: (value) {},
          ),
          // TextWithIcon(
          //   text: "7 hrs, 30 Min",
          //   icon: Icon(Icons.face, color: AppColors.blue),
          // ),
          // TextWithIcon(
          //   text: "6:30 -7:00 AM",
          //   style: AppTextStyles.subtitle3Light.copyWith(
          //     color: AppColors.secondaryTextColor.withOpacity(0.8),
          //   ),
          //   icon: Icon(
          //     Icons.notifications_active_outlined,
          //     size: 19,
          //     color: AppColors.secondaryTextColor.withOpacity(0.8),
          //   ),
          // ),
          PrimaryButton(
            text: 'Apply',
            onPressed: () {
              customShowDialog(
                CustomDialog(
                  title: "Settings",
                  subtitle: "Move the clock left or right to change",
                  // content: ClockCounter(
                  //   max: 10,
                  //   min: 1,
                  //   onMoving: (v) {},
                  //   onChange: (v) {},
                  //   initialValue: 1,
                  // ),
                  content: CustomTile(
                    title: "Gentle Sunrise",
                    subtitle: "dsdssd",
                    onTap: () {},
                    borderColor: Colors.white.withOpacity(0.07),
                    leadingIcon: CustomIcon(
                      background: true,
                      icon: AppImages.timer,
                    ),
                    trailingWidget: Icon(Icons.check),
                  ),
                  action: PrimaryButton(
                    text: "Apply",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              );
              // showDialog(
              //   context: context,
              //   barrierColor: Colors.transparent,
              //   builder: (_) {
              //     return
              //   },
              // );
            },
          ),
          CustomSwitchButton(isChecked: false),
          CustomRoundedButton(
            text: "Snooze for 10 min",
            icon: CustomIcon(
              icon: AppImages.timer,
              size: 20,
              color: AppColors.white.withOpacity(0.8),
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTile(
              title: "Gentle Sunrise",
              subtitle: "dsdssd",
              onTap: () {},
              borderColor: Colors.white.withOpacity(0.07),
              leadingIcon: CustomIcon(
                background: true,
                icon: AppImages.timer,
              ),
              trailingWidget: Icon(Icons.check),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTile(
              title: "Gentle Sunrise",
              onTap: () {},
              borderColor: Colors.white.withOpacity(0.07),
              leadingIcon: CustomIcon(
                background: true,
                icon: AppImages.timer,
              ),
              trailingWidget: Icon(Icons.check),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTile(
              title: "35 dB Good",
              subtitle: "Average, noise level",
              onTap: () {},
              backgroundColor: Colors.white.withOpacity(0.05),
              trailingWidget: Icon(Icons.volume_up),
            ),
          ),

          Container(
            color: Colors.white.withOpacity(0.05),
            margin: EdgeInsets.symmetric(horizontal: 20),
            // padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTile(
                  title: "35 dB Good",
                  subtitle: "Average, noise level",
                  onTap: () {},
                  trailingWidget: Icon(Icons.volume_up),
                ),
                // SizedBox(height: 15),
                CustomDivider(vertialPadding: 0),
                // SizedBox(height: 15),
                CustomTile(
                  title: "35 dB Good",
                  subtitle: "Average, noise level",
                  onTap: () {},
                  trailingWidget: Icon(Icons.volume_up),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     // Background Picture
      //     Container(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage(AppImages.night), fit: BoxFit.cover),
      //       ),
      //     )
      //         .animate(delay: 200.ms)
      //         .fade(duration: 1000.ms, curve: Curves.easeInOut),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
      //       child: Column(
      //         children: [
      //           /// the center image
      //           Expanded(
      //             child: OnBoardingImage(
      //                 assetImage: AppImages.moon, imageSize: 126),
      //           )
      //               .animate(delay: 200.ms)
      //               .fade(
      //                 duration: 400.ms,
      //                 curve: Curves.easeIn,
      //               )
      //               .slideY(begin: -0.1, end: 0, curve: Curves.easeOut),

      //           /// Title & description
      //           Expanded(
      //             child: Column(
      //               children: [
      //                 OnBoardingTitle(title: "Start Your First Night!")
      //                     .animate()
      //                     .fadeIn(duration: 500.ms)
      //                     .slideY(begin: -0.5, end: 0, curve: Curves.easeOut),
      //                 SizedBox(height: 15),
      //                 OnBoardingDescription(
      //                         description:
      //                             "Set your cycles now and experience better mornings!")
      //                     .animate()
      //                     .fadeIn(duration: 700.ms)
      //                     .slideY(begin: 0.5, end: 0, curve: Curves.easeOut),
      //                 Spacer(),
      //                 PrimaryButton(
      //                   text: "Set My Cycles",
      //                   onPressed: () {},
      //                 ),
      //                 SizedBox(height: 20),
      //                 SeeTheSience().animate(delay: 300.ms).fade(),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
