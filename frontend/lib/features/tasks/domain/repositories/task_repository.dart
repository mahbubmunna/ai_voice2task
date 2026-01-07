import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> createTask(Task task);
  Future<void> syncTasks();
  Future<List<Task>> processTranscript(String transcript);
}
