import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../../../../core/network/api_client.dart';

part 'task_repository_impl.g.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Dio _dio;

  TaskRepositoryImpl(this._dio);

  @override
  Future<List<Task>> getTasks() async {
    final response = await _dio.get('/tasks');
    final List<dynamic> data = response.data;
    return data.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<Task> createTask(Task task) async {
    final response = await _dio.post('/tasks', data: task.toJson());
    return Task.fromJson(response.data);
  }

  @override
  Future<void> syncTasks() async {
    // TODO: Implement sync logic
  }
}

@Riverpod(keepAlive: true)
TaskRepository taskRepository(TaskRepositoryRef ref) {
  return TaskRepositoryImpl(ref.watch(dioProvider));
}
