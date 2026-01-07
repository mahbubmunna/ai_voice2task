import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../tasks/data/repositories/task_repository_impl.dart';
import '../../tasks/domain/entities/task.dart';
import '../../../../core/network/api_client.dart';
import 'package:dio/dio.dart';
import '../../tasks/presentation/providers/task_providers.dart'; // Import for taskListProvider

part 'voice_provider.g.dart';

@riverpod
class VoiceState extends _$VoiceState {
  @override
  bool build() {
    return false; // isRecording
  }

  void startRecording() {
    state = true;
    print("Started recording (simulation)...");
  }

  Future<void> stopRecording() async {
    state = false;
    print("Stopped recording. Sending simulated transcript...");
    
    // Simulate STT result
    const simulatedTranscript = "Buy milk tomorrow at 5pm";
    
    try {
      final dio = ref.read(dioProvider);
      // Call Backend Agent
      final response = await dio.post('/stt/on-device', data: {
        "transcript": simulatedTranscript,
        "user_timezone": "UTC" // Should be dynamic
      });
      
      final data = response.data;
      print("Agent Response: $data");
      
      // If tasks found, save them
      if (data['tasks'] != null) {
        final tasksList = data['tasks'] as List;
        final repo = ref.read(taskRepositoryProvider);
        
        for (var t in tasksList) {
           // Mapping agent task to entity
           final newTask = Task(
             title: t['title'],
             description: t['description'],
             dueAt: t['due_datetime'] != null ? DateTime.parse(t['due_datetime']) : null,
             confidence: t['confidence'] ?? 1.0,
           );
           await repo.createTask(newTask);
        }
        
        // Refresh task list
        ref.invalidate(taskListProvider);
      }
      
    } catch (e) {
      print("Error processing voice: $e");
    }
  }
}
