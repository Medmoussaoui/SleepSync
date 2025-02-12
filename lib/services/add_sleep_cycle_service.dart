import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/utils/database_helper.dart';

class AddSleepCycleService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> addSleepCycle(SleepCycleModel sleepCycle) async {
    final db = await _dbHelper.database;
    return await db.insert('sleep_cycles', sleepCycle.toMap());
  }
}
