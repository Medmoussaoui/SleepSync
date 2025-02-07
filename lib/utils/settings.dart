import 'package:sleepcyclesapp/utils/hive_database.dart';

class Settings {
  static int get cycleMinute {
    final value = HiveDatabase.db.get("cycleMinutes");
    if (value == null) return 90;
    return value;
  }
}
