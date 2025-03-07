import 'package:sleepcyclesapp/entitys/vebration_type_entity.dart';

List<VebrationTypeEntity> defaultVebrations = [
  VebrationTypeEntity(
    name: 'Soft',
    description: 'Low Intensity → Amplitude 50',
    sensitivity: VebrationSensitivity.low,
  ),
  VebrationTypeEntity(
    name: 'Medium',
    description: 'Balanced → Amplitude 150',
    sensitivity: VebrationSensitivity.medium,
  ),
  VebrationTypeEntity(
    name: 'High Intensity',
    description: 'High Intensity → Amplitude 255',
    sensitivity: VebrationSensitivity.high,
  ),
];
