import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String title,
    String? description,
    @JsonKey(name: 'due_datetime') DateTime? dueAt,
    @JsonKey(name: 'reminder_datetime') DateTime? reminderAt,
    @Default(0.0) double confidence,
    @Default(false) bool isCompleted,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
