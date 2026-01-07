import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../tasks/data/repositories/task_repository_impl.dart';
import '../../tasks/presentation/providers/task_providers.dart'; // Import for taskListProvider

part 'voice_provider.g.dart';

@riverpod
class VoiceState extends _$VoiceState {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;

  @override
  bool build() {
    return false; // isRecording
  }

  Future<void> _initSpeech() async {
    if (!_isInitialized) {
      // Permission request is handled by initialize usually, but explicit request is safer
      var status = await Permission.microphone.status;
      if (!status.isGranted) {
        await Permission.microphone.request();
      }

      _isInitialized = await _speechToText.initialize(
        onError: (val) => print('onError: $val'),
        onStatus: (val) => print('onStatus: $val'),
      );
    }
  }

  Future<void> startRecording() async {
    await _initSpeech();
    if (_isInitialized) {
      state = true;
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        localeId: "en_US", // Make configurable later
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
      );
    }
  }

  Future<void> stopRecording() async {
    state = false;
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.finalResult) {
      state = false; // Stop recording state UI
      print("Final Transcript: ${result.recognizedWords}");
      await _processTranscript(result.recognizedWords);
    }
  }

  Future<void> _processTranscript(String transcript) async {
    if (transcript.isEmpty) return;

    try {
      final repo = ref.read(taskRepositoryProvider);

      // Call Repository to process transcript and get tasks
      final newTasks = await repo.processTranscript(transcript);

      // Save tasks
      for (var task in newTasks) {
        await repo.createTask(task);
      }

      if (newTasks.isNotEmpty) {
        ref.invalidate(taskListProvider);
      }
    } catch (e) {
      print("Error processing voice: $e");
    }
  }
}
