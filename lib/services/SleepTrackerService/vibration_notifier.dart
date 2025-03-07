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
  }

  Future<void> sendVibration() async {
    AppAudioPlayer.playFromAsset(AppSounds.notification, volume: 0.60);
    await Vibration.vibrate(
        pattern: vebrationPatterns[vebrationType!.sensitivity]!);
  }
}
