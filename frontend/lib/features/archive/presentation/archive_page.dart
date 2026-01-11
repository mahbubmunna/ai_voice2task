import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../tasks/domain/entities/task.dart';
import '../../tasks/presentation/providers/task_providers.dart';
import '../../home/presentation/widgets/detailed_task_card.dart';

class ArchivePage extends ConsumerStatefulWidget {
  const ArchivePage({super.key});

  @override
  ConsumerState<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends ConsumerState<ArchivePage> {
  String _selectedFilter = 'All Time';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = ['All Time', 'This Week', 'Last Month'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Helper to filter tasks based on time
  List<Task> _applyTimeFilter(List<Task> tasks) {
    if (_selectedFilter == 'All Time') return tasks;

    final now = DateTime.now();
    if (_selectedFilter == 'This Week') {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 7));
      return tasks.where((t) {
        if (t.dueAt == null) return false;
        return t.dueAt!.isAfter(
              startOfWeek.subtract(const Duration(seconds: 1)),
            ) &&
            t.dueAt!.isBefore(endOfWeek);
      }).toList();
    }

    if (_selectedFilter == 'Last Month') {
      final lastMonth = DateTime(now.year, now.month - 1, 1);
      final thisMonth = DateTime(now.year, now.month, 1);
      return tasks.where((t) {
        if (t.dueAt == null) return false;
        return t.dueAt!.isAfter(
              lastMonth.subtract(const Duration(seconds: 1)),
            ) &&
            t.dueAt!.isBefore(thisMonth);
      }).toList();
    }

    return tasks;
  }

  // Helper to filter tasks by search
  List<Task> _applySearch(List<Task> tasks) {
    if (_searchQuery.isEmpty) return tasks;
    return tasks.where((t) {
      return t.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (t.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);
    }).toList();
  }

  // Helper to group tasks
  Map<String, List<Task>> _groupTasks(List<Task> tasks) {
    // Sort by Date Descending
    tasks.sort((a, b) {
      if (a.dueAt == null) return 1;
      if (b.dueAt == null) return -1;
      return b.dueAt!.compareTo(a.dueAt!);
    });

    final Map<String, List<Task>> groups = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var task in tasks) {
      String groupName;
      if (task.dueAt == null) {
        groupName = "No Date";
      } else {
        final taskDate = DateTime(
          task.dueAt!.year,
          task.dueAt!.month,
          task.dueAt!.day,
        );
        if (taskDate.isAfter(today.subtract(const Duration(days: 7)))) {
          groupName = "RECENT ARCHIVE";
        } else {
          groupName = DateFormat('MMMM yyyy').format(task.dueAt!).toUpperCase();
        }
      }

      if (groups.containsKey(groupName)) {
        groups[groupName]!.add(task);
      } else {
        groups[groupName] = [task];
      }
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Archive',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.tune, color: Colors.white70),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  hintText: 'Search archived tasks...',
                  hintStyle: GoogleFonts.inter(color: Colors.white24),
                  prefixIcon: const Icon(Icons.search, color: Colors.white24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: GoogleFonts.inter(
                            color: isSelected ? Colors.white : Colors.white54,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Task List
            Expanded(
              child: tasksAsync.when(
                data: (allTasks) {
                  // 1. Filter Completed
                  var filtered = allTasks
                      .where((t) => t.isCompleted == true)
                      .toList();
                  // 2. Apply Time Filter
                  filtered = _applyTimeFilter(filtered);
                  // 3. Apply Search
                  filtered = _applySearch(filtered);
                  // 4. Group
                  final groupedTasks = _groupTasks(filtered);

                  if (groupedTasks.isEmpty) {
                    return Center(
                      child: Text(
                        'No archived tasks found',
                        style: GoogleFonts.inter(color: Colors.white30),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    itemCount: groupedTasks.length,
                    itemBuilder: (context, index) {
                      final groupName = groupedTasks.keys.elementAt(index);
                      final tasks = groupedTasks[groupName]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              groupName,
                              style: GoogleFonts.inter(
                                color: Colors.white30,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          ...tasks.map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: DetailedTaskCard(task: task),
                            ),
                          ),
                        ],
                      );
                    },
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
}
