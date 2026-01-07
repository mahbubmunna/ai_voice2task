import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../voice_provider.dart';


class RecordButton extends ConsumerWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = ref.watch(voiceStateProvider);
    final notifier = ref.read(voiceStateProvider.notifier);

    return FloatingActionButton(
      onPressed: () {
        if (isRecording) {
          notifier.stopRecording();
        } else {
          notifier.startRecording();
        }
      },
      backgroundColor: isRecording ? Colors.red : Theme.of(context).primaryColor,
      child: Icon(isRecording ? Icons.stop : Icons.mic),
    );
  }
}
