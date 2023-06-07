import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vendoo/widgets/chat_user_card.dart';
import 'package:vendoo/models/chat_user.dart';

void main() {
  // Widget Test for chatUserCard
  testWidgets('chatUserCard UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: chatUserCard(
            user: ChatUser(
              email: '',
              pushToken: '',
              isOnline: false,
              lastActive: '',
              createdAt: '',
              id: "testId",
              name: "testName",
              about: "testAbout",
              image: "testImage",
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('testName'), findsOneWidget);
    expect(find.text('testAbout'), findsOneWidget);
  });
}