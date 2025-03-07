import 'package:get/get.dart';
import 'package:sleepcyclesapp/services/adjust_cycle_duration_service.dart';
import 'package:sleepcyclesapp/utils/settings.dart';

class AdjustCycleMinutesController extends GetxController {
  late int _oldCycleDuration;
  late int cycleDuration;

  setCycleDuration(int duration) {
    cycleDuration = duration;
    // hive here
    update(["duration"]);
  }

  applyChange(Function(int value) callback) {
    if (cycleDuration != _oldCycleDuration) {
      AdjustCycleDurationService().adjust(cycleDuration);
      callback(cycleDuration);
    }
    Get.back();
  }

  @override
  void onInit() {
    _oldCycleDuration = Settings.cycleMinute;
    cycleDuration = _oldCycleDuration;
    super.onInit();
  }
}
