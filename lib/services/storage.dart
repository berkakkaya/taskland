import 'package:hive_flutter/adapters.dart';
import 'package:taskland/types/task.dart';
import 'package:taskland/types/task_importance.dart';

class StorageService {
  static Box? _settingsBox;
  static Box<Task>? _tasksBox;

  static bool _initialized = false;

  static bool get isInitialized => _initialized;
  static Box get settingsBox => _settingsBox!;
  static Box<Task> get tasksBox => _tasksBox!;

  static Future<void> initialize() async {
    if (_initialized) return;

    await Hive.initFlutter();

    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(TaskImportanceAdapter());

    _settingsBox = await Hive.openBox("settings");
    _tasksBox = await Hive.openBox<Task>("tasks");

    _initialized = true;
  }
}
