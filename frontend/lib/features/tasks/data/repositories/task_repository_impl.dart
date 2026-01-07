import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../../../../core/network/api_client.dart';

part 'task_repository_impl.g.dart';

class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;

  TaskRepositoryImpl(this._apiClient);

  @override
  Future<List<Task>> getTasks() async {
    return await _apiClient.getTasks();
  }

  @override
  Future<Task> createTask(Task task) async {
    return await _apiClient.createTask(task.toJson());
  }

  @override
  Future<void> syncTasks() async {
    // TODO: Implement sync logic
  }

  @override
  Future<List<Task>> processTranscript(String transcript) async {
    // TODO: Get real timezone
    final response = await _apiClient.processTranscript({
      "transcript": transcript,
      "user_timezone": "UTC",
    });

    return response.tasks;
  }
}

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(ref.watch(apiClientProvider));
}
