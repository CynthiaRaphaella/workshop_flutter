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

  _createTodoItem(WidgetTester tester) async{
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), "New item to be done");
    await tester.tap(find.byKey(Key("Add")));
    await tester.pumpAndSettle();
  }
  
  testWidgets('Todo is only added when has a confirmation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the todo widget is displayed
    expect(find.text('Texto'), findsNothing);

    await _createTodoItem(tester);

    // Verify that the todo item was created
    expect(find.text("New item to be done"), findsWidgets);
  });

  testWidgets('Update opacity and style when checkbox is checked', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(MyApp());

    await _createTodoItem(tester);

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
