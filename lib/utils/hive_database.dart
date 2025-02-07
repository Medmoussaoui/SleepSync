// Hive is a light database as sharedPreferences
//
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

class HiveDatabase {
  static late Box db;

  static bool isInitial = false;

  static Future initial() async {
    Directory dir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    db = await Hive.openBox("myhivedb");
    isInitial = true;
  }
}
