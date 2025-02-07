import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/images.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/view/widgets/onBoarding/onboarding_content.dart';
import 'package:sleepcyclesapp/view/widgets/onBoarding/see_the_sience.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Background Picture
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.nightScreen), fit: BoxFit.cover),
            ),
          )
              .animate(delay: 200.ms)
              .fade(duration: 1000.ms, curve: Curves.easeInOut),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
            child: Column(
              children: [
                /// the center image
                Spacer(),

                /// Title & description
                Expanded(
                  child: Column(
                    children: [
                      OnBoardingTitle(title: "Start Your First Night!")
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: -0.5, end: 0, curve: Curves.easeOut),
                      SizedBox(height: 15),
                      OnBoardingDescription(
                              description:
                                  "Set your cycles now and experience better mornings!")
                          .animate()
                          .fadeIn(duration: 700.ms)
                          .slideY(begin: 0.5, end: 0, curve: Curves.easeOut),
                      Spacer(),
                      PrimaryButton(
                        text: "Set My Cycles",
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.homeScreen);
                        },
                      ),
                      SizedBox(height: 20),
                      SeeTheSience().animate(delay: 300.ms).fade(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
