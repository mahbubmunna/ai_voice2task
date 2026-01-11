import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/presentation/voice_provider.dart';
import 'confirmation_screen.dart';
import 'widgets/audio_visualizer.dart';

class ListeningScreen extends ConsumerStatefulWidget {
  const ListeningScreen({super.key});

  @override
  ConsumerState<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends ConsumerState<ListeningScreen> {
  bool _isProcessing = false;
  Timer? _timer;
  List<double> _amplitudes = List.generate(10, (index) => 0.1); // 10 bars
  int _silenceDurationMs = 0;
  // Thresholds
  static const double _silenceThresholdDb = -50.0;
  static const int _silenceLimitMs = 800;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      if (_isProcessing) return;

      final voiceNotifier = ref.read(voiceStateProvider.notifier);
      final amp = await voiceNotifier.getAmplitude();

      // Update logic
      double currentLevel = amp.current;

      // Normalize for visualizer (approx range -60 to 0)
      double normalized = ((currentLevel + 60) / 60).clamp(0.1, 1.0);

      // Symmetrical update: push to middle? Or just shift.
      // Let's simplified shift for MVP, but to make it look "Symmetrical" like the image,
      // we can generate the visualizer list in the widget by mirroring this raw data.

      if (mounted) {
        setState(() {
          _amplitudes.removeAt(0);
          _amplitudes.add(normalized);
        });
      }

      // VAD Logic
      if (currentLevel < _silenceThresholdDb) {
        _silenceDurationMs += 100;
      } else {
        _silenceDurationMs = 0;
      }

      if (_silenceDurationMs >= _silenceLimitMs) {
        // Auto-stop
        _stopAndProcess();
      }
    });
  }

  Future<void> _stopAndProcess() async {
    if (_isProcessing) return;
    _timer?.cancel(); // Stop monitoring
    setState(() => _isProcessing = true);

    try {
      final tasks = await ref.read(voiceStateProvider.notifier).stopRecording();

      if (mounted) {
        if (tasks.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => ConfirmationScreen(tasks: tasks)),
          );
        } else {
          // If silent for too long and no tasks, just pop? Or show error?
          // Maybe just close if it was pure silence and empty result.
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create symmetrical mirrored list for visualizer
    // Input _amplitudes is 10 items. mirrored will be 19 items (0..9..0) or just 9..0..9
    // Let's do a simple mirror: reverse + original
    final mirroredAmplitudes = [
      ..._amplitudes.reversed.take(5), // Left side
      ..._amplitudes.take(5), // Right side
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Processing Indicator (Above Mic)
              if (_isProcessing) ...[
                Text(
                  "Processing...",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate().fadeIn(),
                const SizedBox(height: 8),
                Text(
                  "Analysing your request...",
                  style: GoogleFonts.inter(color: Colors.white54, fontSize: 16),
                ).animate().fadeIn(),
                const SizedBox(height: 40),
              ] else ...[
                // Listening Text (Above Visualizer/Mic)
                Text(
                  "Listening...",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Speak naturally...",
                  style: GoogleFonts.inter(color: Colors.white54, fontSize: 16),
                ),
                const SizedBox(height: 40),
              ],

              // Visualizer or Mic
              SizedBox(
                height: 120, // Dedicated height
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Visualizer
                    if (!_isProcessing)
                      AudioVisualizer(
                        amplitudes: mirroredAmplitudes,
                        isProcessing: _isProcessing,
                      ),

                    // Loader if processing (Center of where visuals were)
                    if (_isProcessing)
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF3B82F6),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3B82F6).withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const CircularProgressIndicator(
                          color: Color(0xFF3B82F6),
                          strokeWidth: 3,
                        ),
                      ).animate().scale(duration: 300.ms),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Manual Stop Button (Mic) - Only visible when not processing
              if (!_isProcessing)
                GestureDetector(
                  onTap: _stopAndProcess, // Manual stop
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(
                        0xFF1E293B,
                      ), // Darker background to separate from visualizer
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.stop, color: Colors.white, size: 28),
                    ),
                  ).animate().fadeIn(),
                ),

              const Spacer(),

              // Cancel Button
              IconButton(
                onPressed: () {
                  _timer?.cancel();
                  ref
                      .read(voiceStateProvider.notifier)
                      .stopRecording(shouldProcess: false);
                  Navigator.of(context).pop();
                },
                icon: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
