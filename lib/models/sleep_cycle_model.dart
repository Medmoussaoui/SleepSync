import 'package:sleepcyclesapp/utils/settings.dart';

class SleepCycleModel {
  int? id;
  int cycles; // Goal cycles set by user
  DateTime date; // Date when user went to bed
  DateTime? startTime; // Sleep start time (null initially)
  DateTime? endTime; // Sleep end time (null if still sleeping)
  String state; // "active" or "end"

  SleepCycleModel({
    this.id,
    required this.cycles,
    required this.date,
    this.startTime,
    this.endTime,
    this.state = "active",
  });

  /// Calculate wakeup latency (difference between expected and actual wake-up time)
  Duration get wakeupLatency {
    if (state == "active" || startTime == null || endTime == null) {
      return Duration.zero;
    }

    final cyclesDuration = Duration(minutes: (Settings.cycleMinute * cycles));
    final expectedWakeupTime = startTime!.add(cyclesDuration);

    return endTime!.difference(expectedWakeupTime);
  }

  /// Calculate total sleep duration
  Duration get totalSleepDuration {
    if (startTime == null) return Duration.zero;

    DateTime end = endTime ?? DateTime.now(); // If ongoing, use current time
    return end.difference(startTime!);
  }

  /// Calculate sleep latency (time taken to fall asleep)
  Duration get sleepLatency {
    if (startTime == null) return Duration.zero;
    return startTime!.difference(date);
  }

  /// Check if sleep is ongoing
  bool get isOngoing => state == "active";

  /// Get the number of completed sleep cycles
  int get completedCycles {
    return (totalSleepDuration.inMinutes / Settings.cycleMinute).floor();
  }

  double get progress {
    int cyclesToMitunes = (cycles * Settings.cycleMinute).floor();
    return ((1 / cyclesToMitunes) * totalSleepDuration.inMinutes)
        .clamp(0.0, 1.0);
  }

  /// Convert to Map (for database storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cycles': cycles,
      'date': date.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'state': state,
    };
  }

  /// Create instance from Map (for database retrieval)
  factory SleepCycleModel.fromMap(Map<String, dynamic> map) {
    return SleepCycleModel(
      id: map['id'],
      cycles: map['cycles'],
      date: DateTime.parse(map['date']),
      startTime:
          map['startTime'] != null ? DateTime.parse(map['startTime']) : null,
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
      state: map['state'],
    );
  }
}
