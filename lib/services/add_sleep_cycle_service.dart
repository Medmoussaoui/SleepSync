import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/utils/database_helper.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';

class AddSleepCycleService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> addSleepCycle(SleepCycleModel sleepCycle) async {
    final db = await _dbHelper.database;
    final id = await db.insert('sleep_cycles', sleepCycle.toMap());
    sleepCycle.id = id;
    await HiveDatabase.db.put("sleep_cycles", sleepCycle.toMap());
    return id;
  }
}


