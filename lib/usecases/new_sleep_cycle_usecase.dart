import 'package:sleepcyclesapp/models/sleep_cycle_model.dart';
import 'package:sleepcyclesapp/services/new_sleep_cycle.dart';

class NewSleepCycleUsecase {
  Future<SleepCycleModel> excute(int cycles) async {
    final model = SleepCycleModel(
      cycles: cycles,
      date: DateTime.now(),
    );
    int id = await NewSleepCycleService().add(model);
    model.id = id;
    return model;
  }
}
