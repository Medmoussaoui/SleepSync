import 'package:flutter/material.dart';
import 'package:flutter_tflite_audio_modified/tflite_audio.dart';
import 'package:sleepcyclesapp/utils/functions/request_microphone_permission.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  // SoundRecognizer classifier = SoundRecognizer();

  @override
  void initState() {
    requestMicrophonePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Class Lable"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TfliteAudio.loadModel(
                    model: 'assets/tflite/model.tflite',
                    label: 'assets/tflite/labels.txt',
                    inputType: 'rawAudio');
              },
              child: Text(
                'Initial Model',
                style: AppTextStyles.headline1medium,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                print("----> start listening");

                final recognitionStream = TfliteAudio.startAudioRecognition(
                  sampleRate: 44100,
                  bufferSize: 22016,
                  numOfInferences: 40,
                );

                recognitionStream.listen((result) {
                  print("---------------> Result $result");
                });
              },
              child: Text(
                'Start Recognition',
                style: AppTextStyles.headline1medium,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                print("----> stop listening");
                // await classifier.stopListening();
              },
              child: Text(
                'Stop Recognition',
                style: AppTextStyles.headline1medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
