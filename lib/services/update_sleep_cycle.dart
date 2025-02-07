import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';

class UpdateSleepCycle {
  Future<bool> update(SleepCycleModel model) async {
    model.toMap();
    return true;
  }
}
