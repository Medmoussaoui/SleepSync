import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/utils/database_helper.dart';

class UpdateSleepCycleService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> updateSleepCycle(SleepCycleModel sleepCycle) async {
    final db = await _dbHelper.database;
    return await db.update(
      'sleep_cycles',
      sleepCycle.toMap(),
      where: 'id = ?',
      whereArgs: [sleepCycle.id],
    );
  }
}
