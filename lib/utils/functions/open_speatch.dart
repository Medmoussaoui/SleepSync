import 'package:audioplayers/audioplayers.dart';
import 'package:sleepcyclesapp/utils/music_player.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';

Future openSpeech(String source,
    {bool beginSound = true, double? volume = 0.05}) async {
  if (beginSound == false) {
    AppAudioPlayer.playFromAsset(source, volume: volume);
    return;
  }
  final notification = await AppAudioPlayer.playFromAsset(AppSounds.notification, volume: 0.07);
  notification.onPlayerStateChanged.listen((event) {
    if (event == PlayerState.completed) {
      AppAudioPlayer.playFromAsset(source, volume: volume ?? volume);
    }
  });
}
