import 'dart:io';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> createTask(Task task);
  Future<void> syncTasks();
  Future<List<Task>> processTranscript(String transcript);
  Future<List<Task>> processAudioFile(File file);
  Future<void> updateTask(Task task);
}
