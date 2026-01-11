import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../tasks/data/repositories/task_repository_impl.dart';
import '../../tasks/domain/entities/task.dart';

part 'voice_provider.g.dart';

@Riverpod(keepAlive: true)
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
        print("Recording started");
        state = true;
      } else {
        // Handle permission denied
        await Permission.microphone.request();
      }
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<Amplitude> getAmplitude() async {
    try {
      return await _audioRecorder.getAmplitude();
    } catch (e) {
      return Amplitude(current: -160.0, max: -160.0);
    }
  }

  Future<List<Task>> stopRecording({bool shouldProcess = true}) async {
    try {
      if (!state) return [];

      final path = await _audioRecorder.stop();
      state = false;

      if (!shouldProcess) return [];

      if (path != null) {
        final File audioFile = File(path);
        return await _processAudioFile(audioFile);
      }
      return [];
    } catch (e) {
      print("Error stopping recording: $e");
      state = false;
      return [];
    }
  }

  Future<List<Task>> _processAudioFile(File file) async {
    try {
      final repo = ref.read(taskRepositoryProvider);
      // Upload audio, get agent response (List<Task>)
      // We do NOT save them yet.
      return await repo.processAudioFile(file);
    } catch (e) {
      print("Error processing audio: $e");
      rethrow;
    }
  }
}
