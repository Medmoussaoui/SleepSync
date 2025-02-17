import 'package:volume_controller/volume_controller.dart';

Future<void> maxVolume({double volume = 1}) async {
  await VolumeController.instance.setVolume(volume);
}
