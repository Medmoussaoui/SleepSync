import 'package:get/get.dart';
import 'package:sleepcyclesapp/middlewares/onboarding_middleware.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/view/screens/begin_cycles_screen.dart';
import 'package:sleepcyclesapp/view/screens/home_screen.dart';
import 'package:sleepcyclesapp/view/screens/onboarding_screen.dart';
import 'package:sleepcyclesapp/view/screens/settings_screen.dart';
import 'package:sleepcyclesapp/view/screens/welcome_screen.dart';

List<GetPage<dynamic>>? pages = [
  GetPage(
    name: AppRoutes.onBoardingScreen,
    middlewares: [OnBoardingMiddleware()],
    page: () => const OnBoardingScreen(),
  ),
  GetPage(
    name: AppRoutes.welcomeScreen,
    page: () => const WelcomeScreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: AppRoutes.settingsScreen,
    page: () => const SettingsScreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: AppRoutes.homeScreen,
    page: () => const HomeScreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: AppRoutes.beginCyclesScreen,
    page: () => const BeginCyclesScreen(),
    transition: Transition.cupertino,
  ),
];
