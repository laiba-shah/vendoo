import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vendoo/widgets/plainbutton.dart';

void main() {
  // Widget Test for LoginSignupButton
  testWidgets('LoginSignupButton UI Test', (WidgetTester tester) async {
    const String buttonText = 'Test Button';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginSignupButton(
            text: buttonText,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byType(LoginSignupButton), findsOneWidget);
    expect(find.text(buttonText), findsOneWidget);
  });

  // Widget Test for SplashScreen
}
