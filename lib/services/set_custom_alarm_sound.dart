import 'package:sleepcyclesapp/models/alarm_sound_model.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';

class SetAlarmSoundService {
  Future<void> excute(AlarmSoundModel sound) async {
    await HiveDatabase.db.put("alarmSound", sound.toJson());
  }
}
