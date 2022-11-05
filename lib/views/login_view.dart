// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:new_test/widgets/sign_view_widgets.dart';
import '../user_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();

    super.dispose();
  }

  bool unPress = true;

  //Button unPress Logic
  void loading() {
    setState(() {
      if (unPress == false) {
        unPress = true;
      } else {
        unPress = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            signHeader('New Test', 'Welcome back, you\'ve been missed!'),
            SizedBox(
              height: 80,
            ),
            textfield('Email', _email, false), //email textfield
            SizedBox(
              height: 10,
            ),
            textfield('Password', _password, false), //password Textfield
            SizedBox(
              height: 10,
            ),
            signBtn("Login", logIn, _email, _password, context, loading,
                unPress), //Login button
            SizedBox(
              height: 25,
            ),
            accountOption('Not a Member?', 'Register Now', context,
                loading), //not a member? Register Now
          ]),
        ),
      ),
    );
  }
}
