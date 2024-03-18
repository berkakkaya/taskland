import 'package:hive_flutter/adapters.dart';

part 'task_importance.g.dart';

@HiveType(typeId: 2)
enum TaskImportance {
  @HiveField(0)
  p1,

  @HiveField(1)
  p2,

  @HiveField(2)
  p3,

  @HiveField(3)
  p4,
}
