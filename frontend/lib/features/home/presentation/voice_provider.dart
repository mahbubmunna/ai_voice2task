import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../tasks/data/repositories/task_repository_impl.dart';
import '../../tasks/presentation/providers/task_providers.dart';

part 'voice_provider.g.dart';

@riverpod
class VoiceState extends _$VoiceState {
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _currentPath;

  @override
  bool build() {
    ref.onDispose(() {
      _audioRecorder.dispose();
    });
    return false; // isRecording
  }

  Future<void> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final dir = await getTemporaryDirectory();
        _currentPath =
            '${dir.path}/temp_recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(const RecordConfig(), path: _currentPath!);
        state = true;
      } else {
        // Handle permission denied
        await Permission.microphone.request();
      }
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      if (!state) return;

      final path = await _audioRecorder.stop();
      state = false;

      if (path != null) {
        final File audioFile = File(path);
        await _processAudioFile(audioFile);
      }
    } catch (e) {
      print("Error stopping recording: $e");
      state = false;
    }
  }

  Future<void> _processAudioFile(File file) async {
    try {
      final repo = ref.read(taskRepositoryProvider);

      // Upload audio, get agent response, save tasks
      // processAudioFile in repo returns List<Task> and saves them?
      // Wait, repo.processAudioFile usually just returns what Agent says.
      // We should verify if repo saves them.
      // In processTranscript it returned tasks.
      // In TaskRepositoryImpl.processAudioFile we have:
      // return response.tasks;
      // It DOES NOT save them to Hive automatically unless createTasks is called.
      // So we must save them.

      final newTasks = await repo.processAudioFile(file);

      for (var task in newTasks) {
        await repo.createTask(task);
      }

      if (newTasks.isNotEmpty) {
        ref.invalidate(taskListProvider);
      }
    } catch (e) {
      print("Error processing audio: $e");
    }
  }
}
