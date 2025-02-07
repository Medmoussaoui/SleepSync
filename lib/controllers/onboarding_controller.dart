import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';
import 'package:sleepcyclesapp/utils/pages.dart';

class OnBoardingScreenController extends GetxController {
  late PageController pageController;

  int currentPage = 1;

  next() {
    if (currentPage > 3) {
      HiveDatabase.db.put("onBoarding", true);
      Get.toNamed(AppRoutes.welcomeScreen);
      return;
      // goo to app
    }
    pageController.nextPage(duration: 400.ms, curve: Curves.easeIn);
    currentPage++;
    update();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }
}
