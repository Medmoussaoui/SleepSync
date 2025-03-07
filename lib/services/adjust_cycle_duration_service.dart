import 'package:sleepcyclesapp/utils/hive_database.dart';

class AdjustCycleDurationService {
  ///
  /// [duration] is the duration in minutes of the sleep cycle
  ///
  Future<void> adjust(int duration) async {
    await HiveDatabase.db.put("cycleMinutes", duration);
  }
}
