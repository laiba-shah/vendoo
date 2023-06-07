import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vendoo/screens/signup/ui/signup.dart';

void main() {
  group('SignupPage Test', () {
    test('Check Passwords Match', () {
//   final signupState = SignupPageState();

//   signupState.passwordController.text = '123456';
//   signupState.confirmPasswordController.text = '123456';

//   signupState.checkPasswordsMatch();

//   expect(signupState.passwordsMatch, true);

//   signupState.passwordController.text = '123456';
//   signupState.confirmPasswordController.text = '1234567';

//   signupState.checkPasswordsMatch();

//   expect(signupState.passwordsMatch, false);
    });

    testWidgets('Sign Up Page widget test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignupPage()));

      // Verify the presence of certain widgets
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Already have an account? Login'), findsOneWidget);
    });
  });
}
