// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

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
