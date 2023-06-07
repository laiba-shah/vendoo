import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendoo/widgets/chatbutton.dart';
import 'package:vendoo/screens/home/bloc/home_bloc.dart';
import 'package:vendoo/screens/home/ui/homepage.dart';

void main() {
  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    // Create a dummy HomeBloc
    HomeBloc homeBloc = HomeBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<HomeBloc>.value(
        value: homeBloc,
        child: HomePage(key: const ValueKey('myHomePage')),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);
    expect(
        find.byType(ElevatedButton),
        findsNWidgets(
            3)); //Login, Signup, and Chat buttons are all ElevatedButtons
  });

  testWidgets('Buttons can be pressed', (WidgetTester tester) async {
    HomeBloc homeBloc = HomeBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<HomeBloc>.value(
        value: homeBloc,
        child: HomePage(key: const ValueKey('myHomePage')),
      ),
    ));

    final loginButton = find.widgetWithText(ElevatedButton, 'Log in');
    expect(loginButton, findsOneWidget);
    await tester.tap(loginButton);
    await tester.pump();

    final signupButton = find.widgetWithText(ElevatedButton, 'Sign up');
    expect(signupButton, findsOneWidget);
    await tester.tap(signupButton);
    await tester.pump();

    // If ChatButton has a unique icon, for example Icons.chat, we can find it by that
    final chatButton = find.widgetWithIcon(ElevatedButton, Icons.chat);
    expect(chatButton, findsOneWidget);
    await tester.tap(chatButton);
    await tester.pump();
  });
}
