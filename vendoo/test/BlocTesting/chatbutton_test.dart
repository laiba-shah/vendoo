import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vendoo/widgets/chatbutton.dart';

void main() {
  // Widget Test for ChatButton
  testWidgets('ChatButton UI Test', (WidgetTester tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatButton(
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    expect(find.byType(ChatButton), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);

    await tester.tap(find.byType(ChatButton));
    expect(onPressedCalled, isTrue);
  });
}