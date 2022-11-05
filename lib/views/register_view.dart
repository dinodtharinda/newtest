import 'package:flutter/material.dart';
import '../user_auth.dart';
import '../widgets/sign_view_widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
            //hello again
            signHeader('New Test', 'Welcome back, you\'ve been missed!'),
            const SizedBox(
              height: 80,
            ),
            textfield('Email', _email, false), //Email TextField
            const SizedBox(
              height: 10,
            ),
            textfield('Password', _password, false), //Password TextField
            const SizedBox(
              height: 10,
            ),
            signBtn("Register", register, _email, _password, context, loading,
                unPress), //Register button
            const SizedBox(
              height: 25,
            ),
            accountOption('I already have an account?', 'Login here', context,
                loading), //I already have an account?
          ]),
        ),
      ),
    );
  }
}
