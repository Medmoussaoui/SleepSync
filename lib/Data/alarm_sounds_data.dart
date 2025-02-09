import 'package:sleepcyclesapp/models/alarm_sound_model.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';

final List<AlarmSoundModel> alarmSoundsData = [
  AlarmSoundModel(
    source: AlarmSoundSource.app,
    name: "Morning Joy",
    path: AppSounds.morningJoy,
  ),
  AlarmSoundModel(
    source: AlarmSoundSource.app,
    name: "The Graceful ladybug",
    path: AppSounds.theGracefulladybug,
  ),
  AlarmSoundModel(
    source: AlarmSoundSource.app,
    name: "Ringtone",
    path: AppSounds.ringtone,
  ),
];
