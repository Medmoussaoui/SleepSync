import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/channels/athan_chaanel.dart';
import 'package:sleepcyclesapp/channels/overlay_lock_screen.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/controllers/background_image.dart';
import 'package:sleepcyclesapp/controllers/home_screen_controller.dart';
import 'package:sleepcyclesapp/utils/functions/request_overlay_permission.dart';
import 'package:sleepcyclesapp/utils/pages.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/build_sleep_metrics.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/say_good_night_or_morning.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/sleep_information.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreeController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackgroundImageTimeState()
              .animate(delay: 200.ms)
              .fade(duration: 1000.ms, curve: Curves.easeInOut),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SayGoodMorningOrNightWithTime(),
                SizedBox(height: Get.height * 0.1),
                SleepInformation().animate().fade(),
                SizedBox(height: 20),
                BuildSleepMetrics(),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: PrimaryButton(
                    text: "Begin Sleep Cycles",
                    onPressed: () async {
                      await requestOverlayPermission();
                      OverlayLockScreen.showOverlay();
                      // Get.toNamed(AppRoutes.wakeUpScreen);
                      Get.toNamed(AppRoutes.beginCyclesScreen);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

@pragma('vm:entry-point')
void startForegroundTask() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.setTaskHandler(AthanTaskHandler());
}

class AthanTaskHandler extends TaskHandler {
  @override
  Future<void> onDestroy(DateTime timestamp) async {}

  @override
  void onRepeatEvent(DateTime timestamp) async {}

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    print("-----------------> Task Runing...");
    AthanScreen.showAthanScreen();
  }
}

void initServiceForeground() {
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'foreground_service',
      channelName: 'Foreground Service Notification',
      channelDescription:
          'This notification appears when the foreground service is running.',
      onlyAlertOnce: true,
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: false,
      playSound: false,
    ),
    foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.nothing(),
    ),
  );
}
