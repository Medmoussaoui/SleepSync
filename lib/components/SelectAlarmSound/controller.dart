import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sleepcyclesapp/entitys/alarm_sound.dart';
import 'package:sleepcyclesapp/utils/sounds.dart';

final AlarmSoundEntity fakeMusic =
    AlarmSoundEntity(name: "Choose from this device", path: "/xxx/xxx");

class SelectAlarmSoundController extends GetxController {
  final AudioPlayer audioInstance = AudioPlayer();
  final RxInt selectedSound =
      0.obs; // Default selection is the first item (index 0)
  final Rx<AlarmSoundEntity?> customSound = Rx<AlarmSoundEntity?>(null);
  final RxBool musicPlaying = false.obs;

  final List<AlarmSoundEntity> alarmSounds = [
    AlarmSoundEntity(name: "Gentle Sunrise", path: "/xxx/xxx"),
    AlarmSoundEntity(name: "Soft Chimes", path: "/xxx/xxx"),
    AlarmSoundEntity(name: "Morning Breeze", path: "/xxx/xxx"),
    fakeMusic,
  ];

  @override
  void onInit() {
    super.onInit();
    audioInstance.onPlayerComplete.listen((event) {
      musicPlaying.value = false;
    });
  }

  Future<void> selectAlarmSound(int index) async {
    if (index == selectedSound.value) return;

    musicPlaying.value = true;
    selectedSound.value = index;
    customSound.value = null; // Reset custom sound when selecting from list

    // Stop any existing audio before playing a new one
    await audioInstance.stop();
    await audioInstance.play(AssetSource(AppSounds.tick));
  }

  AlarmSoundEntity getSelectedAlarmSound() {
    return customSound.value ?? alarmSounds[selectedSound.value];
  }

  Future<void> selectCustomSound() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio, // Only allow audio files
    );

    if (result != null && result.files.single.path != null) {
      setSelectCustomSound(AlarmSoundEntity(
        name: result.files.single.name,
        path: result.files.single.path!,
      ));
    }
  }

  void setSelectCustomSound(AlarmSoundEntity sound) {
    customSound.value = sound;
    selectedSound.value = -1; // Indicates custom sound selection
  }
}
