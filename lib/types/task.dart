import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskland/types/task_importance.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String? name;

  @HiveField(1)
  DateTime? date;

  @HiveField(2)
  DateTime? notification;

  @HiveField(3)
  TaskImportance? importance;
}
