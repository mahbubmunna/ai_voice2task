import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/settings_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // 1. Voice & Language
          _buildSectionHeader('VOICE & LANGUAGE'),
          const SizedBox(height: 16),
          _buildDropdownTile<String>(
            title: 'Default Language',
            value: settings.language,
            items: const [
              DropdownMenuItem(
                value: 'auto',
                child: Text('Auto (Recommended)'),
              ),
              DropdownMenuItem(value: 'bn', child: Text('Bangla')),
              DropdownMenuItem(value: 'en', child: Text('English')),
            ],
            onChanged: (val) {
              if (val != null) notifier.updateLanguage(val);
            },
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'On-device STT',
            subtitle: 'Faster & Private',
            value: settings.onDeviceSTT,
            onChanged: notifier.toggleOnDeviceSTT,
          ),

          const SizedBox(height: 32),

          // 2. Recording Behavior
          _buildSectionHeader('RECORDING BEHAVIOR'),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'Auto-stop on Silence',
            subtitle: 'Stop recording when you stop speaking',
            value: settings.autoStopRecording,
            onChanged: notifier.toggleAutoStopRecording,
          ),
          if (settings.autoStopRecording) ...[
            const SizedBox(height: 16),
            _buildSelectionTile<SilenceDuration>(
              title: 'Silence Duration',
              value: settings.silenceDuration,
              options: const [
                (SilenceDuration.short, 'Short (0.7s)'),
                (SilenceDuration.normal, 'Normal (1.0s)'),
                (SilenceDuration.long, 'Long (1.3s)'),
              ],
              onChanged: notifier.updateSilenceDuration,
            ),
          ],
          const SizedBox(height: 16),
          _buildSelectionTile<int>(
            title: 'Max Recording Length',
            value: settings.maxRecordingLength,
            options: const [(10, '10s'), (15, '15s'), (30, '30s (Pro)')],
            onChanged: notifier.updateMaxRecordingLength,
          ),

          const SizedBox(height: 32),

          // 3. Reminder Defaults
          _buildSectionHeader('REMINDER DEFAULTS'),
          const SizedBox(height: 16),
          _buildDropdownTile<ReminderTime>(
            title: 'Default Reminder',
            value: settings.defaultReminder,
            items: const [
              DropdownMenuItem(
                value: ReminderTime.atDueTime,
                child: Text('At Due Time'),
              ),
              DropdownMenuItem(
                value: ReminderTime.tenMinBefore,
                child: Text('10 min before'),
              ),
              DropdownMenuItem(
                value: ReminderTime.oneHourBefore,
                child: Text('1 hour before'),
              ),
              DropdownMenuItem(
                value: ReminderTime.nightBefore,
                child: Text('Night before'),
              ),
            ],
            onChanged: (val) {
              if (val != null) notifier.updateDefaultReminder(val);
            },
          ),
          const SizedBox(height: 16),
          _buildDropdownTile<TonightTime>(
            title: '"Tonight" Means',
            value: settings.tonightTime,
            items: const [
              DropdownMenuItem(
                value: TonightTime.eightPm,
                child: Text('8:00 PM'),
              ),
              DropdownMenuItem(
                value: TonightTime.ninePm,
                child: Text('9:00 PM'),
              ),
              DropdownMenuItem(
                value: TonightTime.tenPm,
                child: Text('10:00 PM'),
              ),
            ],
            onChanged: (val) {
              if (val != null) notifier.updateTonightTime(val);
            },
          ),

          const SizedBox(height: 32),

          // 4. Smart Behavior
          _buildSectionHeader('SMART BEHAVIOR'),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'Auto Create Task',
            subtitle: 'Create without confirmation (risky)',
            value: settings.autoCreateTask,
            onChanged: notifier.toggleAutoCreateTask,
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'Ask Clarification',
            subtitle: 'If information is missing',
            value: settings.askClarification,
            onChanged: notifier.toggleAskClarification,
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'Split Tasks',
            subtitle: 'Automatically split multiple tasks',
            value: settings.splitTasks,
            onChanged: notifier.toggleSplitTasks,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.inter(
        color: const Color(0xFF94A3B8),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF94A3B8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile<T>({
    required String title,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              dropdownColor: const Color(0xFF1E293B),
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white70,
              ),
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionTile<T>({
    required String title,
    required T value,
    required List<(T, String)> options,
    required ValueChanged<T> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = value == option.$1;
              return GestureDetector(
                onTap: () => onChanged(option.$1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : Colors.white24,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    option.$2,
                    style: GoogleFonts.inter(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
