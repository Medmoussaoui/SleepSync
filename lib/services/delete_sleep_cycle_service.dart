import 'package:sleepcyclesapp/utils/database_helper.dart';

class DeleteSleepCycleService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> deleteSleepCycle(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'sleep_cycles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
