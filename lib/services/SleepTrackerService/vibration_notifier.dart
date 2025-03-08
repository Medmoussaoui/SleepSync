import 'package:sleepcyclesapp/components/selectVebration/controller.dart';
import 'package:sleepcyclesapp/entitys/vebration_type_entity.dart';
import 'package:sleepcyclesapp/utils/functions/open_speatch.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';
import 'package:vibration/vibration.dart';

class VibrationNotifier {
  VebrationTypeEntity? vebrationType;

  VibrationNotifier({this.vebrationType}) {
    vebrationType ??= Settings.vebrationType;
  }

  Future<void> sendVibration() async {
    openSpeech(AppSounds.areYouSleep);
    await Vibration.vibrate(
        pattern: vebrationPatterns[vebrationType!.sensitivity]!);
  }
}
