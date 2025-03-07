// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_sound/flutter_sound.dart';

// class RealtimeSoundClassifier {
//   late Interpreter _interpreter;
//   bool _isModelLoaded = false;
//   bool _isListening = false;
//   List<String> _labels = [];
  
//   // Audio processing
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   StreamSubscription? _audioStreamSubscription;
  
//   // Buffer for audio processing
//   final List<double> _audioBuffer = [];
//   final int _bufferSize = 16000; // 1 second at 16kHz
  
//   // Classification settings
//   int _samplingRate = 16000; // Default, adjust based on model
//   double _confidenceThreshold = 0.6;
  
//   // Callback for classification results
//   Function(String label, double confidence)? onResult;
  
//   // Constructor
//   RealtimeSoundClassifier({
//     this.onResult,
//     int? samplingRate,
//     double? confidenceThreshold,
//   }) {
//     if (samplingRate != null) _samplingRate = samplingRate;
//     if (confidenceThreshold != null) _confidenceThreshold = confidenceThreshold;
//   }
  
//   // Initialize the classifier
//   Future<void> initialize() async {
//     await _requestPermissions();
//     await _loadModel();
//     await _loadLabels();
//     await _initializeAudio();
//   }
  
//   // Dispose resources
//   void dispose() {
//     stopListening();
//     if (_isModelLoaded) {
//       _interpreter.close();
//     }
//     _recorder.closeRecorder();
//   }

//   // Check if model is loaded
//   bool get isModelLoaded => _isModelLoaded;
  
//   // Check if currently listening
//   bool get isListening => _isListening;

//   Future<void> _requestPermissions() async {
//     await Permission.microphone.request();
//     await Permission.storage.request();
//   }

//   Future<void> _loadModel() async {
//     try {
//       final modelFile = await _loadModelFromAssets('assets/sound_model.tflite');
//       final interpreterOptions = InterpreterOptions();
      
//       // Set number of threads for faster inference
//       interpreterOptions.threads = 4;
      
//       _interpreter = await Interpreter.fromFile(modelFile, options: interpreterOptions);
//       _isModelLoaded = true;
//       print('Sound classification model loaded successfully');
//       print('Model input shape: ${_interpreter.getInputTensor(0).shape}');
//       print('Model output shape: ${_interpreter.getOutputTensor(0).shape}');
//     } catch (e) {
//       print('Error loading sound classification model: $e');
//       rethrow;
//     }
//   }

//   Future<void> _loadLabels() async {
//     try {
//       final labelsData = await rootBundle.loadString('assets/labels.txt');
//       _labels = labelsData.split('\n')
//           .where((label) => label.trim().isNotEmpty)
//           .toList();
//       print('Labels loaded: $_labels');
//     } catch (e) {
//       print('Error loading labels: $e');
//       rethrow;
//     }
//   }

//   Future<File> _loadModelFromAssets(String assetPath) async {
//     final byteData = await rootBundle.load(assetPath);
//     final tempDir = await getTemporaryDirectory();
//     final tempPath = '${tempDir.path}/sound_model.tflite';
//     final tempFile = File(tempPath);
//     await tempFile.writeAsBytes(byteData.buffer.asUint8List(
//       byteData.offsetInBytes, 
//       byteData.lengthInBytes
//     ));
//     return tempFile;
//   }
  
//   Future<void> _initializeAudio() async {
//     await _recorder.openRecorder();
//     await _recorder.setSubscriptionDuration(const Duration(milliseconds: 10));
//   }

//   Future<void> startListening() async {
//     if (!_isModelLoaded) {
//       throw Exception('Model not loaded yet. Call initialize() first.');
//     }
    
//     if (_isListening) return;
    
//     try {
//       _audioBuffer.clear();
      
//       await _recorder.startRecorder(
//         toStream: true,
//         codec: Codec.pcm16,
//         numChannels: 1,
//         sampleRate: _samplingRate,
//       );
      
//       _isListening = true;
      
//       _audioStreamSubscription = _recorder.onProgress?.listen((event) {
//         if (event.decibels != null) {
//           _processAudioData(event);
//         }
//       });
      
//       print('Started real-time audio classification');
//     } catch (e) {
//       print('Error starting audio classification: $e');
//       _isListening = false;
//       rethrow;
//     }
//   }

//   Future<void> stopListening() async {
//     if (!_isListening) return;
    
//     try {
//       await _audioStreamSubscription?.cancel();
//       await _recorder.stopRecorder();
//       _isListening = false;
//       print('Stopped real-time audio classification');
//     } catch (e) {
//       print('Error stopping audio classification: $e');
//     }
//   }
  
//   void _processAudioData(RecordingDisposition event) {
//     final Uint8List? data = event.buffer;
//     if (data == null) return;
    
//     // Convert raw PCM data to floating point values
//     final pcmData = _convertPCMToFloat(data);
    
//     // Add to buffer
//     _audioBuffer.addAll(pcmData);
    
//     // Keep buffer at fixed size
//     if (_audioBuffer.length > _bufferSize) {
//       _audioBuffer.removeRange(0, _audioBuffer.length - _bufferSize);
//     }
    
//     // If we have enough data, run classification
//     if (_audioBuffer.length == _bufferSize) {
//       _classifyAudio();
//     }
//   }
  
//   List<double> _convertPCMToFloat(Uint8List pcmData) {
//     final result = <double>[];
    
//     // Convert 16-bit PCM to float
//     for (int i = 0; i < pcmData.length; i += 2) {
//       if (i + 1 < pcmData.length) {
//         final int16Value = pcmData[i] + (pcmData[i + 1] << 8);
//         // Convert to range [-1.0, 1.0]
//         final double floatValue = int16Value / 32768.0;
//         result.add(floatValue);
//       }
//     }
    
//     return result;
//   }
  
//   Future<void> _classifyAudio() async {
//     try {
//       // Extract audio features based on your model's requirements
//       final audioFeatures = _extractAudioFeatures(_audioBuffer);
      
//       // Prepare output buffer - adjust size based on your model's output
//       final outputShape = _interpreter.getOutputTensor(0).shape;
//       final outputSize = outputShape[outputShape.length - 1];
//       List<List<double>> outputBuffer = List.generate(
//         1, 
//         (_) => List<double>.filled(outputSize, 0)
//       );
      
//       // Run inference
//       _interpreter.run(audioFeatures, outputBuffer);
      
//       // Find the class with highest probability
//       int maxIndex = 0;
//       double maxProb = outputBuffer[0][0];
      
//       for (int i = 1; i < outputBuffer[0].length; i++) {
//         if (outputBuffer[0][i] > maxProb) {
//           maxProb = outputBuffer[0][i];
//           maxIndex = i;
//         }
//       }
      
//       // Call the result callback if confidence is above threshold
//       if (maxProb > _confidenceThreshold && 
//           maxIndex < _labels.length && 
//           onResult != null) {
//         onResult!(_labels[maxIndex], maxProb);
//       }
      
//     } catch (e) {
//       print('Error classifying audio: $e');
//     }
//   }

//   // Audio feature extraction - needs customization based on your model
//   List<List<dynamic>> _extractAudioFeatures(List<double> audioData) {
//     // IMPORTANT: This is a placeholder. You need to implement proper audio feature extraction
//     // based on your Teachable Machine model's requirements.
    
//     // Get input shape from the model
//     final inputShape = _interpreter.getInputTensor(0).shape;
//     final inputSize = inputShape[inputShape.length - 1];
    
//     // For Teachable Machine sound models, you typically need to:
//     // 1. Apply windowing (e.g., Hamming window)
//     // 2. Calculate FFT
//     // 3. Convert to Mel spectrogram or MFCC features
    
//     // This is a simplified example that performs basic preprocessing:
//     // - Take the most recent audio data
//     // - Apply preprocessing (normalization)
//     // - Format as expected by the model
    
//     // Take the most recent data if buffer is larger than needed
//     final data = audioData.length > inputSize 
//         ? audioData.sublist(audioData.length - inputSize)
//         : audioData;
        
//     // Normalize the audio (simple example)
//     final normalizedData = _normalizeAudio(data);
    
//     // Pad if necessary to match input size
//     final paddedData = _padToLength(normalizedData, inputSize);
    
//     // Return as nested list as expected by TFLite interpreter
//     return [paddedData];
//   }
  
//   List<double> _normalizeAudio(List<double> audioData) {
//     if (audioData.isEmpty) return [];
    
//     double maxAbs = 0;
//     for (final value in audioData) {
//       final absValue = value.abs();
//       if (absValue > maxAbs) {
//         maxAbs = absValue;
//       }
//     }
    
//     if (maxAbs == 0) return List.filled(audioData.length, 0);
    
//     return audioData.map((x) => x / maxAbs).toList();
//   }
  
//   List<double> _padToLength(List<double> data, int length) {
//     if (data.length >= length) {
//       return data.sublist(0, length);
//     }
    
//     final result = List<double>.from(data);
//     result.addAll(List<double>.filled(length - data.length, 0));
//     return result;
//   }
// }