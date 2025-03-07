import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/SelectAlarmSound/dialog.dart';
import 'package:sleepcyclesapp/components/adjustCycleDuration/dialog.dart';
import 'package:sleepcyclesapp/components/selectVebration/dialog.dart';
import 'package:sleepcyclesapp/services/enable_desible_noise_tracking.dart';
import 'package:sleepcyclesapp/utils/functions/custom_show_dialog.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreenController extends GetxController {
  enableNoiseTracking() {
    EnableDesibleNoiseTrackingService().excute(!Settings.noiseTracking);
    update(["noiseTracking"]);
  }

  showAdjustCycleMinutesDialog() {
    customShowDialog(
      AdjustCycleMinutesDialog(
        onSave: (duration) {
          update(["setCycles"]);
        },
      ),
    );
  }

  showVebrationsDialog() {
    customShowDialog(
      SelectVebrationDialog(
        onChange: (vebration) {
          print("---> vebration: ${vebration.name}");
          update(["vibration"]);
        },
      ),
    );
  }

  showAlarmSoundDialog() {
    customShowDialog(
      SelectAlarmSound(
        onSave: (sound) {
          update(["alarmSound"]);
        },
      ),
    );
  }

  Future<void> sendEmailToSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@sleepcycles.com',
      queryParameters: {
        'subject': 'Support Request',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }
}
