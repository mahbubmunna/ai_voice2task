import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/data/repositories/task_repository_impl.dart';
import '../../../tasks/presentation/providers/task_providers.dart';

class HomeTaskCard extends ConsumerWidget {
  final Task task;
  final VoidCallback? onTap;

  const HomeTaskCard({super.key, required this.task, this.onTap});

  Future<void> _toggleComplete(WidgetRef ref) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await ref.read(taskRepositoryProvider).updateTask(updatedTask);
    ref.invalidate(taskListProvider);
  }

  // Simple helper to get icon/color based on title content for "Wow" factor
  (IconData, Color, Color) _getCategoryStyle(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('grocer') ||
        lower.contains('buy') ||
        lower.contains('shop')) {
      return (
        Icons.shopping_cart,
        const Color(0xFFF97316),
        const Color(0x33F97316),
      ); // Orange
    }
    if (lower.contains('meet') ||
        lower.contains('call') ||
        lower.contains('schedule')) {
      return (
        Icons.calendar_today,
        const Color(0xFF8B5CF6),
        const Color(0x338B5CF6),
      ); // Purple
    }
    if (lower.contains('clean') ||
        lower.contains('fix') ||
        lower.contains('house')) {
      return (
        Icons.home,
        const Color(0xFF10B981),
        const Color(0x3310B981),
      ); // Green
    }
    return (
      Icons.assignment,
      const Color(0xFF3B82F6),
      const Color(0x333B82F6),
    ); // Default Blue
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (icon, color, bg) = _getCategoryStyle(task.title);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20), // Slightly rounder
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Icon (Left)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                  child: Icon(icon, color: color, size: 24),
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
                          child: Row(
                            children: [
                              Icon(Icons.access_time, size: 12, color: color),
                              const SizedBox(width: 4),
                              Text(
                                // Simple formatting
                                "${task.dueAt!.hour > 12 ? task.dueAt!.hour - 12 : task.dueAt!.hour}:${task.dueAt!.minute.toString().padLeft(2, '0')} ${task.dueAt!.hour >= 12 ? 'PM' : 'AM'}",
                                style: GoogleFonts.inter(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Checkbox (Right) - Radio style as per image 1
                GestureDetector(
                  onTap: () => _toggleComplete(ref),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted
                          ? const Color(0xFF10B981)
                          : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted
                            ? const Color(0xFF10B981)
                            : Colors.white24,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
  }
}
