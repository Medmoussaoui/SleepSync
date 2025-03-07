// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:collection';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:mic_stream/mic_stream.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// typedef AudioChunk = List<int>;

// class SoundRecognizer {
//   // Callback for classification results
//   Function(String label, double confidence)? onResult;

//   SoundRecognizer({this.onResult});

//   int sampleRate = 44100;
//   int bitDepth = 16;
//   int channels = 1;

//   late Interpreter _interpreter;

//   int get bytesPerSecond => (sampleRate * bitDepth * channels) ~/ 8;

//   // Queue for incoming data
//   final Queue<List<int>> _incomingDataQueue = ListQueue();
//   AudioChunk _singleChunk = [];

//   StreamSubscription<List<int>>? _micSubscription;

//   late StreamController<Uint8List> _audioChunkStreamController;

//   bool isInit = false;
//   bool isListening = false;
//   AudioPlayer audioPlayer = AudioPlayer();

//   Future<void> initialize() async {}
//   startListening() async {
//     if (isListening) return;
//     if (!isInit) await initialize(); // load model ML
//     isListening = true;
//     _audioChunkStreamController = StreamController.broadcast();
//     _micSubscription = _mic().listen((d) => _incomingDataQueue.add(d.toList()));
//     _audioChunkStreamController.stream.listen((oneSecondChunk) async {
//       // classifyAudioData(data);
//       print("----> 1-sec audio chunk received ${oneSecondChunk.length}");
//     });
//     // process incoming audio data
//     Future.delayed(200.ms, _handelRecorderAudioQueue);
//   }

//   _mic() => MicStream.microphone(sampleRate: 44100);

//   _handelRecorderAudioQueue() async {
//     while (isListening) {
//       // Retrieve data from queue
//       if (_incomingDataQueue.isEmpty) {
//         await Future.delayed(100.ms);
//         continue;
//       }
//       List<int> data = _incomingDataQueue.removeFirst();
//       _singleChunk.addAll(data);
//       if (_singleChunk.length >= bytesPerSecond) {
//         // Extract chunk
//         final oneSecondChunk = _singleChunk.sublist(0, bytesPerSecond);
//         _audioChunkStreamController.add(Uint8List.fromList(oneSecondChunk));
//         _singleChunk = _singleChunk.sublist(bytesPerSecond);
//       }
//     }
//   }

//   void classifyAudioData(AudioChunk audioChunk) {
//     // Implement
//   }

//   Future<void> stopListening() async {
//     isListening = false;
//     _incomingDataQueue.clear();
//     await _audioChunkStreamController.close();
//     await _micSubscription?.cancel();
//   }
// }
