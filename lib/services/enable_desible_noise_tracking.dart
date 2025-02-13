import 'package:sleepcyclesapp/utils/hive_database.dart';

class EnableDesibleNoiseTrackingService {
  Future excute(bool active) async {
    HiveDatabase.db.put("noiseTracking", active);
  }
}
