import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/domain/entities/task_source.dart';
import '../../../tasks/data/repositories/task_repository_impl.dart';
import '../../../tasks/presentation/providers/task_providers.dart';

class DetailedTaskCard extends ConsumerWidget {
  final Task task;
  final VoidCallback? onTap;

  const DetailedTaskCard({super.key, required this.task, this.onTap});

  Future<void> _toggleComplete(WidgetRef ref) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await ref.read(taskRepositoryProvider).updateTask(updatedTask);
    ref.invalidate(taskListProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Checkbox (Left)
                GestureDetector(
                  onTap: () => _toggleComplete(ref),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted
                          ? const Color(0xFF10B981)
                          : Colors.white10,
                      border: Border.all(
                        color: task.isCompleted
                            ? const Color(0xFF10B981)
                            : Colors.white30,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ),

                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: Colors.white54,
                        ),
                      ),
                      if (task.dueAt != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "${task.dueAt!.hour > 12 ? task.dueAt!.hour - 12 : task.dueAt!.hour}:${task.dueAt!.minute.toString().padLeft(2, '0')} ${task.dueAt!.hour >= 12 ? 'PM' : 'AM'}",
                            style: GoogleFonts.inter(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Source Icon (Right)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    task.source == TaskSource.voice
                        ? Icons.graphic_eq
                        : Icons.keyboard,
                    color: const Color(0xFF3B82F6),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }
}
