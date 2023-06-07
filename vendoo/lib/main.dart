import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vendoo/screens/splash/splash.dart';
import 'package:vendoo/screens/home/ui/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCxZ-1e4LBtxYpi82i86yTRjl9NBgu1I-k",
      appId: "1:119840048542:android:424448d97c606e3cb8028f",
      messagingSenderId: "119840048542",
      projectId: "vendoo-chat",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Homepage',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              brightness:
                  themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.dark,
            ),
            home: const SplashScreen(), // Display the splash screen first
            routes: {
              '/home': (context) => HomePage(key: const ValueKey('myHomePage')),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
