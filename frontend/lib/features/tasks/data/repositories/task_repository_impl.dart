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
    // Optimistic Save
    await _box.add(task);

    try {
      final syncedTask = await _apiClient.createTask(task.toJson());
      // Update local with synced data (ID, etc.) if needed
      // For now just return synced
      return syncedTask;
    } catch (e) {
      // If API fails, we still have it locally.
      // ideally mark as 'unsynced' but for MVP we just return local
      return task;
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
}

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(ref.watch(apiClientProvider));
}
