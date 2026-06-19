import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static const String tasksBoxName = 'tasks';
  static const String userBoxName = 'user';
  static const String notesBoxName = 'notes';
  static const String settingsBoxName = 'settings';

  static Future<void> initHive() async {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Open boxes
    await Hive.openBox<dynamic>(tasksBoxName);
    await Hive.openBox<dynamic>(userBoxName);
    await Hive.openBox<dynamic>(notesBoxName);
    await Hive.openBox<dynamic>(settingsBoxName);
  }

  static Future<void> closeHive() async {
    await Hive.close();
  }

  // Helper methods for each box
  static Box<dynamic> getTasksBox() {
    return Hive.box<dynamic>(tasksBoxName);
  }

  static Box<dynamic> getUserBox() {
    return Hive.box<dynamic>(userBoxName);
  }

  static Box<dynamic> getNotesBox() {
    return Hive.box<dynamic>(notesBoxName);
  }

  static Box<dynamic> getSettingsBox() {
    return Hive.box<dynamic>(settingsBoxName);
  }
}