import 'package:sleepcyclesapp/entitys/vebration_type_entity.dart';
import 'package:sleepcyclesapp/utils/hive_database.dart';

class ChangeVerationService {
  Future change(VebrationTypeEntity vebration) async {
    await HiveDatabase.db.put("vebrationType", vebration.toJson());
  }
}
