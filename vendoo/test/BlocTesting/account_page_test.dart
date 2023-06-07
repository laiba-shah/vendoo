import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vendoo/screens/account/ui/account.dart';
import 'package:vendoo/models/chat_user.dart';

void main() {
  final ChatUser user = ChatUser(
    image: '',
    lastActive: '',
    createdAt: '',
    isOnline: false,
    pushToken: '',
    id: 'testUid',
    name: 'testName',
    email: 'testEmail@test.com',
    about: 'testAbout',
  );

  group('AccountPage Test', () {
    test('Toggle Editing Test', () {
      final accountPageState = AccountPageState();

      expect(accountPageState.isEditing, false);
      expect(accountPageState.showSaveButton, false);

      accountPageState.toggleEditing();

      expect(accountPageState.isEditing, true);
      expect(accountPageState.showSaveButton, true);
    });

    testWidgets('AccountPage widget test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: AccountPage(user: user)));

      // Verify the presence of certain widgets
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Manage Account'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text(user.name), findsOneWidget);
      expect(find.text(user.about), findsOneWidget);
      expect(find.text(user.email), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });
  });
}