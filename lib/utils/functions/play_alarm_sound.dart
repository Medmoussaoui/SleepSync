import 'package:audioplayers/audioplayers.dart';
import 'package:sleepcyclesapp/models/alarm_sound_model.dart';

Future playCurrentSound(AlarmSoundModel sound) async {
  final player = AudioPlayer();

  final soundSource = sound.isCustomSound
      ? DeviceFileSource(sound.path)
      : AssetSource(sound.path);
  await player.play(soundSource);
}
