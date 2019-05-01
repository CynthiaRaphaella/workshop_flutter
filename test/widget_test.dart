// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:workshop_flutter/main.dart';

void main() {
  testWidgets('Text is still being displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the todo widget is displayed
    expect(find.text('Texto'), findsWidgets);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the todo widget is still displayed
    expect(find.text('Texto'), findsWidgets);
  });

  testWidgets('Update opacity and style when checkbox is checked', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(MyApp());

    expect(tester.getSemantics(find.byType(Checkbox).first), matchesSemantics(
      hasCheckedState: true,
      hasEnabledState: true,
      isEnabled: true,
      hasTapAction: true,
      isChecked: false
    ));

    expect(tester.firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity, 1);
    expect(tester.firstWidget<Text>(find.byType(Text)).style.fontStyle, FontStyle.normal);

    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();

    expect(tester.firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity, 0.5);
    expect(tester.firstWidget<Text>(find.byType(Text)).style.fontStyle, FontStyle.italic);

    expect(tester.getSemantics(find.byType(Checkbox).first), matchesSemantics(
      hasCheckedState: true,
      hasEnabledState: true,
      isEnabled: true,
      hasTapAction: true,
      isChecked: true
    ));

    handle.dispose();
  });
}
