import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/routes.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';
import 'package:sleepcyclesapp/utils/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Hide the bottom navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // Blend status bar and navigation bar with the background color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //Color(0xFF233050), // Match your background color
    statusBarIconBrightness: Brightness.light, // Light icons for contrast
    systemNavigationBarColor:
        Color(0xFF233050), // Match bottom bar with background
    systemNavigationBarIconBrightness:
        Brightness.light, // Light icons for contrast
  ));

  await HiveDatabase.initial();
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
    );
  }
}
