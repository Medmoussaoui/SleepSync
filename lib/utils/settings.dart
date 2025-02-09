import 'package:hive/hive.dart';
import 'package:sleepcyclesapp/Data/alarm_sounds_data.dart';
import 'package:sleepcyclesapp/models/alarm_sound_model.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';

class Settings {
  static int get cycleMinute {
    final value = HiveDatabase.db.get("cycleMinutes");
    if (value == null) return 90;
    return value;
  }

  static AlarmSoundModel get alarmSound {
    final sound = HiveDatabase.db.get("alarmSound");
    if (sound != null) return AlarmSoundModel.fromJson(sound);
    return alarmSoundsData.first;
  }

  static bool get noiseTracking {
    return HiveDatabase.db.get("noiseTracking") ?? true;
  }
}
