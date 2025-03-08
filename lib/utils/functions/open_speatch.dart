import 'package:audioplayers/audioplayers.dart';
import 'package:sleepcyclesapp/utils/music_player.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';

Future openSpeech(String source,
    {bool beginSound = true, double? volume}) async {
  if (beginSound == false) {
    AppAudioPlayer.playFromAsset(source, volume: volume ?? 0.30);
    return;
  }
  final ref =
      await AppAudioPlayer.playFromAsset(AppSounds.notification, volume: 0.30);
  ref.onPlayerStateChanged.listen((event) {
    if (event == PlayerState.completed) {
      AppAudioPlayer.playFromAsset(source, volume: volume ?? 0.30);
    }
  });
}
