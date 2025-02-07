import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';
import 'package:sleepcyclesapp/utils/pages.dart';

class OnBoardingMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final state = HiveDatabase.db.get("onBoarding");
    if (state == true) {
      return RouteSettings(name: AppRoutes.homeScreen);
    }
    return null;
  }
}
