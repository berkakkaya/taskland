import 'package:hive_flutter/adapters.dart';
import 'package:taskland/types/task.dart';

class StorageService {
  static Box? _settingsBox;
  static LazyBox<Task>? _tasksBox;

  static bool _initialized = false;

  static bool get isInitialized => _initialized;
  static Box get settingsBox => _settingsBox!;
  static LazyBox<Task> get tasksBox => _tasksBox!;

  static Future<void> initialize() async {
    if (_initialized) return;

    Hive.initFlutter();

    Hive.registerAdapter(TaskAdapter());

    _settingsBox = await Hive.openBox("settings");
    _tasksBox = await Hive.openLazyBox<Task>("tasks");

    _initialized = true;
  }
}
