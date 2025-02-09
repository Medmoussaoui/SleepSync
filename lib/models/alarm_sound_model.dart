enum AlarmSoundSource {
  custom,
  app,
  none,
}

class AlarmSoundModel {
  final AlarmSoundSource source;
  final String name;
  final String path;

  AlarmSoundModel({
    required this.source,
    required this.path,
    required this.name,
  });

  bool get isCustomSound => source == AlarmSoundSource.custom;

  // Convert an object to JSON
  Map<String, dynamic> toJson() {
    return {
      'source': source.name, // Convert enum to string
      'path': path,
      'name': name,
    };
  }

  // Create an object from JSON
  factory AlarmSoundModel.fromJson(dynamic json) {
    return AlarmSoundModel(
      source: AlarmSoundSource.values.firstWhere(
          (e) => e.name == json['source'],
          orElse: () => AlarmSoundSource.app), // Default to 'app' if unknown
      path: json['path'] as String,
      name: json['name'],
    );
  }
}
