import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/routes.dart';
import 'package:sleepcyclesapp/utils/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
// Hide the bottom navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Blend status bar and navigation bar with the background color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF233050), // Match your background color
    statusBarIconBrightness: Brightness.light, // Light icons for contrast
    systemNavigationBarColor:Color(0xFF233050), // Match bottom bar with background
    systemNavigationBarIconBrightness: Brightness.light, // Light icons for contrast
  ));

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
