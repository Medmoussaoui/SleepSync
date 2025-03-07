import 'package:sleepcyclesapp/Data/static/vebrations.data.dart';
import 'package:sleepcyclesapp/entitys/text_paragraph.dart';
import 'package:sleepcyclesapp/entitys/vebration_type_entity.dart';
import 'privacy_policy.data.dart';

class StaticData {
  static List<VebrationTypeEntity> vebrationTypes = defaultVebrations;
  static PaperTextContent privacyPolicyInformation = privacyPolicy;
}
