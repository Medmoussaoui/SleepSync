import 'package:audioplayers/audioplayers.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';

class AppAudioPlayer {
  static late AudioCache audioCash;

  static initial() {
    AudioCache.instance = AudioCache(prefix: AppSounds.root);
  }

  static Future<AudioPlayer> playFromAsset(String name,
      {double? volume}) async {
    final instance = AudioPlayer();
    instance.play(AssetSource(name), volume: volume);
    return instance;
  }
}
