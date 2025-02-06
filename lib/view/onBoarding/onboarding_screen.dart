import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/Data/index.dart';
import 'package:sleepcyclesapp/Data/onboarding_data.dart';
import 'package:sleepcyclesapp/controllers/onboedin_controller.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/view/onBoarding/onboarding_content.dart';
import 'package:sleepcyclesapp/view/onBoarding/onboarding_progress.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF233050), // Match your background color
      statusBarIconBrightness: Brightness.light, // Light icons for contrast
      systemNavigationBarColor:
          Color(0xFF233050), // Match bottom bar with background
      systemNavigationBarIconBrightness:
          Brightness.light, // Light icons for contrast
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingScreenController());
    final items = LocalData.onBoarding;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
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
      ),
    );
  }
}
