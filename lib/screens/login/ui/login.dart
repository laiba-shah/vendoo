import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/screens/chat/ui/chat.dart';
import 'package:vendoo/screens/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../signup/ui/signup.dart';
import '../../../api/apis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc loginBloc = LoginBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String error = '';
  bool isReady = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      await APIs.auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }

    on FirebaseAuthException catch (e) {
        //error = e.message.toString();
        if(e.message.toString().contains('wrong-password')){
          error = 'Your password is incorrect';
        }
        else if (e.message.toString().contains('invalid-email')){
          error = 'Your email address is invalid';
        }
        else if(e.message.toString().contains('user-not-found')){
          error = 'This user does not exist';
        }
        else if(e.message.toString().contains('unknown')){
          error = 'unknown error';
        }
        //print('FirebaseAuthException: ${e.code}');
        print('this is the error message: $error');
      }

      //set isReady to true once the try catch block has completed
      setState(() {
        isReady = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>.value(
      value: loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        // listenWhen: (previous, current) => current is LoginActionState,
        // buildWhen: (previous, current) => current is! LoginActionState,
        listener: (context, state) {
          if (state is SignUpPageNavigateState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignupPage()));
          } else if (state is LoginSubmittedInfoState) {
            login();
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
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: StreamBuilder<User?>(
                stream: APIs.auth.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  } else if (snapshot.hasData) {
                    return ChatRoomJoiningPage();
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: true,
                        title: const Text('Login'),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/ventooV.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
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
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  loginBloc
                                      .add(LoginPageSubmitButtonPressedEvent());
                                },
                                child: const Text('Submit'),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  loginBloc
                                      .add(LoginPageSignUpPageNavigateEvent());
                                },
                                child: const Text(
                                  "Don't have an account? Sign Up",
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
                }),
          );
        },
      ),
    );
  }
}
