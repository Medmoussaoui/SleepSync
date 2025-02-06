import 'package:get/get.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/view/home_screen.dart';
import 'package:sleepcyclesapp/view/onBoarding/onboarding_screen.dart';
import 'package:sleepcyclesapp/view/settings_screen.dart';
import 'package:sleepcyclesapp/view/welcome_screen.dart';

List<GetPage<dynamic>>? pages = [
  GetPage(
    name: AppRoutes.onBoardingScreen,
    page: () => const OnBoardingScreen(),
  ),
  GetPage(
      name: AppRoutes.welcomeScreen,
      page: () => const WelcomeScreen(),
      transition: Transition.cupertino),
  GetPage(
      name: AppRoutes.settingsScreen,
      page: () => const SettingsScreen(),
      transition: Transition.cupertino),
  GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.cupertino),
];
