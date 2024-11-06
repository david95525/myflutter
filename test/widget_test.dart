// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './wigget_example.dart';

void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const TodoList());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');
    // Tap the add button.
    await tester.tap(find.byType(FloatingActionButton));
    // Rebuild the widget after the state has changed.
    await tester.pump();
    // Expect to find the item on screen.
    expect(find.text('hi'), findsOneWidget);

    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), const Offset(500, 0));
    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();
    // Ensure that the item is no longer on screen.
    expect(find.text('hi'), findsNothing);
  });
}
