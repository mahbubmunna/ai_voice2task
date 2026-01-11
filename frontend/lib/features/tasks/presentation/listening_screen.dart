import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/presentation/voice_provider.dart';
import 'confirmation_screen.dart';

class ListeningScreen extends ConsumerStatefulWidget {
  const ListeningScreen({super.key});

  @override
  ConsumerState<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends ConsumerState<ListeningScreen> {
  @override
  Widget build(BuildContext context) {
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
              Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple 1
                  Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF2563EB).withOpacity(0.1),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .scale(
                        duration: 1500.ms,
                        begin: const Offset(1, 1),
                        end: const Offset(1.5, 1.5),
                      )
                      .fadeOut(duration: 1500.ms),

                  // Ripple 2
                  Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF2563EB).withOpacity(0.2),
                        ),
                      )
                      .animate(
                        delay: 500.ms,
                        onPlay: (controller) => controller.repeat(),
                      )
                      .scale(
                        duration: 1500.ms,
                        begin: const Offset(1, 1),
                        end: const Offset(1.4, 1.4),
                      )
                      .fadeOut(duration: 1500.ms),

                  // Mic Button
                  GestureDetector(
                    onTap: () async {
                      try {
                        final tasks = await ref
                            .read(voiceStateProvider.notifier)
                            .stopRecording();

                        if (context.mounted) {
                          if (tasks.isNotEmpty) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ConfirmationScreen(tasks: tasks),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("No tasks found")),
                            );
                            Navigator.of(context).pop();
                          }
                        }
                      } catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF2563EB),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Listening...",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Speak your task or reminder naturally",
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 16),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // Cancel
                  ref
                      .read(voiceStateProvider.notifier)
                      .stopRecording(
                        shouldProcess: false,
                      ); // Cancel recording without processing
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
