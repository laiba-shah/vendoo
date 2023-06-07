import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vendoo/screens/splash/splash.dart';
import 'package:vendoo/screens/home/ui/homepage.dart';

void main(){
  // Widget Test for SplashScreen
  testWidgets('SplashScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(ScaleTransition), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // wait for the animation to complete
    await tester.pumpAndSettle(Duration(seconds: 2));

    // Verify if after the animation completes, it navigates to the home screen.
    expect(find.byType(HomePage), findsOneWidget); // Assuming '/home' route contains a widget of type HomePage.
  });
}