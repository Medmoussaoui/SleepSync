import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/index.dart';
import 'package:sleepcyclesapp/controllers/onboarding_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/functions/request_overlay_permission.dart';
import 'package:sleepcyclesapp/view/widgets/onBoarding/onboarding_content.dart';
import 'package:sleepcyclesapp/view/widgets/onBoarding/onboarding_progress.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    requestOverlayPermission();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingScreenController());
    final items = LocalData.onBoarding;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      // backgroundColor: Color(0xff35425E),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 25, right: 25),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            /// Pages
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: List.generate(
                items.length,
                (index) => OnBoardingContent(
                  assetImage: items[index].assetImage,
                  title: items[index].title,
                  description: items[index].description,
                  imageSize: items[index].imageSize,
                ),
              ),
            ),

            /// Progress and --> see the sience
            Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder<OnBoardingScreenController>(
                builder: (con) {
                  return OnBoardingProgress(
                    steep: con.currentPage,
                    onTap: () => controller.next(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
