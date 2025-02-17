import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';

class AddSleepCycleTemporaryService {
  Future<void> add(SleepCycleModel sleepCycle) async {
    await HiveDatabase.db.put("sleep_cycles", sleepCycle.toMap());
  }
}
