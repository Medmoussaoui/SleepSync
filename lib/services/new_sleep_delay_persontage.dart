import 'package:sleepcyclesapp/utils/hive_database.dart';
import 'package:sleepcyclesapp/utils/settings.dart';



class NewsleepDelayPercentage {
  Future<void> addNew(double newPercentage) async {
    final sleepDelayPercentages = Settings.sleepDelayPercentages;
    // Store the new percentage (limit to last 10 entries for better accuracy)
    if (sleepDelayPercentages.length >= 10) sleepDelayPercentages.removeAt(0);
    sleepDelayPercentages.add(newPercentage);
    await HiveDatabase.db.put("sleepDelayPercentages", sleepDelayPercentages);
  }
}
