import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/task.dart';
import '../../data/repositories/task_repository_impl.dart';

part 'task_providers.g.dart';

@riverpod
Future<List<Task>> taskList(Ref ref) async {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.getTasks();
}
