import 'package:sleepcyclesapp/services/new_sleep_delay_persontage.dart';
import 'package:sleepcyclesapp/utils/settings.dart';

class SleepTimeEstimator {
  final NewsleepDelayPercentage sleepDelayStorage;
  static const double defaultPercentage = 0.4;

  SleepTimeEstimator({required this.sleepDelayStorage});

  double _getAdaptivePercentage() {
    final percentages = Settings.sleepDelayPercentages;
    return percentages.isEmpty 
      ? defaultPercentage 
      : percentages.reduce((a, b) => a + b) / percentages.length;
  }

  Future<DateTime> estimateSleepTime(DateTime detectedSleepTime, DateTime? lastCheckTime) async {
    if (lastCheckTime == null) return detectedSleepTime;

    final elapsed = detectedSleepTime.difference(lastCheckTime);
    final adaptivePercentage = _getAdaptivePercentage();
    final estimatedOffset = (elapsed.inSeconds * adaptivePercentage).toInt();
    
    await sleepDelayStorage.addNew(
      elapsed.inSeconds > 0 ? estimatedOffset / elapsed.inSeconds : defaultPercentage
    );

    return detectedSleepTime.subtract(Duration(seconds: estimatedOffset));
  }
}