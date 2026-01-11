import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'providers/task_providers.dart';
import '../../home/presentation/widgets/detailed_task_card.dart';
import 'listening_screen.dart';
import '../../home/presentation/voice_provider.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  int _selectedTab = 0; // 0: Today, 1: Upcoming

  void _startListening(BuildContext context, WidgetRef ref) {
    final voiceNotifier = ref.read(voiceStateProvider.notifier);
    voiceNotifier.startRecording();
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ListeningScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning, Alex", // Dynamic later
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Wednesday, Oct 24", // Dynamic later
              style: GoogleFonts.inter(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [_buildTab("Today", 0), _buildTab("Upcoming", 1)],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Use Expanded to fill remaining space with list
            Expanded(
              child: tasksAsync.when(
                data: (tasks) {
                  // Filter
                  final filteredTasks = tasks.where((t) {
                    if (_selectedTab == 0) {
                      // Today: No date, or today, or overdue
                      if (t.dueAt == null) return true;
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final taskDate = DateTime(
                        t.dueAt!.year,
                        t.dueAt!.month,
                        t.dueAt!.day,
                      );
                      return !taskDate.isAfter(today);
                    } else {
                      // Upcoming: Tomorrow onwards
                      if (t.dueAt == null) return false;
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final taskDate = DateTime(
                        t.dueAt!.year,
                        t.dueAt!.month,
                        t.dueAt!.day,
                      );
                      return taskDate.isAfter(today);
                    }
                  }).toList();

                  if (filteredTasks.isEmpty) {
                    return Center(
                      child: Text(
                        "No tasks",
                        style: GoogleFonts.inter(color: Colors.white30),
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          24,
                          0,
                          24,
                          100,
                        ), // Bottom padding for FAB
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: DetailedTaskCard(task: filteredTasks[index]),
                        ),
                      ),

                      // Floating Mic Button (Bottom Center)
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () => _startListening(context, ref),
                            child:
                                Container(
                                      width: 64,
                                      height: 64,
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
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.mic,
                                        color: Colors.white,
                                        size: 28,
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
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
