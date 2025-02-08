import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/entitys/sleep_metric_entity.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';

class HomeScreeController extends GetxController {
  bool isLoading = false;
  List<SleepMetricEntity> metrics = [];

  Future<void> loadSleepMatrics() async {
    isLoading = true;
    update();
    await Future.delayed(2000.ms);
    metrics = _fakeMetricsData();

    isLoading = false;
    update();
  }

  List<SleepMetricEntity> _fakeMetricsData() {
    return [
      SleepMetricEntity(
          symbol: AppIcons.sleep,
          mitrixName: "Sleep duration",
          value: "7 hrs, 30 Min"),
      SleepMetricEntity(
          symbol: AppIcons.donecycle,
          mitrixName: "Completed cycle",
          value: "03 Cycles"),
      SleepMetricEntity(
          symbol: AppIcons.timer,
          mitrixName: "Avg, asleep after",
          value: "27 min"),
      SleepMetricEntity(
          symbol: AppIcons.wakeup,
          mitrixName: "Avg, wake up after",
          value: "15 min"),
    ];
  }

  @override
  void onInit() {
    loadSleepMatrics();
    super.onInit();
  }
}
