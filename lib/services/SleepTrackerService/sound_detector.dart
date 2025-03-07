import 'dart:async';

import 'package:flutter_tflite_audio_modified/tflite_audio.dart';
import 'package:get/get.dart';

class DetectUserSoundResponce {
  DetectUserSoundResponce() {
    _loadModel();
  }

  StreamSubscription? subscription;

  _loadModel() {
    TfliteAudio.loadModel(
      model: 'assets/tflite/model.tflite',
      label: 'assets/tflite/labels.txt',
      inputType: 'rawAudio',
    );
  }

  Stream<Map<dynamic, dynamic>> startRecord() {
    return TfliteAudio.startAudioRecognition(
      sampleRate: 44100,
      bufferSize: 22016,
      numOfInferences: 20,
    );
  }

  Future<bool> detectSound() async {
    Completer<bool> soundDetected = Completer();
    final recognitionStream = startRecord();
    // Result {hasPermission: true, inferenceTime: 8, recognitionResult: 0 noise}
    subscription = recognitionStream.listen((result) {
      print("------------> result: ${result["recognitionResult"]}");
      if (result["recognitionResult"] == "1 userResponce") {
        soundDetected.complete(true);
        TfliteAudio.stopAudioRecognition();
        subscription?.cancel();
      }
    });

    return soundDetected.future.timeout(8.seconds, onTimeout: () {
      subscription?.cancel();
      return false;
    });
  }
}
