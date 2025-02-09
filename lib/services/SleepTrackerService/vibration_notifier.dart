import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class VibrationNotifier {
  Future<void> sendVibration() async {
    // if (await Vibration.hasVibrator()) {}
    await Vibration.vibrate(preset: VibrationPreset.pulseWave);
  }
}
