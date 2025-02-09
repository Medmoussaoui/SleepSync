import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sleepcyclesapp/Data/alarm_sounds_data.dart';
import 'package:sleepcyclesapp/models/alarm_sound_model.dart';
import 'package:sleepcyclesapp/services/set_custom_alarm_sound.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:path/path.dart' as p;

final noCustomSound = AlarmSoundModel(
  source: AlarmSoundSource.none,
  path: "",
  name: "Chose from this device",
);

class SelectAlarmSoundController extends GetxController {
  late final SetAlarmSoundService setAlarmSoundService;

  final AudioPlayer audioInstance = AudioPlayer();
  late final RxInt selectedSound;
  final RxBool musicPlaying = false.obs;

  late final List<AlarmSoundModel> alarmSounds;

  Future<AlarmSoundModel> saveSound() async {
    final sound = getSelectedAlarmSound();
    await setAlarmSoundService.excute(sound);
    Get.back();
    return sound;
  }

  Future<void> selectAlarmSound(int index) async {
    if (selectedSound.value == alarmSounds.length - 1) {
      alarmSounds[alarmSounds.length - 1] = noCustomSound;
    }

    if (index == selectedSound.value) {
      return playCurrentSound();
    }

    musicPlaying.value = true;
    selectedSound.value = index;
    await playCurrentSound();
  }

  Future stopExistingAudio() async {
    musicPlaying.value = false;
    await audioInstance.stop();
  }

  Future playCurrentSound() async {
    stopExistingAudio();
    musicPlaying.value = true;
    AlarmSoundModel sound = alarmSounds[selectedSound.value];
    final soundSource = sound.isCustomSound
        ? DeviceFileSource(sound.path)
        : AssetSource(sound.path);
    await audioInstance.play(soundSource);
  }

  AlarmSoundModel getSelectedAlarmSound() => alarmSounds[selectedSound.value];

  Future<void> selectCustomSound() async {
    stopExistingAudio();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio, // Only allow audio files
    );

    if (result != null && result.files.single.path != null) {
      final sound = AlarmSoundModel(
        source: AlarmSoundSource.custom,
        name: p.basenameWithoutExtension(
            result.files.single.name), // Remove extension
        path: result.files.single.path!,
      );
      setAlarmSoundService.excute(sound);
      final lastItem = alarmSounds.length - 1;
      selectedSound.value = lastItem;
      alarmSounds[lastItem] = sound;
    }
  }

  initialAlarmSound() {
    final sound = Settings.alarmSound;
    if (sound.isCustomSound) alarmSounds[alarmSounds.length - 1] = sound;
    final index = alarmSounds.indexWhere((item) => item.name == sound.name);
    selectedSound = RxInt(index);
  }

  @override
  void onInit() {
    super.onInit();
    alarmSounds = [...List.from(alarmSoundsData), noCustomSound];
    initialAlarmSound();
    setAlarmSoundService = SetAlarmSoundService();
    audioInstance.onPlayerComplete.listen((event) {
      musicPlaying.value = false;
    });
  }

  @override
  void onClose() {
    stopExistingAudio();
    super.onClose();
  }
}
