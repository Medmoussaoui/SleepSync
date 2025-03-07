import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/routes.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';
import 'package:sleepcyclesapp/utils/music_player.dart';
import 'package:sleepcyclesapp/utils/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppAudioPlayer.initial();
  await HiveDatabase.initial();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.backgroundColor, // Your nav bar color
    systemNavigationBarIconBrightness:
        Brightness.light, // Optional: for nav bar icons
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onBoardingScreen,
      getPages: pages,
      theme: ThemeData(
        applyElevationOverlayColor: false, // Prevents dark mode color filtering
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.white),
        ),
      ),
    );
  }
}


 