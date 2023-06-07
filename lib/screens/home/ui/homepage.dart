import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendoo/screens/chat/ui/chat.dart';
import 'package:vendoo/screens/login/ui/login.dart';
import 'package:vendoo/screens/signup/ui/signup.dart';
import '../../../main.dart';
import 'package:provider/provider.dart';
import '../../../widgets/chatbutton.dart';
import '../../../widgets/plainbutton.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc();

  HomePage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>.value(
      value: homeBloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeLoginPageNavigateActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          } else if (state is HomeSignPageUpNavigateActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignupPage()));
          } else if (state is HomeChatPageNavigateActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatRoomJoiningPage()));
          }
        },
        builder: (context, state) {
          final homeBloc = BlocProvider.of<HomeBloc>(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Positioned(
                  // top: 30,
                  // right: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                      icon: Icon(
                        Provider.of<ThemeProvider>(context).isDarkMode
                            ? Icons.nightlight_round
                            : Icons.wb_sunny_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Ventoo.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      LoginSignupButton(
                        text: 'Log in',
                        onPressed: () {
                          homeBloc.add(HomepageLoginButtonNavigateEvent());
                        },
                      ),
                      const SizedBox(height: 20),
                      LoginSignupButton(
                        text: 'Sign up',
                        onPressed: () {
                          homeBloc.add(HomepageSignUpButtonNavigateEvent());
                        },
                      ),
                      const SizedBox(height: 20),
                      ChatButton(
                        onPressed: () {
                          homeBloc.add(HomepageChatButtonNavigateEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
