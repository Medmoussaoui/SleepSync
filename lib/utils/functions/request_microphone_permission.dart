import 'package:permission_handler/permission_handler.dart';

Future<bool> requestMicrophonePermission() async {
  if (await Permission.microphone.isGranted) {
    return true;
  }
  return Permission.microphone.request().isGranted;
}
