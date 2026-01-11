import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_voice2task_app/features/settings/presentation/settings_page.dart';

void main() {
  testWidgets('SettingsPage renders all new MVP sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsPage())),
    );

    // Verify main title
    expect(find.text('Settings'), findsOneWidget);

    // Verify sections
    expect(find.text('VOICE & LANGUAGE'), findsOneWidget); // Initially visible

    // Scroll to find other sections
    final recordingFinder = find.text('RECORDING BEHAVIOR');
    await tester.scrollUntilVisible(recordingFinder, 500);
    expect(recordingFinder, findsOneWidget);

    final reminderFinder = find.text('REMINDER DEFAULTS');
    await tester.scrollUntilVisible(reminderFinder, 500);
    expect(reminderFinder, findsOneWidget);

    final smartFinder = find.text('SMART BEHAVIOR');
    await tester.scrollUntilVisible(smartFinder, 500);
    expect(smartFinder, findsOneWidget);
  });

  testWidgets('SettingsPage interaction toggles switch', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsPage())),
    );

    // Find the On-device STT switch (starts false)
    // My custom layout has Text and Switch as siblings in a Row, so widgetWithText won't work.
    // We find the Switch by looking for the one that corresponds to the tile.
    // simpler: find all switches, we know STT is the first one based on order.
    // Or better: Find the text, getting the parent row is hard in flutter_test without keys.
    // Let's rely on type order for now as there are identifiable texts before it.

    expect(find.text('On-device STT'), findsOneWidget);
    final switchFinder = find.byType(Switch).first;

    // Tap it
    await tester.scrollUntilVisible(switchFinder, 100);
    await tester.tap(switchFinder);
    await tester.pump();

    // Check new state
    Switch switchWidget = tester.widget(switchFinder);
    expect(switchWidget.value, isTrue);
  });

  testWidgets('SettingsPage allows changing language', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsPage())),
    );

    // Find Dropdown for language
    final langDropdown = find.text('Auto (Recommended)');
    expect(langDropdown, findsOneWidget);

    // Tap to open
    await tester.tap(langDropdown);
    await tester.pumpAndSettle();

    // Select Bangla
    final banglaItem = find.text('Bangla').last;
    await tester.tap(banglaItem);
    await tester.pumpAndSettle();

    // Verify selection
    expect(find.text('Bangla'), findsOneWidget);
  });
}
