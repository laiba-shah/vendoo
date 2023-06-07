import 'dart:js_interop';

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
  UserCredential? userCredential;
  String error = '';
  bool isReady = false; // to check if the error has been registered or not

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
      } on FirebaseAuthException catch (e) {
        //error = e.message.toString();
        if (e.message.toString().contains('email-already-in-use')) {
          error = 'This email is already in use';
        } else if (e.message.toString().contains('invalid-email')) {
          error = 'Your email address is invalid';
        } else if (e.message.toString().contains('weak-password')) {
          error = 'Your password is weak';
        } else if (e.message.toString().contains('unknown')) {
          error = 'unknown error';
        }
        //print('FirebaseAuthException: ${e.code}');
        print('this is the error message: $error');
      }

      //set the state to ready once the try catch block is complete
      setState(() {
        isReady = true;
      });

      if (userCredential != null && userCredential!.user != null) {
        // User creation successful
        await APIs.createUser();
      } else {
        // User creation failed
        print('User creation failed: userCredential or user is null.');
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
          automaticallyImplyLeading: true,
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
                  if (isReady) {
                    if (error == '') // there is no error
                    {
                      print('no error');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ChatRoomJoiningPage())));
                    }
                    // an error exists
                    else {
                      SnackBar snackBar = SnackBar(content: Text('$error'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LoginPage())));
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
