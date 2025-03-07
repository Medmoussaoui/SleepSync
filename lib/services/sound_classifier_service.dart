// // import 'dart:async';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_sound/flutter_sound.dart';
// // import 'package:tflite_flutter/tflite_flutter.dart';

// // class SoundClassifierService {
// //   late Interpreter interpreter;
// //   late List<String> labels;
// //   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
// //   bool isRecording = false;

// //   late StreamController<Uint8List> _audioStreamController;
// //   late StreamController<String> _classificationStreamController;

// //   // Subscription
// //   StreamSubscription<Uint8List>? _audioSubscription;

// //   SoundClassifierService({bool autoInit = true}) {
// //     _audioStreamController = StreamController.broadcast();
// //     _classificationStreamController = StreamController.broadcast();
// //     if (autoInit) initialize();
// //   }

// //   // Call this to listen for classification results in the UI
// //   Stream<String> get classificationResultsStream =>
// //       _classificationStreamController.stream;

// //   Future<void> initialize() async {
// //     // Load the model
// //     interpreter = await Interpreter.fromAsset('assets/tflite/model.tflite');

// //     // Load labels
// //     labels = await rootBundle
// //         .loadString('assets/tflite/labels.txt')
// //         .then((value) => value.split('\n'));

// //     // Initialize the recorder
// //     await _recorder.openRecorder();
// //   }

// //   Future<void> startListening() async {
// //     if (isRecording) return;
// //     isRecording = true;

// //     _recorder.startRecorder(
// //       toStream: _audioStreamController,
// //       codec: Codec.pcm16, // Raw PCM data
// //       sampleRate: 16000, // Ensure it's 16kHz as required by Teachable Machine
// //     );

// //     _audioSubscription?.cancel();
// //     _audioSubscription = _audioStreamController.stream.listen(classifySound);
// //   }

// //   // Stop listening and clean up
// //   Future<void> stopListening() async {
// //     if (!isRecording) return;
// //     isRecording = false;
// //     await _recorder.stopRecorder();
// //     _audioSubscription?.cancel();
// //   }

// //   classifySound(Uint8List soundData) async {
// //     // Ensure the input shape matches the model (adjust if needed)
// //     var input = soundData.buffer.asFloat32List();
// //     var output = List.filled(labels.length, 0).reshape([1, labels.length]);

// //     // Run inference
// //     interpreter.run(input, output);

// //     // Get highest confidence label
// //     int maxIndex = output[0].indexWhere(
// //         (value) => value == output[0].reduce((a, b) => a > b ? a : b));
// //     labels[maxIndex];
// // // Send result to UI
// //     _classificationStreamController.sink.add(labels[maxIndex]);
// //   }

// //   void clear() {
// //     interpreter.close();
// //     _recorder.closeRecorder();
// //     _audioStreamController.close();
// //     _classificationStreamController.close();
// //   }
// // }

// // import 'package:tflite_audio/tflite_audio.dart';

// // class SoundClassifierService {
// //   bool isRecording = false;
// //   Stream<Map<dynamic, dynamic>>? classificationStream;

// //   Future<void> initialize() async {
// //     await TfliteAudio.loadModel(
// //       model: "assets/tflite/model.tflite",
// //       label: "assets/tflite/labels.txt",
// //       inputType: 'rawAudio',
// //       outputRawScores: true, // Keep it true for confidence values
// //       numThreads: 1, // Adjust for performance
// //     );
// //   }

// //   Future<Stream<Map<dynamic, dynamic>>> startListening() async {
// //     if (isRecording) return classificationStream!;
// //     isRecording = true;

// //     classificationStream = TfliteAudio.startAudioRecognition(
// //       sampleRate: 16000,
// //       bufferSize: 2000, // Adjust based on performance
// //       numOfInferences: 1,
// //     );
// //     return classificationStream!;
// //   }

// //   Future<void> stopListening() async {
// //     if (!isRecording) return;
// //     isRecording = false;
// //     await TfliteAudio.stopAudioRecognition();
// //   }

// //   Future<void> dispose() async {
// //     await TfliteAudio.stopAudioRecognition();
// //   }
// // }

// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:mic_stream/mic_stream.dart';
// import 'dart:typed_data';

// class SoundClassifier {
//   late Interpreter _interpreter;
//   final audioStream = MicStream.microphone(sampleRate: 44100);
//   late StreamController<String> _classificationStreamController;
//   late List<String> labels = ["Background Noise", "UserResponce"];

//   Stream<String> get classificationResultsStream =>
//       _classificationStreamController.stream;

//   StreamSubscription<Uint8List>? _audioSubscription;

//   bool isRecording = false;

//   Future<void> initial() async {
//     _classificationStreamController = StreamController.broadcast();
//     await _loadLables();
//     await loadModel();
//   }

//   _loadLables() async {
//     labels = await rootBundle
//         .loadString('assets/tflite/labels.txt')
//         .then((value) => value.split('\n'));
//   }

//   Future<void> loadModel() async {
//     try {
//       _interpreter = await Interpreter.fromAsset('assets/tflite/model.tflite');
//     } catch (e) {
//       throw Exception("---> Failed to load model: $e");
//     }
//   }

//   Float32List _preprocessAudio(Uint8List rawAudio) {
//     final buffer = Float32List(rawAudio.length ~/ 2);
//     final byteData = ByteData.view(rawAudio.buffer);

//     for (int i = 0; i < buffer.length; i++) {
//       buffer[i] = byteData.getInt16(i * 2, Endian.little) /
//           32768.0; // Normalize to [-1, 1]
//     }

//     return buffer;
//   }

//   List<double> _classify(Float32List input) {
//     final inputTensor = input.reshape([1, 44032]);
//     final output = Float32List(2).reshape([1, 2]);
//     _interpreter.run(inputTensor, output);
//     return output[0];
//   }

//   Stream<String> startRecognize() {
//     print("---> Starting recognition");
//     if (isRecording) return classificationResultsStream;
//     isRecording = true;
//     _audioSubscription?.cancel();
//     final audioBuffer = AudioBuffer(requiredSamples: 44032 * 2);

//     _audioSubscription = audioStream.listen((rawAudio) {
//       print("-------------> Sound Recorded");
//       // Add the new chunk to the buffer
//       audioBuffer.addChunk(rawAudio);
//       if (audioBuffer.isFull()) {
//         final audioChunk = audioBuffer.getBuffer();
//         final preprocessed = _preprocessAudio(audioChunk);
//         final predictions = _classify(preprocessed);
//         final classIndex =
//             predictions.indexOf(predictions.reduce((a, b) => a > b ? a : b));
//         _classificationStreamController.sink.add(labels[classIndex]);
//         print("---> Predicted class: $classIndex");
//         // Reset the buffer for the next chunk
//         audioBuffer.reset();
//       }
//       // if (rawAudio.length >= 44032 * 2) {
//       //   final audioChunk = Uint8List.sublistView(rawAudio, 0, 44032 * 2);
//       //   final preprocessed = _preprocessAudio(audioChunk);
//       //   final predictions = _classify(preprocessed);
//       //   final classIndex =
//       //       predictions.indexOf(predictions.reduce((a, b) => a > b ? a : b));
//       //   _classificationStreamController.sink.add(labels[classIndex]);
//       //   print("Predicted class: $classIndex");
//       // }
//       print("-------------> end check");
//     });
//     return classificationResultsStream;
//   }

//   Future<void> stopRecognize(SoundClassifier classifier) async {
//     isRecording = false;
//     await _audioSubscription?.cancel();
//     _audioSubscription = null;
//   }

//   Future<void> clear() async {
//     await _audioSubscription?.cancel();
//     await _classificationStreamController.close();
//   }
// }

// class AudioBuffer {
//   final int requiredSamples;
//   final int bytesPerSample;
//   late ByteData _buffer;
//   int _bufferIndex = 0;

//   AudioBuffer({required this.requiredSamples, this.bytesPerSample = 2}) {
//     _buffer = ByteData(requiredSamples * bytesPerSample);
//   }

//   void addChunk(Uint8List chunk) {
//     final remainingSpace = _buffer.lengthInBytes - _bufferIndex;
//     final bytesToCopy =
//         chunk.length <= remainingSpace ? chunk.length : remainingSpace;

//     for (int i = 0; i < bytesToCopy; i++) {
//       _buffer.setUint8(_bufferIndex + i, chunk[i]);
//     }
//     _bufferIndex += bytesToCopy;
//   }

//   bool isFull() => _bufferIndex >= _buffer.lengthInBytes;

//   Uint8List getBuffer() => Uint8List.view(_buffer.buffer);

//   void reset() => _bufferIndex = 0;
// }

// //////

// class SoundRecognitionClassifier {
//   late Interpreter _interpreter;
//   late List<String> _labels;

//   Stream<Uint8List> mic = MicStream.microphone(
//     sampleRate: 16000, // Match model input
//     audioFormat: AudioFormat.ENCODING_PCM_16BIT,
//   );

//   StreamSubscription<Uint8List>? _audioSubscription;

//   final List<int> _audioBuffer = [];

//   /// Load the model and labels from assets
//   Future<void> loadModel() async {
//     try {
//       // Load the TFLite model
//       _interpreter = await Interpreter.fromAsset('assets/tflite/model.tflite');
//       // Load labels
//       String labelsData =
//           await rootBundle.loadString('assets/tflite/labels.txt');
//       _labels = labelsData.split('\n').map((e) => e.trim()).toList();

//       // Print input and output tensor shapes
//       print("Model Input Shape: ${_interpreter.getInputTensor(0).shape}");
//       print("Model Output Shape: ${_interpreter.getOutputTensor(0).shape}");
//       print("---> Labels: ${_labels.toString()}");
//       print("---> count Labels: ${_labels.length}");
//       print("Model and labels loaded successfully!");
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }

//   /// Classify sound using raw audio data from the microphone
//   String _classify(Uint8List audioData) {
//     // Convert raw audio into a float32 input tensor
//     var input = audioData
//         .map((e) => e.toDouble())
//         .toList()
//         .reshape([1, audioData.length]);

//     // Define output buffer (same length as labels)
//     var output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

//     // Run inference
//     _interpreter.run(input, output);

//     // Get the label with the highest probability
//     int maxIndex = output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

//     return _labels[maxIndex];
//   }

//   void startRecognize() {
//     _audioSubscription = mic.listen((List<int> data) {
//       _audioBuffer.addAll(data);
//       // Process audio every 1 second
//       print("------------------> buffer length : ${_audioBuffer.length}");
//       if (_audioBuffer.length >= 16000 * 2) {
//         Uint8List audioBytes = Uint8List.fromList(_audioBuffer);
//         final lable = _classify(audioBytes);
//         _audioBuffer.clear();
//         print("------------------> Lable : $lable");
//       }
//     });
//   }

//   void close() {
//     _interpreter.close();
//     _audioSubscription?.cancel();
//   }
// }
