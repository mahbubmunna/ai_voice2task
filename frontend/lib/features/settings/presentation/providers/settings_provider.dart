import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

enum SilenceDuration {
  short, // 0.7s
  normal, // 1.0s
  long, // 1.3s
}

// Helper to convert to milliseconds
extension SilenceDurationExtension on SilenceDuration {
  int get milliseconds {
    switch (this) {
      case SilenceDuration.short:
        return 700;
      case SilenceDuration.normal:
        return 1000;
      case SilenceDuration.long:
        return 1300;
    }
  }
}

enum ReminderTime { atDueTime, tenMinBefore, oneHourBefore, nightBefore }

enum TonightTime {
  eightPm, // 20
  ninePm, // 21
  tenPm, // 22
}

class SettingsState {
  // 1. Voice & Language
  final String language; // 'auto', 'bn', 'en'
  final bool onDeviceSTT;

  // 2. Recording Behavior
  final bool autoStopRecording;
  final SilenceDuration silenceDuration;
  final int maxRecordingLength; // 10, 15, 30

  // 3. Reminder Defaults
  final ReminderTime defaultReminder;
  final TonightTime tonightTime;

  // 4. Smart Behavior
  final bool autoCreateTask;
  final bool askClarification;
  final bool splitTasks;

  const SettingsState({
    this.language = 'auto', // Auto (recommended)
    this.onDeviceSTT = false,
    this.autoStopRecording = true, // Default ON
    this.silenceDuration = SilenceDuration.normal, // Default 1.0s
    this.maxRecordingLength = 15, // Default 15s
    this.defaultReminder = ReminderTime.oneHourBefore, // Default 1 hr
    this.tonightTime = TonightTime.ninePm, // Default 9:00 PM
    this.autoCreateTask = false, // Default OFF
    this.askClarification = true, // Default ON
    this.splitTasks = true, // Default ON
  });

  SettingsState copyWith({
    String? language,
    bool? onDeviceSTT,
    bool? autoStopRecording,
    SilenceDuration? silenceDuration,
    int? maxRecordingLength,
    ReminderTime? defaultReminder,
    TonightTime? tonightTime,
    bool? autoCreateTask,
    bool? askClarification,
    bool? splitTasks,
  }) {
    return SettingsState(
      language: language ?? this.language,
      onDeviceSTT: onDeviceSTT ?? this.onDeviceSTT,
      autoStopRecording: autoStopRecording ?? this.autoStopRecording,
      silenceDuration: silenceDuration ?? this.silenceDuration,
      maxRecordingLength: maxRecordingLength ?? this.maxRecordingLength,
      defaultReminder: defaultReminder ?? this.defaultReminder,
      tonightTime: tonightTime ?? this.tonightTime,
      autoCreateTask: autoCreateTask ?? this.autoCreateTask,
      askClarification: askClarification ?? this.askClarification,
      splitTasks: splitTasks ?? this.splitTasks,
    );
  }
}

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  @override
  SettingsState build() {
    return const SettingsState();
  }

  // 1. Voice & Language
  void updateLanguage(String value) {
    state = state.copyWith(language: value);
  }

  void toggleOnDeviceSTT(bool value) {
    state = state.copyWith(onDeviceSTT: value);
  }

  // 2. Recording Behavior
  void toggleAutoStopRecording(bool value) {
    state = state.copyWith(autoStopRecording: value);
  }

  void updateSilenceDuration(SilenceDuration value) {
    state = state.copyWith(silenceDuration: value);
  }

  void updateMaxRecordingLength(int value) {
    state = state.copyWith(maxRecordingLength: value);
  }

  // 3. Reminder Defaults
  void updateDefaultReminder(ReminderTime value) {
    state = state.copyWith(defaultReminder: value);
  }

  void updateTonightTime(TonightTime value) {
    state = state.copyWith(tonightTime: value);
  }

  // 4. Smart Behavior
  void toggleAutoCreateTask(bool value) {
    state = state.copyWith(autoCreateTask: value);
  }

  void toggleAskClarification(bool value) {
    state = state.copyWith(askClarification: value);
  }

  void toggleSplitTasks(bool value) {
    state = state.copyWith(splitTasks: value);
  }
}
