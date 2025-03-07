enum VebrationSensitivity {
  low,
  medium,
  high,
}

class VebrationTypeEntity {
  final String name;
  final String description;
  final VebrationSensitivity sensitivity;

  VebrationTypeEntity({
    required this.sensitivity,
    required this.name,
    required this.description,
  });

  static VebrationSensitivity _vebrationSensitivity(dynamic sensitivity) {
    if(sensitivity == null) return VebrationSensitivity.low;
    return VebrationSensitivity.values.firstWhere((element) => element.name == sensitivity);
  }

  factory VebrationTypeEntity.fromJson(dynamic data) {
    return VebrationTypeEntity(
      sensitivity: _vebrationSensitivity(data["sensitivity"]),
      name: data["name"],
      description: data["description"],
    );
  }

  toJson() => {
        "name": name,
        "description": description,
        "sensitivity": sensitivity.name,
      };
}
