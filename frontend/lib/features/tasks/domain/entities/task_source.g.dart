// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_source.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskSourceAdapter extends TypeAdapter<TaskSource> {
  @override
  final typeId = 1;

  @override
  TaskSource read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskSource.voice;
      case 1:
        return TaskSource.text;
      default:
        return TaskSource.voice;
    }
  }

  @override
  void write(BinaryWriter writer, TaskSource obj) {
    switch (obj) {
      case TaskSource.voice:
        writer.writeByte(0);
      case TaskSource.text:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
