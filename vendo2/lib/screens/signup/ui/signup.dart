import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendoo/screens/chat/ui/chat.dart';
import '../../../api/apis.dart';
import 'package:flutter/material.dart';
import '../../login/ui/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool passwordsMatch = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void checkPasswordsMatch() {
    setState(() {
      passwordsMatch =
          passwordController.text == confirmPasswordController.text;
    });
  }

  // keep the signup method like this for debuggin purposes
  Future<void> signUp() async {
    if (passwordsMatch) {
      try {
        final String email = emailController.text.trim();
        final String password = passwordController.text.trim();

        print('Email: $email');
        print('Password: $password');

        UserCredential userCredential =
            await APIs.auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential != null && userCredential.user != null) {
          // User creation successful
          await APIs.createUser();
        } else {
          // User creation failed
          print('User creation failed: userCredential or user is null.');
        }
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException: ${e.code} - ${e.message}');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<void> createUser() async {}

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Sign Up'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/ventooV.png', // Assuming the logo file is in the assets folder
                width: 30,
                height: 30,
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/Ventoo.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: passwordsMatch ? null : "Passwords do not match",
                ),
                onChanged: (value) {
                  checkPasswordsMatch();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatRoomJoiningPage()));
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> signUp() async {

//     if (passwordsMatch) {
//       await APIs.createUser().then((value) async{
//       try {
//         await APIs.auth.createUserWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text.trim());
//       } on FirebaseAuthException catch (e) {
//         print(e);
//       }
//       }
//       );
//     }
//   }
