// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      title: fields[0] as String,
      description: fields[1] as String?,
      dueAt: fields[2] as DateTime?,
      reminderAt: fields[3] as DateTime?,
      confidence: fields[4] == null ? 0.0 : (fields[4] as num).toDouble(),
      isCompleted: fields[5] == null ? false : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dueAt)
      ..writeByte(3)
      ..write(obj.reminderAt)
      ..writeByte(4)
      ..write(obj.confidence)
      ..writeByte(5)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  title: json['title'] as String,
  description: json['description'] as String?,
  dueAt: json['due_datetime'] == null
      ? null
      : DateTime.parse(json['due_datetime'] as String),
  reminderAt: json['reminder_datetime'] == null
      ? null
      : DateTime.parse(json['reminder_datetime'] as String),
  confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
  isCompleted: json['isCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'due_datetime': instance.dueAt?.toIso8601String(),
  'reminder_datetime': instance.reminderAt?.toIso8601String(),
  'confidence': instance.confidence,
  'isCompleted': instance.isCompleted,
};
