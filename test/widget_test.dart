// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:palindrome_app/main.dart';

void main() {
  testWidgets('App starts with FirstScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we have Name and Palindrome text fields
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Palindrome'), findsOneWidget);

    // Verify that we have CHECK and NEXT buttons
    expect(find.text('CHECK'), findsOneWidget);
    expect(find.text('NEXT'), findsOneWidget);
  });
}