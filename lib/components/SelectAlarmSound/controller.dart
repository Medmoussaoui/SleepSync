import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sleepcyclesapp/Data/alarm_sounds_data.dart';
import 'package:sleepcyclesapp/models/alarm_sound_model.dart';
import 'package:sleepcyclesapp/services/set_custom_alarm_sound.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:path/path.dart' as p;

class SelectAlarmSoundController extends GetxController {
  late final SetAlarmSoundService setAlarmSoundService;

  final List<AlarmSoundModel> alarmSounds = defaultAlarmSounds;
  final RxBool musicPlaying = false.obs;
  final AudioPlayer audioInstance = AudioPlayer();
  final RxInt selectedSound = RxInt(-1);

  AlarmSoundModel? customSound;

  AlarmSoundModel getSelectedAlarmSound() {
    if (customSound != null) return customSound!;
    return alarmSounds[selectedSound.value];
  }

  Future<AlarmSoundModel> saveSound() async {
    final sound = getSelectedAlarmSound();
    await setAlarmSoundService.excute(sound);
    return sound;
  }

  Future<void> selectFromDefault(int index) async {
    if (index == selectedSound.value) return;
    selectedSound.value = index;
    customSound = null;
    AlarmSoundModel sound = alarmSounds[selectedSound.value];
    playSound(sound);
  }

  Future playSound(AlarmSoundModel sound) async {
    audioInstance.stop();
    await audioInstance.play(_soundSource(sound));
  }

  Source _soundSource(AlarmSoundModel sound) {
    if (sound.isCustomSound) return DeviceFileSource(sound.path);
    return AssetSource(sound.path);
  }

  Future<void> selectFromDevice() async {
    audioInstance.stop();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio, // Only allow audio files
    );

    if (result != null && result.files.single.path != null) {
      customSound = AlarmSoundModel(
        source: AlarmSoundSource.custom,
        name: p.basenameWithoutExtension(
            result.files.single.name), // Remove extension
        path: result.files.single.path!,
      );
      selectedSound.value = -1;
    }
  }

  initialAlarmSound() {
    final sound = Settings.alarmSound;
    if (sound.isCustomSound) {
      customSound = sound;
    } else {
      selectedSound.value =
          alarmSounds.indexWhere((item) => item.name == sound.name);
    }
  }

  @override
  void onInit() {
    super.onInit();
    initialAlarmSound();
    setAlarmSoundService = SetAlarmSoundService();

    audioInstance.onPlayerStateChanged.listen((event) {
      musicPlaying.value = event == PlayerState.playing;
    });
  }

  @override
  void onClose() {
    audioInstance.stop();
    super.onClose();
  }
}
