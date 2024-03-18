// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_importance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskImportanceAdapter extends TypeAdapter<TaskImportance> {
  @override
  final int typeId = 2;

  @override
  TaskImportance read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskImportance.p1;
      case 1:
        return TaskImportance.p2;
      case 2:
        return TaskImportance.p3;
      case 3:
        return TaskImportance.p4;
      default:
        return TaskImportance.p1;
    }
  }

  @override
  void write(BinaryWriter writer, TaskImportance obj) {
    switch (obj) {
      case TaskImportance.p1:
        writer.writeByte(0);
        break;
      case TaskImportance.p2:
        writer.writeByte(1);
        break;
      case TaskImportance.p3:
        writer.writeByte(2);
        break;
      case TaskImportance.p4:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskImportanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
