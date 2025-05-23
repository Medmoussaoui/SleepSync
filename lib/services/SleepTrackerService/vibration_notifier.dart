import 'package:audioplayers/audioplayers.dart';
import 'package:sleepcyclesapp/components/selectVebration/controller.dart';
import 'package:sleepcyclesapp/entitys/vebration_type_entity.dart';
import 'package:sleepcyclesapp/utils/music_player.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';
import 'package:vibration/vibration.dart';

class VibrationNotifier {
  VebrationTypeEntity? vebrationType;

  VibrationNotifier({this.vebrationType}) {
    vebrationType ??= Settings.vebrationType;
    loadSound();
  }

  List<int> get pattern => vebrationPatterns[vebrationType!.sensitivity]!;

  bool isRuning = false;
  String? soundPath;
  AudioPlayer player = AudioPlayer();

  loadSound() async {
    if (soundPath == null) {
      final path = await AppAudioPlayer.audioCash.load(AppSounds.smoth);
      soundPath = path.path;
      player.play(DeviceFileSource(soundPath!), volume: 0.0);
    }
  }

  stop({bool useSound = true}) async {
    /// TODO: remove down comment
    // if (!isRuning) return;
    isRuning = false;
    if (useSound) notifySound();
    await Vibration.cancel();
  }

  notifySound() {
    if (soundPath == null) return;
    player.play(DeviceFileSource(soundPath!), volume: 1.0);
  }

  play() {
    if (isRuning) Vibration.cancel();
    isRuning = true;
    Vibration.vibrate(
      pattern: [70, 30, 0, 100, 240, 70, 30, 0],
      repeat: 1,
    );
  }
}
