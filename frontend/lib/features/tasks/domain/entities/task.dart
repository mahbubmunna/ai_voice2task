import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

import 'task_source.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class Task with _$Task {
  const factory Task({
    @HiveField(0) required String title,
    @HiveField(1) String? description,
    @JsonKey(name: 'due_datetime') @HiveField(2) DateTime? dueAt,
    @JsonKey(name: 'reminder_datetime') @HiveField(3) DateTime? reminderAt,
    @Default(0.0) @HiveField(4) double confidence,
    @Default(false) @HiveField(5) bool isCompleted,
    @HiveField(6) String? id,
    @Default(TaskSource.voice) @HiveField(7) TaskSource source,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
