import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../tasks/presentation/providers/task_providers.dart';
import '../../tasks/presentation/listening_screen.dart';
import 'voice_provider.dart';
import 'widgets/task_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _startListening(BuildContext context, WidgetRef ref) async {
    // Check permissions first or start recording immediately
    final voiceNotifier = ref.read(voiceStateProvider.notifier);

    // Start recording logic
    voiceNotifier.startRecording();

    // Show listening screen
    // We wait for the result here? No, ListeningScreen manages the stop UX usually.
    // Let's pass the logic.
    // Actually, simple flow:
    // 1. Start recording.
    // 2. Open Listening Screen.
    // 3. Listening Screen calls stopRecording when user taps done.
    // 4. Listening Screen gets result, closes itself, returns result to here?
    //    OR Listening Screen pushes Confirmation Screen directly.

    // Let's have ListeningScreen handle the stop and navigation to confirmation.
    // But ListeningScreen is just UI. The provider holds state.
    // We need to coordinate.

    // Better approach:
    // await Navigator.push(context, MaterialPageRoute(builder: (_) => ListeningScreen()));
    // But ListeningScreen needs to know when to close (when processing done).

    // Let's make ListeningScreen simpler: It just shows UI. It calls stopRecording.
    // stopRecording returns Future<List<Task>>.
    // So ListeningScreen awaits that future.

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ListeningScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening", // Dynamic later
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Oct 24, Thursday", // Dynamic later
                        style: GoogleFonts.inter(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white70),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushNamed('/settings'); // Or re-add SettingsPage route
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Hero Section
            Center(
              child: Column(
                children: [
                  Text(
                    "What's on your mind?",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Big Mic Button
                  GestureDetector(
                    onTap: () => _startListening(context, ref),
                    child:
                        Container(
                              width: 120,
                              height: 120,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF3B82F6),
                                    Color(0xFF2563EB),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF2563EB),
                                    blurRadius: 40,
                                    spreadRadius: 5,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.mic,
                                color: Colors.white,
                                size: 48,
                              ),
                            )
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .scale(
                              duration: 2.seconds,
                              begin: const Offset(1, 1),
                              end: const Offset(1.05, 1.05),
                            ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Tap to record",
                    style: GoogleFonts.inter(
                      color: Colors.white30,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Recent Tasks Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Tasks",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Task List
            Expanded(
              child: tasksAsync.when(
                data: (tasks) => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TaskCard(task: tasks[index]),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            // Bottom Nav Placeholder
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: const Color(0xFF0F172A),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.home, color: Color(0xFF3B82F6)),
                  Icon(Icons.calendar_month, color: Colors.white24),
                  Icon(Icons.archive, color: Colors.white24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
