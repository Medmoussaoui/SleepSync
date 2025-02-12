import 'package:permission_handler/permission_handler.dart';

Future requestOverlayPermission() async {
  if (await Permission.systemAlertWindow.isGranted) {
    return true;
  }
  final result = await Permission.systemAlertWindow.request();
  return result.isGranted;
}
