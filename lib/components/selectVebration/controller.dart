import 'package:get/get.dart';
import 'package:sleepcyclesapp/entitys/vebration_type_entity.dart';
import 'package:sleepcyclesapp/services/change_veration_service.dart';
import 'package:sleepcyclesapp/utils/settings.dart';
import 'package:vibration/vibration.dart';

typedef VebrationPattern = List<int>;

Map<VebrationSensitivity, VebrationPattern> vebrationPatterns = {
  VebrationSensitivity.low: [0, 60, 60, 60, 60, 60],
  VebrationSensitivity.medium: [0, 105, 105, 105, 105, 105],
  VebrationSensitivity.high: [0, 150, 150, 150, 150, 150],
};

class SelectVebrationController extends GetxController {
  late VebrationTypeEntity _oldSelectedVebration;
  late VebrationTypeEntity selectedVebration;

  void selectVebration(VebrationTypeEntity vebrationType) {
    selectedVebration = vebrationType;
    Vibration.vibrate(pattern: vebrationPatterns[vebrationType.sensitivity]!);
    update();
  }

  applyChange(Function(VebrationTypeEntity vebrationType) onChange) {
    if (_oldSelectedVebration.name != selectedVebration.name) {
      ChangeVerationService().change(selectedVebration);
      onChange(selectedVebration);
    }
    Get.back();
  }

  @override
  void onInit() {
    selectedVebration = Settings.vebrationType;
    _oldSelectedVebration = selectedVebration;
    super.onInit();
  }
}
