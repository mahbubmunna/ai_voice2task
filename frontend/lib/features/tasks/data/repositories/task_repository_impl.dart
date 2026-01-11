import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_ce/hive.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../../../../core/network/api_client.dart';

part 'task_repository_impl.g.dart';

class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;
  final Box<Task> _box;

  TaskRepositoryImpl(this._apiClient) : _box = Hive.box<Task>('tasks');

  @override
  Future<List<Task>> getTasks() async {
    if (_box.isNotEmpty) {
      return _box.values.toList();
    }

    try {
      final tasks = await _apiClient.getTasks();
      await _box.clear();
      await _box.addAll(tasks);
      return tasks;
    } catch (e) {
      // If API fails (offline), return local
      return _box.values.toList();
    }
  }

  @override
  Future<Task> createTask(Task task) async {
    // Generate simplified ID if missing (MVP)
    final taskWithId = task.id == null
        ? task.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString())
        : task;

    await _box.add(taskWithId);

    try {
      final syncedTask = await _apiClient.createTask(taskWithId.toJson());
      // Here usually we'd update the local ID with server ID if different
      return syncedTask;
    } catch (e) {
      return taskWithId;
    }
  }

  @override
  Future<void> syncTasks() async {
    try {
      final tasks = await _apiClient.getTasks();
      await _box.clear();
      await _box.addAll(tasks);
    } catch (e) {
      print("Sync failed: $e");
    }
  }

  @override
  Future<List<Task>> processTranscript(String transcript) async {
    final response = await _apiClient.processTranscript({
      "transcript": transcript,
      "user_timezone": "UTC",
    });
    return response.tasks;
  }

  @override
  Future<List<Task>> processAudioFile(File file) async {
    final response = await _apiClient.uploadAudio(file, "UTC");
    return response.tasks;
  }

  @override
  Future<void> updateTask(Task task) async {
    final Map<dynamic, Task> taskMap = _box.toMap();
    dynamic keyToUpdate;

    // 1. Try to find by ID if it exists
    if (task.id != null) {
      taskMap.forEach((key, value) {
        if (value.id == task.id) {
          keyToUpdate = key;
        }
      });
    }

    // 2. Fallback: match by title/description if ID is null or not found
    if (keyToUpdate == null) {
      try {
        keyToUpdate = taskMap.keys.firstWhere(
          (k) =>
              taskMap[k]?.title == task.title &&
              taskMap[k]?.description == task.description,
        );
      } catch (e) {
        // Not found
        print("Task update failed: Task not found.");
        return;
      }
    }

    if (keyToUpdate != null) {
      await _box.put(keyToUpdate, task);
    }
    // TODO: Sync to API
  }
}

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(ref.watch(apiClientProvider));
}
