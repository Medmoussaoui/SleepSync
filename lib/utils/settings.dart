import 'package:sleepcyclesapp/Data/alarm_sounds_data.dart';
import 'package:sleepcyclesapp/models/alarm_sound_model.dart';
import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
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
    return defaultAlarmSounds.first;
  }

  static bool get noiseTracking {
    return HiveDatabase.db.get("noiseTracking") ?? true;
  }

  static SleepCycleModel? get currentSleepSession {
    final result = HiveDatabase.db.get("currentSleepSession");
    if (result == null) return null;
    final model = SleepCycleModel.fromMap(result);
    if (model.endTime != null || model.state == "end") {
      HiveDatabase.db.delete("currentSleepSession");
      return null;
    }
    return model;
  }
}
