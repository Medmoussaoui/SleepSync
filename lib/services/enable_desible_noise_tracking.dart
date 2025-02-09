import 'package:sleepcyclesapp/utils/hive_database.dart';
import 'package:sleepcyclesapp/utils/settings.dart';

class EnableDesibleNoiseTrackingService {
  Future excute(bool active) async {
    HiveDatabase.db.put("noiseTracking", active);
  }
}
